import 'dart:convert';
import 'package:flutter/material.dart';


//Payload payloadFromJson(String str) => Payload.fromJson(json.decode(str));

//String payloadToJson(Payload data) => json.encode(data.toJson());

class Payload extends ChangeNotifier{
  Payload({
    required this.success,
    required this.meta_data,
    required this.data,
  });

  String success;
  Map<String,dynamic> meta_data;
  List<CampaignModel> data;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    success: json["success"],
    meta_data: json["meta_data"],
    data: List<CampaignModel>.from(
        json["data"].map((x) => CampaignModel.fromJson(x),
        ),
    ),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "meta_data": meta_data,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}



class CampaignModel extends ChangeNotifier{
  int? id;
  int? user_response_count;
  String? name;
  String? description;
  String? start_date;
  String? end_date;
  String? image;
  bool? is_active;

  CampaignModel({
    this.id,
    this.name,
    this.user_response_count,
    this.description,
    this.image,
    this.start_date,
    this.end_date,
    this.is_active,
  });

  CampaignModel.fromJson(Map<String,dynamic> json){
        id = json['id'];
        name = json['name'];
        description = json['description'];
        image = json["image"];
        user_response_count = json['user_response_count'];
        start_date = json['start_date'];
        end_date = json['end_date'];
        is_active = json['is_active'];
  }

  Map<String,dynamic> toJson() {
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_response_count'] = this.user_response_count;
    data['image'] = this.image;
    data['description'] = this.description;
    data['start_date'] = this.start_date;
    data['end_date'] = this.end_date;
    data['is_active'] = this.is_active;
    return data;
  }

  static List<CampaignModel> listFromJson(List<dynamic> list) =>
      List<CampaignModel>.from(list.map((x) => CampaignModel.fromJson(x)));
}




class SurveyModel extends ChangeNotifier{
  int? id;
  //List<QuestionModel>? question_set;
  String? name;
  bool? is_active;
  int? response_count;

  SurveyModel({
    this.id,
    this.name,
    //this.question_set,
    this.is_active,
    this.response_count
  });

  SurveyModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    is_active = json['is_active'];
    response_count = json['response_count'];
    /*question_set = List<QuestionModel>.from(
      json['question_set'].map((x)=>QuestionModel.fromJson(x),),);*/
  }

  Map<String,dynamic> toJson() {
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_active'] = this.is_active;
    data['response_count'] = this.response_count;
    //data['question_set'] = List<dynamic>.from(question_set!.map((x) => x.toJson()));
    return data;
  }

  static List<SurveyModel> listFromJson(List<dynamic> list) =>
      List<SurveyModel>.from(list.map((x) => SurveyModel.fromJson(x)));

}



class QuestionModel extends ChangeNotifier{
   int? id;
   String? question;
   String? type;
   List<dynamic>? choices;
   bool? is_required;
   bool? is_active;

   QuestionModel({
     this.id,
     this.question,
     this.type,
     this.choices,
     this.is_required,
     this.is_active,
   });

   QuestionModel.fromJson(Map<String,dynamic> json){
     id = json['id'];
     question = json['question'];
     type = json['type'];
     choices = json['choices'];
     is_required = json['is_required'];
     is_active = json['is_active'];
   }

   Map<String,dynamic> toJson() {
     final Map<String,dynamic> data = new Map<String,dynamic>();
     data['id'] = this.id;
     data['question'] = this.question;
     data['type'] = this.type;
     data['choices'] = this.choices;
     data['is_required'] = this.is_required;
     data['is_active'] = this.is_active;
     return data;
   }

   static List<QuestionModel> listFromJson(List<dynamic> list) =>
       List<QuestionModel>.from(list.map((x) => QuestionModel.fromJson(x)));
}

class UserModel extends ChangeNotifier{
  int? id;
  String? username;
  String? phone;
  String? first_name;
  String? last_name;
  bool? is_active;
  String? email;
  bool? is_superuser;
  bool? is_staff;
  String? profile_pic_url;
  String? address;
  String? gender;
  bool? verified;
  String? user_status;
  String? type;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.first_name,
    this.last_name,
    this.is_active,
    this.address,
    this.gender,
    this.is_staff,
    this.is_superuser,
    this.phone,
    this.profile_pic_url,
    this.user_status,
    this.verified,
    this.type,
  });

  UserModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    username = json['username'];
    phone = json['phone'];
    first_name = json["first_name"];
    last_name = json['last_name'];
    is_active = json['is_active'];
    email = json['email'];
    is_superuser = json['is_superuser'];
    is_staff = json['is_staff'];
    profile_pic_url = json['profile_pic_url'];
    address = json['address'];
    gender = json['gender'];
    verified = json['verified'];
    user_status = json['user_status'];
    type = json['type'];
  }

  Map<String,dynamic> toJson() {
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['first_name']= this.first_name;
    data['last_name']= this.last_name;
    data['is_active']= this.is_active;
    data['email'] = this.email;
    data['is_superuser'] = this.is_superuser;
    data['is_staff'] = this.is_staff;
    data['profile_pic_url'] = this.profile_pic_url;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['verified'] = this.verified;
    data['user_status'] = this.user_status;
    data['type'] = this.type;
    return data;
  }

  static List<CampaignModel> listFromJson(List<dynamic> list) =>
      List<CampaignModel>.from(list.map((x) => CampaignModel.fromJson(x)));
}
