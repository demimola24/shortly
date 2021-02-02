
import 'package:floor/floor.dart';

@entity
class OfflineShortenLinkResponse {
  @PrimaryKey(autoGenerate: true)
  int id;
  String code;
  String fullShortLink;
  String originalLink;

  OfflineShortenLinkResponse(
      {this.code,
        this.fullShortLink,
        this.originalLink});


  OfflineShortenLinkResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    fullShortLink = json['full_short_link'];
    originalLink = json['original_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['full_short_link'] = this.fullShortLink;
    data['original_link'] = this.originalLink;
    return data;
  } 
}

