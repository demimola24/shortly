
import 'package:shrtcode/data/database/entities/entities.dart';

class ShortenLinkResponse {
  String code;
  String shortLink;
  String fullShortLink;
  String shortLink2;
  String fullShortLink2;
  String shareLink;
  String fullShareLink;
  String originalLink;

  ShortenLinkResponse(
      {this.code,
        this.shortLink,
        this.fullShortLink,
        this.shortLink2,
        this.fullShortLink2,
        this.shareLink,
        this.fullShareLink,
        this.originalLink});

  ShortenLinkResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    shortLink = json['short_link'];
    fullShortLink = json['full_short_link'];
    shortLink2 = json['short_link2'];
    fullShortLink2 = json['full_short_link2'];
    shareLink = json['share_link'];
    fullShareLink = json['full_share_link'];
    originalLink = json['original_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['short_link'] = this.shortLink;
    data['full_short_link'] = this.fullShortLink;
    data['short_link2'] = this.shortLink2;
    data['full_short_link2'] = this.fullShortLink2;
    data['share_link'] = this.shareLink;
    data['full_share_link'] = this.fullShareLink;
    data['original_link'] = this.originalLink;
    return data;
  }

  OfflineShortenLinkResponse toOfflineData() {
    return OfflineShortenLinkResponse(code: this.code,fullShortLink: this.fullShortLink, originalLink: this.originalLink);
  }
}