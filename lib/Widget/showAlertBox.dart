import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/offline_data_collection_page/campaign_page.dart';

Future showDilogeBoxOnline(BuildContext context){
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return WillPopScope(
          onWillPop:() async {
            return false;
            },
          child: AlertDialog(
            actions: [
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => const OfflineCampaignPage()));
                },
                child: Text("Go"),
              ),
            ],
            content: Container(
              //height: MediaQuery.of(context).size.height/4,
              //width: MediaQuery.of(context).size.width/1.5,
              child: Text(
                "Internet connection is not stable. Go to the offline campaign page.",
                style: GoogleFonts.roboto(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  color: Colors.black38,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      });
}