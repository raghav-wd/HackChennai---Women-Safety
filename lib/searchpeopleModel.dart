class FIndPeople {
  String uid;
  String user;
  String lat;
  String longi;
  String dist;

  FIndPeople({this.uid, this.user, this.lat, this.longi, this.dist});

  FIndPeople.fromJson(Map<String, dynamic> json) {
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