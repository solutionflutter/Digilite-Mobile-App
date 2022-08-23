import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digilitemobileapp/Widget/showAlertBoxForOffline.dart';
import 'package:digilitemobileapp/models/offlineDataModel.dart';
import 'package:digilitemobileapp/screens/offline_data_collection_page/offlineSurveyListShow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

import '../../models/response_model.dart';
import '../login_screen.dart';

class OfflineCampaignPage extends StatefulWidget {
  const OfflineCampaignPage({Key? key}) : super(key: key);

  @override
  _OfflineCampaignPageState createState() => _OfflineCampaignPageState();
}

class _OfflineCampaignPageState extends State<OfflineCampaignPage> {
  Future redirectToLoginPage() async {
    ConnectivityResult? _connectivityResult;
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi) {
      showDilogeBox(context);
    } else if (result == ConnectivityResult.mobile) {
      showDilogeBox(context);
    }
    setState(() {
      _connectivityResult = result;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    redirectToLoginPage();
    ResponseModel.getCampaignAllValue().then((data) => debugPrint(data.toString()));
  }
  @override
  Widget build(BuildContext context) {
    Future<List<OfflineCampaignModel>> campaign;
    campaign = ResponseModel.getAllCampaignDataToShow();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(15, 117, 189, 1),
        titleSpacing: 30,
        title: Text(
          "DIGILITE",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w700,
            fontSize: 25,
            fontStyle: FontStyle.normal,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
      body: FutureBuilder<List<OfflineCampaignModel>>(
        future: campaign,
        builder: (BuildContext context,snapshot){
          if(snapshot.hasData){
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30,left: 20),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height/10,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "ASSIGNED CAMPAIGNS",
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(4, 98, 169, 1),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(delegate: SliverChildBuilderDelegate(
                        (BuildContext context,int index){
                      return InkWell(
                        onTap: (){
                          final int? campaignId = snapshot.data![index].id;
                          final String? campaignDescription = snapshot.data![index].description;
                          final String? campaignName = snapshot.data![index].name;
                          final List<OfflineSurveyModel>? surves = snapshot.data![index].survey_set;
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> OfflineSurveyListShow(
                            campaignId: campaignId,
                            campaignDescription: campaignDescription,
                            campaignName: campaignName,
                            surveys: surves,
                          )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: MediaQuery.of(context).size.height/4,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height/6,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(196, 196, 196, 1)
                                  ),
                                  child: Center(
                                    child: Image(
                                      image: AssetImage("images/NoImage.png"),
                                      height: MediaQuery.of(context).size.height/8,
                                      width: MediaQuery.of(context).size.width/8,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                  child: Text(
                                    "${snapshot.data![index].name}",
                                    style: GoogleFonts.roboto(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: const Color.fromRGBO(79, 75, 75, 1),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                  child: Text(
                                    //"${snapshot.data![index].start_date} - ${snapshot.data![index].end_date}",
                                    "${Jiffy("${snapshot.data![index].start_date}").yMMMMd}  -  ${Jiffy("${snapshot.data![index].end_date}").yMMMMd}",
                                    style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: const Color.fromRGBO(79, 75, 75, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: snapshot.data!.length
                ),
                ),
              ],
            );
          }else{
            return Center(child: Text("Please Online login first to get the offline data"),);
          }
        },
      ),
    );
  }
}
