import 'dart:convert';
import 'dart:io';
import 'package:digilitemobileapp/Client/Server_client.dart';
import 'package:digilitemobileapp/models/response_model.dart';
import 'package:flutter/foundation.dart';
import '../models/Campaign_model.dart';
import 'package:http/http.dart' as http;

class LoginClientDio extends ChangeNotifier{


  static String access_token = "";

  Future<void> loginWithUsernameAndPassword({
    required String username,
    required String password,
    required Function onFail,
    required Function(String token) onSuccess}) async{
    String baseUrl= "http://137.184.156.117:1339/api/v1.0/users/public/login";
       var data = {
         "username": username,
         "password": password
       };
      final response = http.post(
        Uri.parse(baseUrl),
        body: jsonEncode(data),
        headers: <String,String>{
          'Content-Type' : 'application/json',
          'Accept': 'application/json',
        },
        encoding: Encoding.getByName("utf-8"),
      ).then((response){
        if(response.statusCode == 201){
          var data = jsonDecode(response.body);
          var token = jsonDecode(response.body)["data"]["access"];
          onSuccess(token);
          access_token = token;
      }
        else if ( response.statusCode > 200){
          var data = jsonDecode(response.body);
          var message = jsonDecode(response.body)["message"];
          onFail(message);
        }
      }).onError((error, stackTrace) {
        print("${stackTrace.toString()}");
        //onFail(stackTrace.toString());
      });
  }

  //get all data of CampaignModel

