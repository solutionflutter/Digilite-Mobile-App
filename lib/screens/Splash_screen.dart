import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digilitemobileapp/screens/login_screen.dart';
import 'package:digilitemobileapp/screens/offline_data_collection_page/campaign_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../models/response_model.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  // Redirect form splash screen to login screen or offline page after 3 seconds
  Future<void> redirectToLoginPage() async {
    ConnectivityResult? _connectivityResult;
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi) {
      setState(() {
        Timer(
            const Duration(seconds: 3),
                ()=> Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context)=>const LoginScreen(accessToken: "access",),
                )
            )
        );
      });
    } else if (result == ConnectivityResult.mobile) {
      setState(() {
        Timer(
            const Duration(seconds: 3),
                ()=> Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context)=>const LoginScreen(accessToken: "access",),
                )
            )
        );
      });
    } else {
      setState(() {
        Timer(
            const Duration(seconds: 3),
                ()=> Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context)=>const OfflineCampaignPage(),
                )
            )
        );
      });
    }

    setState(() {
       _connectivityResult = result;
    });
  }

  @override
  void initState() {
    redirectToLoginPage();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(15, 117, 189, 1),
          body: Center(
            child: Container(
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage("images/Splash_screen_Image/Company_icon.png"),
                      fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
      ),
    );
  }
}

