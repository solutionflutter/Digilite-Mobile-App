import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digilitemobileapp/screens/changepassword_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Client/Login_client_dio.dart';
import '../Widget/showAlertBox.dart';
import '../models/Campaign_model.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key,required this.accesstoken}) : super(key: key);
  final String accesstoken;
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();


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
  }


  @override
  Widget build(BuildContext context) {
    Future<UserModel> user;
    LoginClientDio loginClientDio = LoginClientDio();
    user = loginClientDio.getAllUserData();
    return Scaffold(
      body: FutureBuilder<UserModel>(
        future: user,
        builder: (BuildContext context,snapshot){
          if(snapshot.hasData){
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  child: TextFormField(
                                    controller: nameController,
                                    style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        color: const Color.fromRGBO(79, 75, 75, 1)
                                    ),
                                    enabled: false,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(color: Color.fromRGBO(182, 181, 181, 1),),
                                        ),
                                        labelText: "${snapshot.data?.first_name} ${snapshot.data?.last_name}",
                                        labelStyle: GoogleFonts.roboto(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: const Color.fromRGBO(146, 140, 140, 1),
                                          fontStyle: FontStyle.normal,
                                        ),
                                        /*hintText: "Enter you name",
                                        hintStyle: GoogleFonts.roboto(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: const Color.fromRGBO(79, 75, 75, 1),
                                          fontStyle: FontStyle.normal,
                                        )*/
                                    ),
                                    validator: (email){
                                      if(email!.isEmpty){
                                        return "please enter the email";
                                      }
                                    },
                                  ),
                                ),
                                TextFormField(
                                  controller: phoneController,
                                  style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      color: const Color.fromRGBO(79, 75, 75, 1)
                                  ),
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Color.fromRGBO(182, 181, 181, 1),),
                                    ),
                                    labelText: "${snapshot.data?.phone}",
                                    labelStyle: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: const Color.fromRGBO(146, 140, 140, 1),
                                      fontStyle: FontStyle.normal,
                                    ),
                                    /*hintText: "Enter you phone number",
                                    hintStyle: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromRGBO(79, 75, 75, 1),
                                      fontStyle: FontStyle.normal,
                                    ),*/
                                  ),
                                  validator: (pass){
                                    if(pass!.isEmpty){
                                      return "password is required";
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  child: TextFormField(
                                    controller: emailController,
                                    style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        color: const Color.fromRGBO(79, 75, 75, 1)
                                    ),
                                    enabled: false,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: Color.fromRGBO(182, 181, 181, 1),),
                                      ),
                                      labelText: "${snapshot.data?.email}",
                                      labelStyle: GoogleFonts.roboto(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: const Color.fromRGBO(146, 140, 140, 1),
                                        fontStyle: FontStyle.normal,
                                      ),
                                      /*hintText: "Enter you e-mail address ",
                                      hintStyle: GoogleFonts.roboto(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: const Color.fromRGBO(79, 75, 75, 1),
                                        fontStyle: FontStyle.normal,
                                      ),*/
                                    ),
                                    validator: (pass){
                                      if(pass!.isEmpty){
                                        return "email is required";
                                      }else if(pass.contains("@")){
                                        return "please put a valid email";
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height/15,
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(
                                          builder: (context)=> ChangePasswordScreen(accesstoken: widget.accesstoken),
                                        ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: const Color.fromRGBO(15, 117, 189, 1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Change Password",
                                            style: GoogleFonts.roboto(
                                              color: const Color.fromRGBO(255, 255, 255, 1),
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }
}
