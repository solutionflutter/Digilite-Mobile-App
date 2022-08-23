import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digilitemobileapp/Client/Login_client_dio.dart';
import 'package:digilitemobileapp/models/response_model.dart';
import 'package:digilitemobileapp/screens/account_screen.dart';
import 'package:digilitemobileapp/screens/history_screen.dart';
import 'package:digilitemobileapp/screens/home_screen.dart';
import 'package:digilitemobileapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key,required this.accessToken}) : super(key: key);
  final String accessToken;
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int pageIndex = 1;
  PageController controller = PageController(
    initialPage: 1
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    ResponseModel.getCampaignAllValue().then((data) {
      if(data.isNotEmpty){
        ResponseModel.deleteCampaignValue();
      }
    });
    LoginClientDio loginClientDio = LoginClientDio();
    loginClientDio.getAllCampaignDataForOffline();
    //ResponseModel.getFormDataFormLocalStorage().then((value) => debugPrint(value.toString()));
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(15, 117, 189, 1),
            leadingWidth: 80,
            leading: InkWell(
              onTap: (){
                _scaffoldKey.currentState!.openDrawer();
              },
              child: const Image(
                image: AssetImage("images/Base_screen_Image/AppBarIcon.png"),
                height: 20,
                width: 20,
                fit: BoxFit.contain,
              ),
            ),
            titleSpacing: 0,
            title: Text(
              pageIndex == 0 ? "ACCOUNT" : pageIndex == 1 ? "DIGILITE": "HISTORY",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700,
                fontSize: 25,
                fontStyle: FontStyle.normal,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ),
          body: Stack(
              children: [

                //Main Page View container

                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: PageView(
                    controller: controller,
                    onPageChanged: (index){
                      setState(() {
                        pageIndex = index;
                      });
                    },
                    children: [
                      AccountScreen(accesstoken: widget.accessToken,),
                      HomeScreen(accesstoken: widget.accessToken,),
                      HistoryScreen(accesstoken: widget.accessToken,),
                    ],
                  ),
                ),


                //calling Bottom navigation bar function

                bottomNavigationBar(context),
              ],
            ),
          drawer: drawerBuilderFunction(context,widget.accessToken),
        ),
        onWillPop: ()async {
          return false;
        }
        );
  }


  void showDilogeBox(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              AlertDialog(
                scrollable: false,
                content: Container(
                  height: MediaQuery.of(context).size.height/4,
                  width: MediaQuery.of(context).size.width/1.3,
                  child: Center(
                    child: Text(
                      ""
                    ),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width/1.22,
                bottom: MediaQuery.of(context).size.height/1.15,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    height: MediaQuery.of(context).size.height/10,
                    width: MediaQuery.of(context).size.width/10,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade600,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close_sharp,
                            color: Colors.white,
                            size: 20,
                          )
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );

      },
    );
  }




  // Bottom Navigation Bar function and navigation to pages

  Widget bottomNavigationBar(BuildContext context){
    return Positioned(
      top: MediaQuery.of(context).size.height/1.35,
        child: Container(
          height: MediaQuery.of(context).size.height/5,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(15, 117, 189, 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Account Button function and navigation
                Container(
                    height: MediaQuery.of(context).size.height/10,
                    width: MediaQuery.of(context).size.width/6.5,
                    child: MaterialButton(
                      onPressed: (){
                        setState(() {
                          pageIndex = 0;
                          controller.jumpToPage(pageIndex);
                        });
                      },
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage(
                                pageIndex == 0 ?
                                "images/Base_screen_Image/Bottom_Navigation_Bar_Icons/Account_Click.png" :
                                "images/Base_screen_Image/Bottom_Navigation_Bar_Icons/Account_Unclick.png"
                            ),
                            height: 30,
                            width: 30,
                            fit: BoxFit.contain,
                          ),
                          Text(
                            "Account",
                            style: GoogleFonts.roboto(
                              fontStyle: FontStyle.normal,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: pageIndex == 0 ? const Color.fromRGBO(255,255,255,1)
                                  : const Color.fromRGBO(219,219,219,1),
                            ),
                          ),
                        ],
                      ),
                    )
                ),

               // Home Button function and navigation
                Container(
                  height: MediaQuery.of(context).size.height/10,
                  width: MediaQuery.of(context).size.width/6.5,
                  child: MaterialButton(
                    onPressed: () async {
                      setState(() {
                        pageIndex = 1;
                        controller.jumpToPage(pageIndex);
                      });
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
                    },
                    padding: const EdgeInsets.all(0),
                    child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         Image(
                           image: AssetImage(
                             pageIndex == 1 ?
                             "images/Base_screen_Image/Bottom_Navigation_Bar_Icons/Home_Click.png" :
                             "images/Base_screen_Image/Bottom_Navigation_Bar_Icons/Home_Unclick.png"
                           ),
                           height: 30,
                           width: 30,
                           fit: BoxFit.contain,
                         ),
                         Text(
                           "Home",
                           style: GoogleFonts.roboto(
                             fontStyle: FontStyle.normal,
                             fontSize: 12,
                             fontWeight: FontWeight.w400,
                             color: pageIndex == 1 ? const Color.fromRGBO(255,255,255,1)
                                 : const Color.fromRGBO(219,219,219,1),
                           ),
                         ),
                      ],
                    ),
                  )
                ),

                // History Button function and navigation
                Container(
                    height: MediaQuery.of(context).size.height/10,
                    width: MediaQuery.of(context).size.width/6.5,
                    child: MaterialButton(
                      onPressed: () async {
                        setState(() {
                          pageIndex = 2;
                          controller.jumpToPage(pageIndex);
                        });
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> const HistoryScreen()));
                      },
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage(
                                pageIndex == 2 ?
                                "images/Base_screen_Image/Bottom_Navigation_Bar_Icons/History_Click.png" :
                                "images/Base_screen_Image/Bottom_Navigation_Bar_Icons/History_Unclick.png"
                            ),
                            height: 30,
                            width: 30,
                            fit: BoxFit.contain,
                          ),
                          Text(
                            "History",
                            style: GoogleFonts.roboto(
                              fontStyle: FontStyle.normal,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: pageIndex == 2 ?
                              const Color.fromRGBO(255,255,255,1)
                                  : const Color.fromRGBO(219,219,219,1),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
    );
  }


  // drawer Builder Function and navigation

 Widget drawerBuilderFunction(BuildContext context,String access){
    return Drawer(
      child: Column(
        children: [
          Image(
            image: const AssetImage("images/Splash_screen_Image/Company_icon.png"),
            height: MediaQuery.of(context).size.height/5,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),

          //Drawer Account Button function and Navigation

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            child: MaterialButton(
              padding: const EdgeInsets.all(0),
              onPressed: (){
                setState(() {
                  pageIndex = 0;
                  controller.jumpToPage(pageIndex);
                  _scaffoldKey.currentState?.openEndDrawer();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image: const AssetImage("images/Base_screen_Image/Drawer_Image/Drawer_Account_Image.png"),
                    height: MediaQuery.of(context).size.height/20,
                    width: MediaQuery.of(context).size.width/8,
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "ACCOUNT",
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(79, 75, 75, 1),
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Drawer History Button function and Navigation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MaterialButton(
              padding: const EdgeInsets.all(0),
              onPressed: (){
                setState(() {
                  pageIndex = 2;
                  controller.jumpToPage(pageIndex);
                  _scaffoldKey.currentState?.openEndDrawer();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image: const AssetImage("images/Base_screen_Image/Drawer_Image/Drawer_History_Image.png"),
                    height: MediaQuery.of(context).size.height/20,
                    width: MediaQuery.of(context).size.width/8,
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "HISTORY",
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(79, 75, 75, 1),
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Drawer LogOut Button function and Navigation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            child: MaterialButton(
              padding: const EdgeInsets.all(0),
              onPressed: (){
                setState(() {
                 ResponseModel.logOut();
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context)=> const LoginScreen(accessToken: "access",),
                   ),
                 );
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image: const AssetImage("images/Base_screen_Image/Drawer_Image/Drawer_LogOut_Image.png"),
                    height: MediaQuery.of(context).size.height/20,
                    width: MediaQuery.of(context).size.width/8,
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "LOGOUT",
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(79, 75, 75, 1),
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
 }
}
