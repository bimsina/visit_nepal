class RestaurantData {
  List<Restaurant>? restaurantList;
  List<Restaurant>? cafeList;
  List<Restaurant>? pubList;
  RestaurantData({this.restaurantList, this.cafeList, this.pubList});

  RestaurantData.fromJson(Map<String, dynamic> json) {
    if (json['restaurantList'] != null) {
      restaurantList = [];
      json['restaurantList'].forEach((v) {
        restaurantList?.add(new Restaurant.fromJson(v));
      });
    }
    if (json['cafeList'] != null) {
      cafeList = [];
      json['cafeList'].forEach((v) {
        cafeList?.add(new Restaurant.fromJson(v));
      });
    }
    if (json['pubList'] != null) {
      pubList = [];
      json['pubList'].forEach((v) {
        pubList?.add(new Restaurant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurantList != null) {
      data['restaurantList'] =
          this.restaurantList?.map((v) => v.toJson()).toList();
    }
    if (this.cafeList != null) {
      data['cafeList'] = this.cafeList?.map((v) => v.toJson()).toList();
    }
    if (this.pubList != null) {
      data['pubList'] = this.pubList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NearbyData {
  List<Restaurant>? restaurantList;

  NearbyData({this.restaurantList});

  NearbyData.fromJson(Map<String, dynamic> json) {
    if (json['RestaurantByProvince'] != null) {
      restaurantList = [];
      json['RestaurantByProvince'].forEach((v) {
        restaurantList?.add(new Restaurant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurantList != null) {
      data['restaurantByProvince'] =
          this.restaurantList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurant {
  String? id, name, image, district, description;
  int? province;
  List<String>? img;
  double? latitude;
  double? longitude;

  Restaurant(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.latitude,
      this.longitude,
      this.img,
      this.district,
      this.province});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
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
