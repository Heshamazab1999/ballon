
class FavoriteModel {
  List<Data>? data;
  String? msg;
  bool? status;
  int? statusCode;

  FavoriteModel({this.data, this.msg, this.status, this.statusCode});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? desc;
  int? price;
  int? stock;
  bool? isfav;
  int? availability;
  List<String>? photo;
  int? categoryId;
  List<Favusers>? favusers;

  Data(
      {this.id,
        this.name,
        this.desc,
        this.price,
        this.stock,
        this.isfav,
        this.availability,
        this.photo,
        this.categoryId,
        this.favusers});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    price = json['price'];
    stock = json['stock'];
    isfav = json['isfav'];
    availability = json['availability'];
    photo = json['photo'].cast<String>();
    categoryId = json['category_id'];
    if (json['favusers'] != null) {
      favusers = <Favusers>[];
      json['favusers'].forEach((v) {
        favusers!.add(new Favusers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['isfav'] = this.isfav;
    data['availability'] = this.availability;
    data['photo'] = this.photo;
    data['category_id'] = this.categoryId;
    if (this.favusers != null) {
      data['favusers'] = this.favusers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Favusers {
  int? id;
  String? userId;
  int? productId;
  String? createdAt;
  String? updatedAt;

  Favusers(
      {this.id, this.userId, this.productId, this.createdAt, this.updatedAt});

  Favusers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
