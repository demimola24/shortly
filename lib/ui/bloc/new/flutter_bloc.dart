

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shrtcode/data/model/reponses/shorten_link_reponse.dart';
import 'package:shrtcode/data/repository/repository.dart';
import 'package:shrtcode/ui/bloc/new/events.dart';
import 'package:shrtcode/ui/bloc/new/states.dart';

class OnlineHomeBloc extends Bloc<ShortenLinkEvents, ShortenLinkState> {
  final Repository repo;
  final TextEditingController textEditingController;

  ShortenLinkResponse shortenLinkResponse;

  OnlineHomeBloc({this.repo, this.textEditingController})
      : super(ShortenLinkInitState());

  @override
  Stream<ShortenLinkState> mapEventToState(ShortenLinkEvents event) async* {
    switch (event) {
      case ShortenLinkEvents.fetchShortenLink:
        try {
          yield ShortenLinkLoading();
          shortenLinkResponse =
          await repo.fetchShortUrl(textEditingController.text);
          repo.addOfflineShortenLinkResponse(
              shortenLinkResponse.toOfflineData());
          textEditingController.text = "";
          yield ShortenLinkLoaded(shortenLink: shortenLinkResponse);
        } catch (e) {
          yield ShortenLinkError(
            error: e,
          );
        }
        break;
    }
  }
}

class OfflineHomeBloc extends Bloc<OfflineShortenLinkEvents, OfflineShortenLinkState> {
  final Repository repo;

  OfflineHomeBloc({this.repo}) : super(OfflineShortenLinkInitState());

  @override
  Stream<OfflineShortenLinkState> mapEventToState(OfflineShortenLinkEvents event) async* {
    switch (event) {
      case OfflineShortenLinkEvents.fetchOfflineShortenLinks:
        try{
          yield OfflineShortenLinkLoading();
          var value  = await repo.getAllLocalShortUrls();
          yield OfflineShortenLinkLoaded(list: value);
        }catch(e){
          yield OfflineShortenLinkError(error: e);
        }
        break;
    }
  }
}