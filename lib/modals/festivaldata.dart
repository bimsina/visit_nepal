class FestivalData {
  List<Festival>? festivalList;

  FestivalData({this.festivalList});

  FestivalData.fromJson(Map<String, dynamic> json) {
    if (json['festivalList'] != null) {
      festivalList = [];
      json['festivalList'].forEach((v) {
        festivalList?.add(new Festival.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.festivalList != null) {
      data['festivalList'] = this.festivalList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Festival {
  String? id;
  String? name;
  List<String>? img;
  String? image;
  List<String>? description;

  Festival({this.id, this.name, this.img, this.image, this.description});

  Festival.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'].cast<String>();
    image = json['image'];
    description = json['description'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}
