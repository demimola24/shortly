

class ResponseWrapper<T> {
  bool ok;
  T result;
  String error;

  ResponseWrapper({this.ok, this.result, this.error});

  ResponseWrapper.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    result =
    json['result'] != null ? json['result'] : null;
    error =
    json['error'] != null ? json['error'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.result != null) {
      data['result'] = this.result;
    }
    if (this.error != null) {
      data['error'] = this.result;
    }
    return data;
  }
}
