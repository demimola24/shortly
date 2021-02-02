
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shrtcode/data/database/entities/entities.dart';
import 'package:shrtcode/data/model/reponses/shorten_link_reponse.dart';
import 'package:shrtcode/data/repository/repository.dart';

import 'bloc.dart';

class HomeBloc implements Bloc{
  final _repo = new Repository();

  final TextEditingController textEditingController  = TextEditingController();

  final _getShortUrlSubject = PublishSubject<ShortenLinkResponse>();
  final _showProgressSubject = BehaviorSubject<bool>();
  final _allOfflineShortenLinkResponseSubject = BehaviorSubject<List<OfflineShortenLinkResponse>>();



  Stream<bool> get progressStatusStream => _showProgressSubject.stream;
  Stream<ShortenLinkResponse> get getShortUrlObservable => _getShortUrlSubject.stream;
  Stream<List<OfflineShortenLinkResponse>> get getAllOfflineShortenLinkResponseObservable => _allOfflineShortenLinkResponseSubject.stream;


  Function(bool) get showProgressBar => _showProgressSubject.sink.add;


  @override
  init() async {
    _repo.initializeDatabase();
    fetchSavedResponse();

  }

  void fetchSavedResponse() async{
    print("fetch now");
    await _repo.getAllLocalShortUrls().then((response) async {
      print("fetched ${response.length}");
      _allOfflineShortenLinkResponseSubject.sink.add(response);
    },onError: (e) {
      print("fetched $e");
      _allOfflineShortenLinkResponseSubject.sink.addError(e);
    }).catchError((e){
      print("fetched $e");
      _allOfflineShortenLinkResponseSubject.sink.addError(e);
    });

  }



  fetchShortUrl() async {
    String _url  = textEditingController.text;
    showProgressBar(true);
    await _repo.fetchShortUrl(_url)
        .then((response) {
      _getShortUrlSubject.sink.add(response);
      _repo.addOfflineShortenLinkResponse(response.toOfflineData());
      textEditingController.text = "";
      fetchSavedResponse();
      showProgressBar(false);
    }, onError: (e) {
      print("fetchShortUrl error:  $e");
      _getShortUrlSubject.sink.addError(e);
      showProgressBar(false);
    }).catchError((e){
      print("fetchShortUrl error 2:  $e");
      _getShortUrlSubject.sink.addError(e);
      showProgressBar(false);
    });
  }

  @override
    dispose() async {
      await _getShortUrlSubject.drain();
      _getShortUrlSubject.close();
      await _showProgressSubject.drain();
       _showProgressSubject.close();
      await _allOfflineShortenLinkResponseSubject.drain();
       _allOfflineShortenLinkResponseSubject.close();

    }
}