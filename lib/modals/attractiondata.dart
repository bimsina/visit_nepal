class AttractionData {
  List<Attraction>? attractionList;
  List<Attraction>? restaurantList;

  AttractionData({this.attractionList, this.restaurantList});

  AttractionData.fromJson(Map<String, dynamic> json) {
    if (json['attractionList'] != null) {
      attractionList = [];
      json['attractionList'].forEach((v) {
        attractionList?.add(new Attraction.fromJson(v));
      });
    }
    if (json['restaurantList'] != null) {
      restaurantList = [];
      json['restaurantList'].forEach((v) {
        restaurantList?.add(new Attraction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attractionList != null) {
      data['attractionList'] =
          this.attractionList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NearbyData {
  List<Attraction>? attractionList;

  NearbyData({this.attractionList});

  NearbyData.fromJson(Map<String, dynamic> json) {
    if (json['attractionByProvince'] != null) {
      attractionList = [];
      json['attractionByProvince'].forEach((v) {
        attractionList?.add(new Attraction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attractionList != null) {
      data['attractionByProvince'] =
          this.attractionList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attraction {
  String? id, name, image, district;
  int? province;
  List<String>? description, img;
  double? latitude;
  double? longitude;

  Attraction(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.latitude,
      this.longitude,
      this.img,
      this.district,
      this.province});

  Attraction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'].cast<String>();
    latitude = json['latitude'];
    longitude = json['longitude'];
    img = json['img'].cast<String>();
    district = json['district'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['img'] = this.img;
    data['district'] = this.district;
    data['province'] = this.province;
    return data;
  }
}