  Future<List<CampaignModel>> getAllCampaignData() async {
    String baseUrl= "http://137.184.156.117:1339/api/v1.0/campaign/user/campaigns";
    String token = access_token;
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: <String,String>{
        'Content-Type' : 'application/json',
        'Accept': 'application/json',
        'Authorization' : 'Bearer $token',
      }
    );
    if(response.statusCode == 200){
      List<dynamic> data = jsonDecode(response.body)["data"];
      //debugPrint(data.toString());
      return data.map((dynamic item) => CampaignModel.fromJson(item)).toList();
    }else{
      throw Exception("Failed to load data");
    }
  }


  // get all campaign under survey data

  Future<List<SurveyModel>> getSingleCampaignSurveyData(int campaignId) async {
    print("${campaignId}");
    String baseUrl= "http://137.184.156.117:1339/api/v1.0/campaign/user/surveylist/$campaignId?page_size=0";
    String token = access_token;
    final response = await http.get(
        Uri.parse(baseUrl),
        headers: <String,String>{
          'Content-Type' : 'application/json',
          'Accept': 'application/json',
          'Authorization' : 'Bearer $token',
        }
    );
    if(response.statusCode == 200){
       List<dynamic> data = jsonDecode(response.body)["data"];
       //debugPrint(data.toString());
       return data.map((dynamic item) => SurveyModel.fromJson(item)).toList();
    }else{
      throw Exception("Failed to load data");
    }
  }

  // get single survey under campaign data
  Future<List<QuestionModel>> getSingleSurveyQuestionData(int surveyId) async {
    print("${surveyId}");
    String baseUrl= "http://137.184.156.117:1339/api/v1.0/campaign/user/survey-question-list/$surveyId?page_size=0";
    String token = access_token;
    final response = await http.get(
        Uri.parse(baseUrl),
        headers: <String,String>{
          'Content-Type' : 'application/json',
          'Accept': 'application/json',
          'Authorization' : 'Bearer $token',
        }
    );
    if(response.statusCode == 200){
      List<dynamic> data = jsonDecode(response.body)["data"];
      //debugPrint(data.toString());
      return data.map((dynamic item) => QuestionModel.fromJson(item)).toList();
    }else{
      throw Exception("Failed to load data");
    }
  }

  // send the question answer response  to the server

  Future<void> sendDataTotheServer({
    required int id,
    required String name,
    required String phoneNumber,
    required String location_name,
    required String location_type,
    required List<Map<String,dynamic>> json,
    required Function onSuccess,
    required Function onFail,
  }) async {
    String baseUrl= "http://137.184.156.117:1339/api/v1.0/campaign/user/user-response-validation";
    String token = access_token;
    var data = {
      "survey": id,
      "name": name.toString(),
      "phone": phoneNumber.toString(),
      "location_name": location_name.toString(),
      "location_type": location_type.toString(),
      "answers": json,
    };
    var data_list = [];
    data_list.add(data);
    print("${jsonEncode(data_list)}");
    print("${jsonEncode(json)}");
    final response = http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(data_list),
      headers: <String,String>{
        'Content-Type' : 'application/json',
        'Accept': 'application/json',
        'Authorization' : 'Bearer $token',
      },
      encoding: Encoding.getByName("utf-8"),
    ).then((response){
      if(response.statusCode == 200){
        print("${response.statusCode.toString()}");
        onSuccess(jsonDecode(response.body)["message"].toString());
      }else {
        onFail(jsonDecode(response.body)["message"].toString());
      }
    }).onError((error, stackTrace) {
      //onFail(error.toString());
      print("your request is fail ${error}");
    });
  }


  //change password response to the server

  Future<void> changePasswordWithNewPassword({
    required String old_password,
    required String new_password,
    required Function onFail,
    required Function(String token) onSuccess}) async{
    String baseUrl= "http://137.184.156.117:1339/api/v1.0/users/user/change-password";
    String token = access_token;
    var data = {
      "old_password": old_password,
      "new_password": new_password
    };
    final response = http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(data),
      headers: <String,String>{
        'Content-Type' : 'application/json',
        'Accept': 'application/json',
        'Authorization' : 'Bearer $token',
      },
      encoding: Encoding.getByName("utf-8"),
    ).then((response){
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        var details = jsonDecode(response.body)["data"]["details"];
        onSuccess(details);
        print("${details}");
      }
      else if ( response.statusCode > 200){
        var data = jsonDecode(response.body);
        var message = jsonDecode(response.body)["message"];
        print("${message}");
        onFail(message);
      }
    }).onError((error, stackTrace) {
      print("${stackTrace.toString()}");
      //onFail(stackTrace.toString());
    });
  }

  //reset password response on the server
  Future<void> resetPassword({
    required String username,
    required Function onFail,
    required Function(String token) onSuccess}) async{
    String baseUrl= "http://137.184.156.117:1339/api/v1.0/users/public/reset_password_request";
    var data = {
      "username": username,
    };
    final response = http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(data),
      headers: <String,String>{
        'Content-Type' : 'application/json',
        'Accept': 'application/json',
      },
      encoding: Encoding.getByName("utf-8"),
    ).then((response){
      if(response.statusCode == 201){
        var data = jsonDecode(response.body);
        var message = jsonDecode(response.body)["message"];
        onSuccess(message);
        print("${message}");
      }
      else if ( response.statusCode > 200){
        var data = jsonDecode(response.body);
        var message = jsonDecode(response.body)["message"];
        print("${message}");
        onFail(message);
      }
    }).onError((error, stackTrace) {
      print("${stackTrace.toString()}");
      //onFail(stackTrace.toString());
    });
  }


  Future<List<CampaignModel>> getAllCampaignDataByDate(String start_date,String end_date) async {
    String baseUrl= "http://137.184.156.117:1339/api/v1.0/campaign/user/campaigns?end_date=${end_date}&start_date=${start_date}";
    String token = access_token;
    final response = await http.get(
        Uri.parse(baseUrl),
        headers: <String,String>{
          'Content-Type' : 'application/json',
          'Accept': 'application/json',
          'Authorization' : 'Bearer $token',
        }
    );
    if(response.statusCode == 200){
      List<dynamic> data = jsonDecode(response.body)["data"];
      //debugPrint(data.toString());
      return data.map((dynamic item) => CampaignModel.fromJson(item)).toList();
    }else{
      throw Exception("Failed to load data + ${response.statusCode}");
    }
  }

  //get all data of UserModel

  Future<UserModel> getAllUserData() async {
    String baseUrl= "http://137.184.156.117:1339/api/v1.0/users/user/profile";
    String token = access_token;
    final response = await http.get(
        Uri.parse(baseUrl),
        headers: <String,String>{
          'Content-Type' : 'application/json',
          'Accept': 'application/json',
          'Authorization' : 'Bearer $token',
        }
    );
    if(response.statusCode == 200){
      Map<String,dynamic> data = jsonDecode(response.body)["data"];
      //debugPrint(data.toString());
      return UserModel.fromJson(data);
    }else{
      throw Exception("Failed to load data");
    }
  }

  Future<void> getAllCampaignDataForOffline() async {
    String baseUrl= "http://137.184.156.117:1339/api/v1.0/campaign/user/campaigns?page_size=0";
    String token = access_token;
    final response = await http.get(
        Uri.parse(baseUrl),
        headers: <String,String>{
          'Content-Type' : 'application/json',
          'Accept': 'application/json',
          'Authorization' : 'Bearer $token',
        }
    );
    if(response.statusCode == 200){
      List<dynamic> data = jsonDecode(response.body)["data"];
      ResponseModel.setCampaignAllValue(data);
      //debugPrint(data.toString());
    }else{
      throw Exception("Failed to load data + ${response.statusCode}");
    }
  }

  Future<void> sendOfflineDataToServer({required Function onSuccess,})async {
    List<dynamic> data = LocalStorageInstance.storage.getItem("formdata");
    debugPrint(jsonEncode(data).toString());
    String baseUrl= "http://137.184.156.117:1339/api/v1.0/campaign/user/user-response-validation";
    String token = access_token;
    final response = http.post(
      Uri.parse(baseUrl),
       body: jsonEncode(data),
       headers: <String,String>{
         'Content-Type' : 'application/json',
         'Accept': 'application/json',
         'Authorization' : 'Bearer $token',
       },
       encoding: Encoding.getByName("utf-8"),
     ).then((response){
       if(response.statusCode == 200){
         print("${response.statusCode.toString()}");
         onSuccess("Offline data is syncing successfully .....");
       }
     }).onError((error, stackTrace) {
       print("your request is fail ${error}");
     });
  }
}