import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digilitemobileapp/Widget/showAlertBoxForOffline.dart';
import 'package:digilitemobileapp/models/offlineDataModel.dart';
import 'package:digilitemobileapp/screens/offline_data_collection_page/campaign_page.dart';
import 'package:digilitemobileapp/screens/offline_data_collection_page/offlineQuestionSetListShow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class OfflineSurveyListShow extends StatefulWidget {
  const OfflineSurveyListShow({Key? key,
    this.campaignDescription,
    this.campaignId,
    this.campaignName,
    this.surveys,
  }) : super(key: key);
  final String? campaignName;
  final String? campaignDescription;
  final int? campaignId;
  final List<OfflineSurveyModel>? surveys;
  @override
  _OfflineSurveyListShowState createState() => _OfflineSurveyListShowState();
}

class _OfflineSurveyListShowState extends State<OfflineSurveyListShow> {
  late List<OfflineSurveyModel>? surves = widget.surveys;
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
    super.initState();
    redirectToLoginPage();
  }


  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: ()async{
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> OfflineCampaignPage()));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> OfflineCampaignPage()));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            iconSize: 25,
          ),
          title: Text(
            "${widget.campaignName}",
            style: GoogleFonts.roboto(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
          backgroundColor: const Color.fromRGBO(15, 117, 189, 1),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 15,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height/4,
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
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: MediaQuery.of(context).size.height/4,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "DETAILS",
                        style: GoogleFonts.roboto(
                          color: const Color.fromRGBO(4, 98, 169, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "${widget.campaignDescription}",
                          style: GoogleFonts.roboto(
                            color: const Color.fromRGBO(79, 75, 75, 1),
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                child: Container(
                  height: MediaQuery.of(context).size.height/20,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SURVEY LIST",
                        style: GoogleFonts.roboto(
                          color: const Color.fromRGBO(4, 98, 169, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context,int index) {
                  int i = index + 1;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 10,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            spreadRadius: -2,
                          )
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          final campaignName = widget.campaignName;
                          final campaignId = widget.campaignId;
                          final surveyId = widget.surveys![index].id;
                          final surveyName = widget.surveys![index].name;
                          final List<OfflineQuestionModel>? question = widget.surveys![index].question_set;
                          final campaignDescription = widget.campaignDescription;
                          final List<OfflineSurveyModel>? surves = widget.surveys;
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              OfflineQuestionSetListShow(
                                sarveyId: surveyId,
                                campaignName: campaignName,
                                campaignDescription: campaignDescription,
                                surveys: surves,
                                Question: question,
                                isDilogeBoxShow: true,
                                campaignId: campaignId,
                                surveyName: surveyName,
                              ),
                          ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.surveys![index].name}",
                                style: GoogleFonts.roboto(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: const Color.fromRGBO(79, 75, 75, 1),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: Color.fromRGBO(15, 117, 189, 1),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: widget.surveys?.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
