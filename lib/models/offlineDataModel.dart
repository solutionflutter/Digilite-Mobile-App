import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class OfflineCampaignModel extends ChangeNotifier{
  int? id;
  List<OfflineSurveyModel>? survey_set;
  int? user_response_count;
  String? created_at;
  String? updated_at;
  String? name;
  String? description;
  String? start_date;
  String? end_date;
  bool? is_active;
  String? image;

  OfflineCampaignModel({
    this.id,
    this.survey_set,
    this.name,
    this.user_response_count,
    this.description,
    this.image,
    this.start_date,
    this.end_date,
    this.is_active,
  });

  OfflineCampaignModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    survey_set = List<OfflineSurveyModel>.from(
      json['survey_set'].map((x)=> OfflineSurveyModel.fromJson(x),),);
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
    data['survey_set'] = List<dynamic>.from(this.survey_set!.map((x) => x.toJson()));
    data['user_response_count'] = this.user_response_count;
    data['image'] = this.image;
    data['description'] = this.description;
    data['start_date'] = this.start_date;
    data['end_date'] = this.end_date;
    data['is_active'] = this.is_active;
    return data;
  }

  static List<OfflineCampaignModel> listFromJson(List<dynamic> list) =>
      List<OfflineCampaignModel>.from(list.map((x) => OfflineCampaignModel.fromJson(x)));
}


class OfflineSurveyModel extends ChangeNotifier{
  int? id;
  List<OfflineQuestionModel>? question_set;
  String? name;
  bool? is_active;
  //int? response_count;

  OfflineSurveyModel({
    this.id,
    this.name,
    this.question_set,
    this.is_active,
    //this.response_count
  });

  OfflineSurveyModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    is_active = json['is_active'];
    //response_count = json['response_count'];
    question_set = List<OfflineQuestionModel>.from(
      json['question_set'].map((x)=>OfflineQuestionModel.fromJson(x),),);
  }

  Map<String,dynamic> toJson() {
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_active'] = this.is_active;
    //data['response_count'] = this.response_count;
    data['question_set'] = List<dynamic>.from(this.question_set!.map((x) => x.toJson()));
    return data;
  }

  static List<OfflineSurveyModel> listFromJson(List<dynamic> list) =>
      List<OfflineSurveyModel>.from(list.map((x) => OfflineSurveyModel.fromJson(x)));

}


class OfflineQuestionModel extends ChangeNotifier{
  int? id;
  String? question;
  String? type;
  List<dynamic>? choices;
  bool? is_required;
  bool? is_active;

  OfflineQuestionModel({
    this.id,
    this.question,
    this.type,
    this.choices,
    this.is_required,
    this.is_active,
  });

  OfflineQuestionModel.fromJson(Map<String,dynamic> json){
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

  static List<OfflineQuestionModel> listFromJson(List<dynamic> list) =>
      List<OfflineQuestionModel>.from(list.map((x) => OfflineQuestionModel.fromJson(x)));
}