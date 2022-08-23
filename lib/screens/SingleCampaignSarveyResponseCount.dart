import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Client/Login_client_dio.dart';
import '../Widget/showAlertBox.dart';
import '../models/Campaign_model.dart';
import 'base_screen.dart';

class SingleCampaignSarveyResponseCount extends StatefulWidget {
  const SingleCampaignSarveyResponseCount({Key? key,
  this.image,
    this.campaignName,
  this.campaignId,
  this.campaignDescription,
  required this.accesstoken}) : super(key: key);

  final String? campaignName;
  final String? campaignDescription;
  final int? campaignId;
  final String accesstoken;
  final String? image;
  @override
  _SingleCampaignSarveyResponseCountState createState() => _SingleCampaignSarveyResponseCountState();
}

class _SingleCampaignSarveyResponseCountState extends State<SingleCampaignSarveyResponseCount> {

  Future redirectToLoginPage() async {
    ConnectivityResult? _connectivityResult;
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      showDilogeBoxOnline(context);
    } else if (result == ConnectivityResult.none) {
      showDilogeBoxOnline(context);
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
  }
  @override
  Widget build(BuildContext context) {
    int? campaignId = widget.campaignId;
    Future<List<SurveyModel>> survies;
    LoginClientDio loginClientDio = LoginClientDio();
    survies = loginClientDio.getSingleCampaignSurveyData(campaignId!);
    return WillPopScope(
      onWillPop: ()async{
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> BaseScreen(accessToken: widget.accesstoken)));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> BaseScreen(accessToken: widget.accesstoken)));
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
        body: FutureBuilder<List<SurveyModel>>(
          future: survies,
          builder: (BuildContext context,snapshot){
            if(snapshot.hasData){
              return CustomScrollView(
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
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("${widget.image}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: MediaQuery.of(context).size.height/15,
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "DETAILS",
                          style: GoogleFonts.roboto(
                            color: const Color.fromRGBO(4, 98, 169, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        //height: MediaQuery.of(context).size.height/4,
                        //width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "${widget.campaignDescription}",
                            style: GoogleFonts.roboto(
                              color: const Color.fromRGBO(79, 75, 75, 1),
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                            textAlign: TextAlign.justify,
                          ),
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
                                .height / 8,
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
                                // final campaignName = widget.campaignName;
                                // final surveyId = snapshot.data![index].id;
                                // final int i = index + 1;
                                // Navigator.push(context,
                                //   MaterialPageRoute(builder: (context) =>
                                //       SurvayDynamicFormPage(
                                //         id: i,
                                //         surveyId: surveyId,
                                //         campaignName: campaignName,
                                //         campaignId: widget.campaignId,
                                //         campaignDescription: widget.campaignDescription,
                                //         accesstoken: widget.accesstoken,
                                //         surveyName: snapshot.data![index].name,
                                //       ),
                                //   ),
                                // );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "${snapshot.data![index].name}\n",
                                        style: GoogleFonts.roboto(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          color: const Color.fromRGBO(79, 75, 75, 1),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "${snapshot.data![index].response_count} Customers",
                                            style: GoogleFonts.roboto(
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: const Color.fromRGBO(79, 75, 75, 1),
                                            ),
                                          ),
                                        ]
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: snapshot.data!.length,
                    ),
                  ),
                ],
              );
            }else {
              return const Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }
}
