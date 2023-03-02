import 'package:arrows/modules/sign_up/models/user_model.dart';

class SearchModel {
  List<Data>? data;
  String? msg;
  int? nextPage;
  bool? status;
  int? statusCode;

  SearchModel(
      {this.data, this.msg, this.nextPage, this.status, this.statusCode});

  SearchModel.fromJson(Map<String, dynamic> json) {
    // if (json['data'] != null) {
    //   data = <Data>[];
      // json['data'].forEach((v) {
      //   data!.add(new Data.fromJson(v));
      // });
          // }
    if (json['data'] != '' && json['data'] != null) {
      data =  <Data>[]; json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));});}
    msg = json['msg'];
    nextPage = json['nextPage'];
    status = json['status'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    data['nextPage'] = this.nextPage;
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
  List<dynamic>? photo;
  int? categoryId;
  List<User>? favusers;

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
     // photo = json['photo'] as String();
     photo = json['photo']!=null ?json['photo'] as dynamic :json['photo'].cast<String>();
    categoryId = json['category_id'];
    if (json['favusers'] !=null) {
      favusers = <User>[];
      json['favusers'].forEach((v) {
        favusers!.add(new User.fromJson(v));
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

