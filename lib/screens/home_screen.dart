import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digilitemobileapp/Client/Login_client_dio.dart';
import 'package:digilitemobileapp/Widget/showAlertBox.dart';
import 'package:digilitemobileapp/models/Campaign_model.dart';
import 'package:digilitemobileapp/models/response_model.dart';
import 'package:digilitemobileapp/screens/offline_data_collection_page/campaign_page.dart';
import 'package:digilitemobileapp/screens/singlecampaignviewpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key,required this.accesstoken}) : super(key: key);
  final String accesstoken;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

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
    campaign = loginClientDio.getAllCampaignData();
    return Scaffold(
      key: _scaffold,
      body: FutureBuilder<List<CampaignModel>>(
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
                          final String? image =snapshot.data![index].image;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>SingleCampaignViewPage(
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
