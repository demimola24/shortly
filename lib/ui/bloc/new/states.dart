

import 'package:equatable/equatable.dart';
import 'package:shrtcode/data/database/entities/entities.dart';
import 'package:shrtcode/data/model/reponses/shorten_link_reponse.dart';



abstract class ShortenLinkState extends Equatable {
  @override
  List<Object> get props => [];
}

class ShortenLinkInitState extends ShortenLinkState {}

class ShortenLinkLoading extends ShortenLinkState {}

class ShortenLinkLoaded extends ShortenLinkState {
  final ShortenLinkResponse shortenLink;
  ShortenLinkLoaded({this.shortenLink});
}
class ShortenLinkError extends ShortenLinkState {
  final error;
  ShortenLinkError({this.error});
}



abstract class OfflineShortenLinkState extends Equatable {
  @override
  List<Object> get props => [];
}

class OfflineShortenLinkInitState extends OfflineShortenLinkState {}

class OfflineShortenLinkLoading extends OfflineShortenLinkState {}

class OfflineShortenLinkLoaded extends OfflineShortenLinkState {
  final List<OfflineShortenLinkResponse> list;
  OfflineShortenLinkLoaded({this.list});
}
class OfflineShortenLinkError extends OfflineShortenLinkState {
  final error;
  OfflineShortenLinkError({this.error});
}