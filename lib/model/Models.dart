class PlatformEntity {
  String address;
  String number;
  String xinimg;
  String title;

  PlatformEntity({this.address, this.number, this.xinimg, this.title});

  PlatformEntity.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    number = json['Number'];
    xinimg = json['xinimg'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['Number'] = this.number;
    data['xinimg'] = this.xinimg;
    data['title'] = this.title;
    return data;
  }
}