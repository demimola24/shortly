
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:shrtcode/data/model/reponses/shorten_link_reponse.dart';
import 'package:shrtcode/data/repository/repository.dart';

import 'bloc.dart';

class HomeBloc implements Bloc{
  final _repo = new Repository();

  final _getShortUrlSubject = PublishSubject<ShortenLinkResponse>();
  final _showProgressSubject = BehaviorSubject<bool>();


  Stream<bool> get progressStatusStream => _showProgressSubject.stream;
  Stream<ShortenLinkResponse> get getShortUrlObservable => _getShortUrlSubject.stream;
  Function(bool) get showProgressBar => _showProgressSubject.sink.add;


  @override
  init() async {
    _repo.initializeDatabase();
  }



  fetchShortUrl(String url) async {
    await _repo.fetchShortUrl(url)
        .then((response) {
      _getShortUrlSubject.sink.add(response);
      _repo.addOfflineSaleRecord(response.toOfflineData());
    }, onError: (e) {
      print("fetchShortUrl error:  $e");
      _getShortUrlSubject.sink.addError(e);
    }).catchError((e){
      print("fetchShortUrl error 2:  $e");
      _getShortUrlSubject.sink.addError(e);
    });
  }

  @override
    dispose() async {
      await _getShortUrlSubject.drain();
      _getShortUrlSubject.close();
      _showProgressSubject.drain();
      await _showProgressSubject.close();

    }
}