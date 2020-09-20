class NeedHelp {
  String uid;
  String user;
  String lat;
  String longi;
  String dist;

  NeedHelp({this.uid, this.user, this.lat, this.longi, this.dist});

  NeedHelp.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    user = json['user'];
    lat = json['lat'];
    longi = json['longi'];
    dist = json['dist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['user'] = this.user;
    data['lat'] = this.lat;
    data['longi'] = this.longi;
    data['dist'] = this.dist;
    return data;
  }
}