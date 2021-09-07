class HotelListData {
  List<Hotel>? hotelList;

  HotelListData({this.hotelList});

  HotelListData.fromJson(Map<String, dynamic> json) {
    if (json['hotelList'] != null) {
      hotelList = [];
      json['hotelList'].forEach((v) {
        hotelList?.add(new Hotel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hotelList != null) {
      data['hotelList'] = this.hotelList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hotel {
  String? id;
  String? name;
  List<String>? img;
  String? place;
  String? district;
  double? latitude;
  double? longitude;
  String? cost;
  int? province;
  String? description;
  String? star;
  String? url;
  List<String>? amenities;

  Hotel(
      {this.id,
      this.name,
      this.img,
      this.place,
      this.district,
      this.latitude,
      this.longitude,
      this.cost,
      this.province,
      this.description,
      this.star,
      this.url,
      this.amenities});

  Hotel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'].cast<String>();
    place = json['place'];
    district = json['district'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    cost = json['cost'];
    province = json['province'];
    description = json['description'];
    star = json['star'];
    url = json['url'];
    amenities = json['amenities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    data['place'] = this.place;
    data['district'] = this.district;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['cost'] = this.cost;
    data['province'] = this.province;
    data['description'] = this.description;
    data['star'] = this.star;
    data['url'] = this.url;
    data['amenities'] = this.amenities;
    return data;
  }
}
