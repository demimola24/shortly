import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shrtcode/data/database/entities/entities.dart';
import 'package:shrtcode/data/model/reponses/shorten_link_reponse.dart';
import 'package:shrtcode/resources/color_const.dart';
import 'package:shrtcode/resources/helper.dart';
import 'package:shrtcode/resources/imagepath.dart';
import 'package:shrtcode/resources/size_const.dart';
import 'package:shrtcode/ui/bloc/new/events.dart';
import 'package:shrtcode/ui/bloc/new/flutter_bloc.dart';
import 'package:shrtcode/ui/bloc/new/states.dart';
import 'package:shrtcode/ui/bloc/old/bloc_providers.dart';
import 'package:shrtcode/ui/bloc/old/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = new GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    _loadOfflineData();
  }

  _loadOfflineData() async {
    context.read<OfflineHomeBloc>().add(OfflineShortenLinkEvents.fetchOfflineShortenLinks,);
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    return Scaffold(
      backgroundColor: ColorPath.OFF_WHITE,
      body: Container(
        height: fullHeight(context),
        width:  fullWidth(context),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(color: ColorPath.OFF_WHITE),
        padding: EdgeInsets.all(0.0),
        margin: EdgeInsets.only(top: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: SizePath.DP_24,right: SizePath.DP_24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      ImagePath.LOGO,
                    ),

                    IconButton(icon: Icon(Icons.dehaze,color: ColorPath.GRAYISH_VIOLET,), onPressed: (){

                    })
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: SizePath.DP_24,right: SizePath.DP_24),
                child: SvgPicture.asset(
                  ImagePath.ILLUSTRATION_WORKING,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: SizePath.DP_24,right: SizePath.DP_24),
                child: Text("More than just shorter links",textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(color: ColorPath.VERY_DARK_BLUE, fontSize: 52,fontWeight: FontWeight.w700,height:1.1)),
              ),
              Container(
                margin: EdgeInsets.only(left: SizePath.DP_24,right: SizePath.DP_24, top:SizePath.DP_16 ),
                child: Text("Build your brand's recognition and get detailed insights on how your links are performing ",textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(color: ColorPath.GRAYISH_VIOLET, fontSize: 18,fontWeight: FontWeight.normal,height:1.5)),
              ),
              Container(
                height: 56,
                width: 160,
                margin: EdgeInsets.only(top:SizePath.DP_24 ),
                child: Material(  //Wrap with Material
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(26.0) ),
                  clipBehavior: Clip.antiAlias, // Add This
                  child: MaterialButton(
                    height: 56,
                    color: ColorPath.PRIMARY_CYAN,
                    child: Text(
                        'Get Started',
                        style: new TextStyle(fontSize: 18, color: Colors.white)),
                    onPressed:() async {

                    },
                  ),
                ),
              ),
              BlocBuilder<OnlineHomeBloc, ShortenLinkState>(
                  builder: (BuildContext context, ShortenLinkState state) {
                    if(state is ShortenLinkLoaded){
                      _loadOfflineData();
                    }
                    return  Container(
                      height: 180,
                      margin: EdgeInsets.only(left: SizePath.DP_16,right: SizePath.DP_16, top: SizePath.DP_16),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: ColorPath.PRIMARY_DARK_VIOLET,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          border:Border.all(color: ColorPath.SEC_RED,width: 2)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: SizePath.DP_16,right: SizePath.DP_16, top: SizePath.DP_16),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                border:Border.all(color: ColorPath.SEC_RED,width: 2),
                                color:  Colors.white),
                            height: 56.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Form(
                                key: formKey,
                                child: TextFormField(
                                  controller: context.read<OnlineHomeBloc>().textEditingController,
                                  cursorColor: ColorPath.PRIMARY_CYAN,
                                  textAlign: TextAlign.left,
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.url,
                                  validator: (value) {
                                    return value.isEmpty ? 'Url is Required.' : null;
                                  },
                                  decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                        color: Colors.redAccent,
                                      ),
                                      hintText: "Shorten a link here",
                                      hintStyle: TextStyle(color: ColorPath.GRAY, fontSize: 16),
                                      border: InputBorder.none,
                                      errorText: (state is ShortenLinkError)? state.error:null),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 56,
                            width: fullWidth(context),
                            margin: EdgeInsets.only(left: SizePath.DP_16,right: SizePath.DP_16, bottom: SizePath.DP_16),
                            child: Material(  //Wrap with Material
                              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8.0) ),
                              clipBehavior: Clip.antiAlias, // Add This
                              child: MaterialButton(
                                height: 56,
                                color: state is ShortenLinkLoading ? ColorPath.VERY_DARK_VIOLET:ColorPath.PRIMARY_CYAN,
                                child: Text(
                                    state is ShortenLinkLoading ?'Please wait!': "Shorten It",
                                    style: GoogleFonts.poppins(color: ColorPath.WHITE, fontSize: 18,fontWeight: FontWeight.normal)
                                ),
                                onPressed:() async {
                                  if(state is ShortenLinkLoading){
                                    return;
                                  }
                                  if(formKey.currentState.validate()){
                                    context.read<OnlineHomeBloc>().add(ShortenLinkEvents.fetchShortenLink);
                                  }
                                },
                              ),
                            ),
                          ),

                        ],
                      ),
                    );
                  }),
              BlocBuilder<OfflineHomeBloc, OfflineShortenLinkState>(
                  builder: (BuildContext context, OfflineShortenLinkState state) {
                    if (state is OfflineShortenLinkLoaded) {
                      final list = state.list;
                      return Container(
                        margin: EdgeInsets.only(top:SizePath.DP_24 ),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            EdgeInsets padding = index == 0
                                ? const EdgeInsets.only(
                                left: 16.0, right: 8.0, top: 24.0, bottom: 8.0)
                                : const EdgeInsets.only(
                                left: 16.0, right: 8.0, top: 8, bottom: 8.0);

                            return Container(
                              height: 200,
                              margin: EdgeInsets.only(left: SizePath.DP_16,right: SizePath.DP_16, bottom: SizePath.DP_8),
                              width: fullWidth(context),
                              decoration: BoxDecoration(
                                  color: ColorPath.WHITE,
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: SizePath.DP_24,right: SizePath.DP_24, top:SizePath.DP_16 ),
                                    child: Text(list[index].originalLink,textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(color: ColorPath.GRAYISH_VIOLET, fontSize: 18,fontWeight: FontWeight.normal,height:1.5)),
                                  ),
                                  Divider(),
                                  Container(
                                    margin: EdgeInsets.only(left: SizePath.DP_24,right: SizePath.DP_24, top:SizePath.DP_16 ),
                                    child: Text(list[index].fullShortLink,textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(color: ColorPath.GRAYISH_VIOLET, fontSize: 18,fontWeight: FontWeight.normal,height:1.5)),
                                  ),
                                  Container(
                                    height: 56,
                                    width: fullWidth(context),
                                    margin: EdgeInsets.only(left: SizePath.DP_16,right: SizePath.DP_16, bottom: SizePath.DP_16,top: SizePath.DP_8),
                                    child: Material(  //Wrap with Material
                                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8.0) ),
                                      clipBehavior: Clip.antiAlias, // Add This
                                      child: MaterialButton(
                                        height: 40,
                                        color: ColorPath.PRIMARY_CYAN,
                                        child: Text(
                                            "Copy",
                                            style: GoogleFonts.poppins(color: ColorPath.WHITE, fontSize: 18,fontWeight: FontWeight.normal)
                                        ),
                                        onPressed:() async {
                                          Clipboard.setData(ClipboardData(text:list[index].fullShortLink))
                                              .then((value) {

                                          });
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          scrollDirection: Axis.vertical,
                          itemCount: list.length,
                        ),
                      );
                    }
                    return SizedBox();
                  }),

            ],
          ),
        ),
      ),
    );
  }

}
