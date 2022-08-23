import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Client/Login_client_dio.dart';
import 'base_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key,required this.accesstoken}) : super(key: key);
  final String accesstoken;
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController oldpasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    print("${widget.accesstoken}");
    return Scaffold(
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
          "Change Password",
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
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: oldpasswordController,
                          obscureText: true,
                          obscuringCharacter: '●',
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: const Color.fromRGBO(79, 75, 75, 1)
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color.fromRGBO(182, 181, 181, 1),),
                            ),
                            labelText: "Old Password",
                            labelStyle: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(146, 140, 140, 1),
                              fontStyle: FontStyle.normal,
                            ),
                            hintText: "Enter you old password",
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(79, 75, 75, 1),
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          validator: (pass){
                            if(pass!.isEmpty){
                              return "password is required";
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: newpasswordController,
                          obscureText: true,
                          obscuringCharacter: '●',
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: const Color.fromRGBO(79, 75, 75, 1)
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color.fromRGBO(182, 181, 181, 1),),
                            ),
                            labelText: "New Password",
                            labelStyle: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(146, 140, 140, 1),
                              fontStyle: FontStyle.normal,
                            ),
                            hintText: "Enter you new password",
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(79, 75, 75, 1),
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          validator: (pass){
                            if(pass!.isEmpty){
                              return "password is required";
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: confirmpasswordController,
                          obscureText: true,
                          obscuringCharacter: '●',
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: const Color.fromRGBO(79, 75, 75, 1)
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color.fromRGBO(182, 181, 181, 1),),
                            ),
                            labelText: "Confirm Password",
                            labelStyle: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(146, 140, 140, 1),
                              fontStyle: FontStyle.normal,
                            ),
                            hintText: "Enter you confirm password",
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(79, 75, 75, 1),
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          validator: (pass){
                            if(pass!.isEmpty){
                              return "password is required";
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height/15,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: (){
                              if(_formKey.currentState!.validate()) {
                                if(confirmpasswordController.text != newpasswordController.text){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "You put a wrong password",
                                            style: GoogleFonts.roboto(
                                                fontSize: 20,
                                                color: const Color.fromRGBO(245, 12, 12, 1),
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal
                                            ),
                                          ),
                                      ),
                                  );
                                }
                                else{
                                  LoginClientDio loginClientDio = LoginClientDio();
                                  loginClientDio.changePasswordWithNewPassword(
                                      old_password: oldpasswordController.text,
                                      new_password: newpasswordController.text,
                                      onFail: (e){
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                "$e",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 20,
                                                    color: const Color.fromRGBO(245, 12, 12, 1),
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle: FontStyle.normal
                                                ),
                                              ),
                                          ),
                                        );
                                      },
                                      onSuccess: (e){
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "$e",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 20,
                                                  color: const Color.fromRGBO(1, 245, 12, 1),
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal
                                              ),
                                            ),
                                          ),
                                        );
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context)=>ChangePasswordScreen(accesstoken: widget.accesstoken),
                                            ),
                                        );
                                      }
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(15, 117, 189, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Change Password",
                                style: GoogleFonts.roboto(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
