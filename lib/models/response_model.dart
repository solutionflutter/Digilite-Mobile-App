import 'dart:convert';
import 'package:digilitemobileapp/Client/Login_client_dio.dart';
import 'package:digilitemobileapp/Client/Server_client.dart';
import 'package:digilitemobileapp/models/Campaign_model.dart';
import 'package:digilitemobileapp/models/offlineDataModel.dart';
import 'package:digilitemobileapp/screens/home_screen.dart';
import 'package:flutter/material.dart';


class ResponseModel extends ChangeNotifier{
   static String success = " ";
   static String message = "";
   static Map<String,dynamic>? data;
   List<Map<String,dynamic>> campaign=[];
   static final List<dynamic> list_data = [];

   //save online campaign all data to offline
   static Future<void> setCampaignAllValue(List<dynamic> data) async {
      await LocalStorageInstance.storage.ready;
      await LocalStorageInstance.storage.setItem("inputCampaigndata", data);
   }

   //get all campaign value in offline page
   static Future<String> getCampaignAllValue() async {
      await LocalStorageInstance.storage.ready;
      List<dynamic> campaign = LocalStorageInstance.storage.getItem("inputCampaigndata");
      return await campaign.toString();
   }

   //delete the all campaign data form server
   static Future<void> deleteCampaignValue() async {
      await LocalStorageInstance.storage.ready;
      await LocalStorageInstance.storage.deleteItem("inputCampaigndata");
   }

   // get all data show to campaign page
   static Future<List<OfflineCampaignModel>> getAllCampaignDataToShow() async {
      await LocalStorageInstance.storage.ready;
      List<dynamic> allcamapigndata = LocalStorageInstance.storage.getItem("inputCampaigndata");
      return allcamapigndata.map((dynamic item) => OfflineCampaignModel.fromJson(item)).toList();
   }

   //save and set offline form data in local storage
   static Future<void> receiveFormDataFormOffline(
   {  int? id,
      String? name,
      String? phoneNumber,
      String? location_name,
      String? location_type,
       List<Map<String,dynamic>>? json}) async {
      await LocalStorageInstance.storage.ready;
      var data = {
         "survey": id,
         "name": name.toString(),
         "phone": phoneNumber.toString(),
         "location_name": location_name.toString(),
         "location_type": location_type.toString(),
         "answers": json,
      };
      list_data.add(data);
      await LocalStorageInstance.storage.setItem("formdata", list_data);
   }


   //Print offline data is stored
   static getFormDataFormLocalStorage()async{
      await LocalStorageInstance.storage.ready;
      List<dynamic> data = LocalStorageInstance.storage.getItem("formdata");
      //var data_list = [];
      //data_list.add(data);
      //print("${jsonEncode(data_list)}");
      print("${jsonEncode(data)}");
      return data;
   }

   //Delete Offline all data form local storage after inserting in online database
   static Future<void> deleteCollectiondata() async {
      await LocalStorageInstance.storage.ready;
      await LocalStorageInstance.storage.deleteItem("formdata");
   }

   //Save the Location Name and type to local storage when the dynamic form field page is open
   static Future<void> setValueOfLocationTypeLocationName(String locationName,String locationType) async {
      await LocalStorageInstance.storage.ready;
      await LocalStorageInstance.storage.setItem("LocationName", locationName);
      await LocalStorageInstance.storage.setItem("LocationType", locationType);
   }

   //after navigation back to Campaign details page the location name and type is deleted form local storage
   static Future<void> deleteValueOfLocationTypeLocationName() async {
      await LocalStorageInstance.storage.ready;
      await LocalStorageInstance.storage.deleteItem("LocationName");
      await LocalStorageInstance.storage.deleteItem("LocationType");
   }


   static Future<void> setAllValue(String success,String message,Map<String,dynamic> data) async {
      LocalStorageInstance.storage.setItem("success", success);
      LocalStorageInstance.storage.setItem("message", message);
      LocalStorageInstance.storage.setItem("data", jsonEncode(data));
   }

   static String getStatusValue(){
      final status = LocalStorageInstance.storage.getItem("success");
      return status;
   }

   static String getMessageValue() {
      final message = LocalStorageInstance.storage.getItem("message");
      return message;
   }

   static String getAccessToken(){
      final Map<String,dynamic> data = jsonDecode(LocalStorageInstance.storage.getItem("data"));
      String accessToken = data["access"].toString().trim();
      return accessToken;
   }

   static Future<void> sendAccessToken() async {
      var access = getAccessToken();
      print("${access.toString()}");
   }

   static Future<void>logOut()async {
      LocalStorageInstance.storage.deleteItem("success");
      LocalStorageInstance.storage.deleteItem("message");
      LocalStorageInstance.storage.deleteItem("data");
      LocalStorageInstance.storage.deleteItem("Campaigns");
   }


   static Future<void> setAllCampaignsValue(Map<String,dynamic> responsebody) async {
      LocalStorageInstance.storage.setItem("Campaigns", responsebody);
   }


   /*Future<List<CampaignModel>>getAllCampaigns() async{
      //Map<String,dynamic> data = jsonDecode(LocalStorageInstance.storage.getItem("Campaigns"));
      //Payload payload = Payload.fromJson(data);
      //return payload.data;
   }*/




}