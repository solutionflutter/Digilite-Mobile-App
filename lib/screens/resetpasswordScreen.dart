import 'package:digilitemobileapp/Client/Login_client_dio.dart';
import 'package:digilitemobileapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String accessToken = "access";
    return WillPopScope(
      onWillPop: ()async {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(accessToken: accessToken),),);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(accessToken: accessToken),),);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            iconSize: 25,
          ),
          title: Text(
            "Reset Password",
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
                            controller:  usernameController,
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                color: const Color.fromRGBO(79, 75, 75, 1)
                            ),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Color.fromRGBO(182, 181, 181, 1),),
                                ),
                                labelText: "BP Code",
                                labelStyle: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(146, 140, 140, 1),
                                  fontStyle: FontStyle.normal,
                                ),
                                hintText: "Enter you bp code",
                                hintStyle: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(79, 75, 75, 1),
                                  fontStyle: FontStyle.normal,
                                )
                            ),
                            validator: (username){
                              if(username!.isEmpty){
                                return "please enter your bp code";
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
                                  LoginClientDio loginClientDio = LoginClientDio();
                                  loginClientDio.resetPassword(
                                      username: usernameController.text,
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(accessToken: accessToken),),);
                                      });
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
                                  "Reset Password",
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
      ),
    );
  }
}
