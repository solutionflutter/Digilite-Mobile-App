import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digilitemobileapp/screens/SingleCampaignSarveyResponseCount.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import '../Client/Login_client_dio.dart';
import '../Widget/showAlertBox.dart';
import '../models/Campaign_model.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key,required this.accesstoken}) : super(key: key);
  final String accesstoken;
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TextEditingController startdateController = TextEditingController();
  final TextEditingController enddateController = TextEditingController();

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
    Future<List<CampaignModel>> campaign;
    LoginClientDio loginClientDio = LoginClientDio();
    String start_date = startdateController.text;
    String end_date = enddateController.text;
    print("${start_date}");
    print("${end_date}");
    campaign = loginClientDio.getAllCampaignDataByDate(start_date,end_date);
    return Scaffold(
      body: FutureBuilder<List<CampaignModel>>(
        future: campaign,
        builder: (BuildContext context,snapshot){
          if(snapshot.hasData){
            return CustomScrollView(
              slivers: [
                //start date time picker
                SliverToBoxAdapter(
                  child: InkWell(
                    onTap:() async {
                      DateTime? pickedTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1945),
                          lastDate: DateTime(2200));
                      if(pickedTime != null ){
                        print(pickedTime);
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedTime);
                        print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          startdateController.text = formattedDate;
                        });
                      }else{
                        print("Date is not selected");
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                      child: TextField(
                        controller:  startdateController,
                        enabled: false,
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: const Color.fromRGBO(79, 75, 75, 1)
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color.fromRGBO(182, 181, 181, 1),),
                            ),
                            hintText: "Select a start date",
                            suffixIcon: Icon(Icons.calendar_today_rounded),
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(79, 75, 75, 1),
                              fontStyle: FontStyle.normal,
                            )
                        ),
                      ),
                    ),
                  ),
                ),

                //end date time picker
                SliverToBoxAdapter(
                  child: InkWell(
                    onTap:() async {
                      DateTime? pickedTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1945),
                          lastDate: DateTime(2200));
                      if(pickedTime != null ){
                        print(pickedTime);
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedTime);
                        print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          enddateController.text = formattedDate;
                        });
                      }else{
                        print("Date is not selected");
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                      child: TextField(
                        controller: enddateController,
                        enabled: false,
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: const Color.fromRGBO(79, 75, 75, 1)
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color.fromRGBO(182, 181, 181, 1),),
                            ),
                            hintText: "Select a end date",
                            suffixIcon: Icon(Icons.calendar_today_rounded),
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(79, 75, 75, 1),
                              fontStyle: FontStyle.normal,
                            )
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
                          final String? image =snapshot.data![index].image;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>SingleCampaignSarveyResponseCount(
                              campaignId: campaignId,
                              campaignDescription: campaignDescription,
                              campaignName: campaignName,
                              accesstoken: widget.accesstoken,
                              image: image,
                            ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: MediaQuery.of(context).size.height/2.95,
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
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage("${snapshot.data![index].image}"),
                                        fit: BoxFit.cover
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
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/13,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(15, 117, 189, 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                          "${snapshot.data![index].user_response_count} Completed Surveys",
                                        style: GoogleFonts.roboto(
                                          color: Color.fromRGBO(255, 255, 255, 1),
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
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
                ),),
                SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.of(context).size.height/4,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ],
            );
          }
          else {
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
