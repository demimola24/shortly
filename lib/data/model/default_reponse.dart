

class ResponseWrapper<T> {
  bool ok;
  T result;

  ResponseWrapper({this.ok, this.result});

  ResponseWrapper.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    result =
    json['result'] != null ? json['result'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.result != null) {
      data['result'] = this.result;
    }
    return data;
  }
}

enum ReportDateFilterType {
  TODAY,
  YESTERDAY,
  THIS_WEEK,
  THIS_MONTH,
  THIS_YEAR

}
