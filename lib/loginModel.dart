class Login {
  String uid;
  String user;
  String email;
  String password;
  String lat;
  String longi;
  String place;
  String noti;

  Login(
      {this.uid,
      this.user,
      this.email,
      this.password,
      this.lat,
      this.longi,
      this.place,
      this.noti});

  Login.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    user = json['user'];
    email = json['email'];
    password = json['password'];
    lat = json['lat'];
    longi = json['longi'];
    place = json['place'];
    noti = json['noti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['user'] = this.user;
    data['email'] = this.email;
    data['password'] = this.password;
    data['lat'] = this.lat;
    data['longi'] = this.longi;
    data['place'] = this.place;
    data['noti'] = this.noti;
    return data;
  }
}