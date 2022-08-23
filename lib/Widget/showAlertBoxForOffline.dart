import 'package:digilitemobileapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

Future showDilogeBox(BuildContext context){
  return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          actions: [
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => const LoginScreen(accessToken: "access")));
              },
              child: Text("Go"),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text("Stay"),
            ),
          ],
          content: Container(
            //height: MediaQuery.of(context).size.height/4,
            //width: MediaQuery.of(context).size.width/1.5,
            child: Text(
              "Internet connection is stable. Do you want to go to login page or stay here?",
              style: GoogleFonts.roboto(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                color: Colors.black38,
                fontSize: 16,
              ),
            ),
          ),
        );
      }
      );
}