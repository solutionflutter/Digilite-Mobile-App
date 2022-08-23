import 'package:digilitemobileapp/Client/Login_client_dio.dart';
import 'package:digilitemobileapp/Widget/Login_Screen_Widget/image_sliver_to_box_adapter.dart';
import 'package:digilitemobileapp/Widget/Login_Screen_Widget/login_text_silver_to_box_adapter.dart';
import 'package:digilitemobileapp/models/response_model.dart';
import 'package:digilitemobileapp/screens/Splash_screen.dart';
import 'package:digilitemobileapp/screens/base_screen.dart';
import 'package:digilitemobileapp/screens/resetpasswordScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key,required this.accessToken}) : super(key: key);
  final String accessToken;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ResponseModel.getFormDataFormLocalStorage().then((value) => debugPrint(value.toString()));
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const SplashScreen(),),);
        //Navigator.of(context).pop(false);
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: CustomScrollView(
          slivers: [
            imageSliverToBoxAdapter(context),
            loginTextSliverToBoxAdapter(context),


            // login screen form with email and password add forget password

            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height/3,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    // Form of login screen data with email and password TextFormField
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35,),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height/3.7,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextFormField(
                                controller: emailController,
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
                                  hintText: "Enter you BP Code",
                                  hintStyle: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: const Color.fromRGBO(79, 75, 75, 1),
                                    fontStyle: FontStyle.normal,
                                  )
                                ),
                                validator: (email){
                                  if(email!.isEmpty){
                                    return "please enter your bp code";
                                  }
                                },
                              ),
                              TextFormField(
                                controller: passwordController,
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
                                    labelText: "Password",
                                    labelStyle: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: const Color.fromRGBO(146, 140, 140, 1),
                                      fontStyle: FontStyle.normal,
                                    ),
                                    hintText: "Enter you password",
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
                            ],
                          ),
                        ),
                      ),
                    ),


                    //Forgot Password InkWell button

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Container(
                        height: MediaQuery.of(context).size.height/25,
                        width: MediaQuery.of(context).size.width,
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=> const ResetPasswordScreen()
                              ,),);
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                                "Forgot Password",
                              style: GoogleFonts.roboto(
                                fontSize: 17,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromRGBO(15, 117, 189, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),


            //login button sliver to box adapter with functions

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 25),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/15,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()) {
                        LoginClientDio loginClientDio = LoginClientDio();
                        loginClientDio.loginWithUsernameAndPassword(
                            username: emailController.text,
                            password: passwordController.text,
                            onFail: (e){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content:
                                  Text(
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
                            onSuccess: (String token){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BaseScreen(accessToken: token,),),);
                            },
                        );
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
                            "LOGIN",
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
            ),
          ]
        ),
      ),
    );
  }
}
