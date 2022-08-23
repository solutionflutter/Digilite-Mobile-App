import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digilitemobileapp/Client/Server_client.dart';
import 'package:digilitemobileapp/Widget/showAlertBox.dart';
import 'package:digilitemobileapp/models/Campaign_model.dart';
import 'package:digilitemobileapp/models/response_model.dart';
import 'package:digilitemobileapp/screens/singlecampaignviewpage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:intl/intl.dart';
import 'package:radio_button_form_field/radio_button_form_field.dart';

import '../Client/Login_client_dio.dart';

class SurvayDynamicFormPage extends StatefulWidget {
  const SurvayDynamicFormPage({Key? key,
    this.id,
    this.campaignName,
    this.surveyId,
    this.campaignId,
    this.campaignDescription,
    required this.accesstoken,
    this.surveyName,
    this.image,
    this.isDilogeBoxShow,
  }) : super(key: key);
  final int? id;
  final String? campaignName;
  final int? surveyId;
  final String? campaignDescription;
  final int? campaignId;
  final String accesstoken;
  final String? surveyName;
  final String? image;
  final bool? isDilogeBoxShow;
  @override
  _SurvayDynamicFormPageState createState() => _SurvayDynamicFormPageState();
}

class _SurvayDynamicFormPageState extends State<SurvayDynamicFormPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  //final TextEditingController textController = TextEditingController();
  //final TextEditingController short_textController = TextEditingController();
  //final TextEditingController emailController = TextEditingController();
  //final TextEditingController linkController = TextEditingController();
  //final TextEditingController integerController = TextEditingController();
  //final TextEditingController floatController = TextEditingController();
  late List<TextEditingController> _controller = [] ;
  late List<String> selectRedioList = [];
  late List<String>selectdropdownList = [];
  late List<List<String>> selectcheckList = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _email = GlobalKey<FormState>();


  //Show Diloge Box Form variable to store data
  final GlobalKey<FormState> _dilogeBoxFormKey = GlobalKey<FormState>();
  final TextEditingController locationController = TextEditingController();
  final List<Map> dilogeBoxRadioItems = [
    {'value': "d2d", 'display': "D2D"},
    {'value': "wet_market", 'display': "Wet Market"},
    {'value': "school_college", 'display': "School/College"},
    {'value': "sales", 'display': "Sales"},
    {'value': "others", 'display': "Others"},
  ];
  String locationType = "";
  String locationName = "";


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

  List<Map<String,dynamic>>? formValue;
  List<Map<String,dynamic>>? _result;
  String? _resultprint;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? selectedTime = DateTime.now();


  var selectRedio;
  List<String>? selectcheck;
  var selectdropdown;


  @override
  void initState() {
    super.initState();
    _result = [];
    formValue = [];
    _resultprint = "";
    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedTime!);
    dateController.text = formattedDate;
    redirectToLoginPage();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _showDilogeBoxOnFirst();
    });
    print("${LocalStorageInstance.storage.getItem("LocationName")}");
    print("${LocalStorageInstance.storage.getItem("LocationType")}");
  }

   _showDilogeBoxOnFirst() async {
    if(widget.isDilogeBoxShow == true){
      showDiloge(context);
    }
   }



  _onUpdate(int question, String answer){
    int foundKey = 0;
    for(var map in formValue!){
      if(map['question']== question){
        foundKey = question;
        break;
      }
    }

    if(0 != foundKey){
      formValue?.removeWhere((map) {
        return map['question'] == foundKey;
      });
    }

    Map<String, dynamic> json = {
      "question": question,
      "answer": answer.toString(),
    };
    formValue?.add(json);
    setState(() {
      _result = formValue;
      _resultprint = _prettyPrint(formValue);
    });
  }



  String _prettyPrint(jsonObject){
    var encoder = JsonEncoder.withIndent("    ");
    return encoder.convert(jsonObject);
  }



  @override
  Widget build(BuildContext context) {
    int? surveyId = widget.surveyId;
    Future<List<QuestionModel>> question;
    LoginClientDio loginClientDio = LoginClientDio();
    question = loginClientDio.getSingleSurveyQuestionData(surveyId!);
    return WillPopScope(
      onWillPop: () async{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
            SingleCampaignViewPage(
              campaignId: widget.campaignId,
              campaignName: widget.campaignName,
              campaignDescription: widget.campaignDescription,
              accesstoken: widget.accesstoken,
              image: widget.image,
            ),
        ),
        );
        ResponseModel.deleteValueOfLocationTypeLocationName();
        return true;
      },
      child: Scaffold(
        // app bar section start

        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  SingleCampaignViewPage(
                    campaignId: widget.campaignId,
                    campaignName: widget.campaignName,
                    campaignDescription: widget.campaignDescription,
                    accesstoken: widget.accesstoken,
                    image: widget.image,
                  ),
              ),
              );
              ResponseModel.deleteValueOfLocationTypeLocationName();
              },
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            iconSize: 25,
          ),
          title: Text(
            "${widget.campaignName}",
            style: GoogleFonts.roboto(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
          backgroundColor: const Color.fromRGBO(15, 117, 189, 1),
        ),

        // body section start
        body: FutureBuilder<List<QuestionModel>>(
              future: question,
              builder: (BuildContext context,snapshot){
                if(snapshot.hasData){
                  return Form(
                    key: _formKey,
                    child: CustomScrollView(
                      slivers: [


                        //survey name container with slivertoboxadapter
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                            child: Container(
                              height: MediaQuery.of(context).size.height/20,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${widget.surveyName}",
                                    style: GoogleFonts.roboto(
                                      color: const Color.fromRGBO(4, 98, 169, 1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),



                        //name and phone texteditingcontroller container with slivertoboxadapter
                        SliverToBoxAdapter(
                          child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15,),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height/3.5,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextFormField(
                                        controller: nameController,
                                        style: GoogleFonts.roboto(
                                            fontSize: 20,
                                            color: const Color.fromRGBO(79, 75, 75, 1)
                                        ),
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: const BorderSide(color: Color.fromRGBO(182, 181, 181, 1),),
                                            ),
                                            labelText: "Name",
                                            labelStyle: GoogleFonts.roboto(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: const Color.fromRGBO(146, 140, 140, 1),
                                              fontStyle: FontStyle.normal,
                                            ),
                                            hintText: "Enter your name",
                                            hintStyle: GoogleFonts.roboto(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: const Color.fromRGBO(79, 75, 75, 1),
                                              fontStyle: FontStyle.normal,
                                            )
                                        ),
                                        validator: (name){
                                          if(name!.isEmpty){
                                            String error= "Please enter your name";
                                            showErrorBox(error, context);
                                            return error;
                                          }
                                        },
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: phoneController,
                                        style: GoogleFonts.roboto(
                                            fontSize: 20,
                                            color: const Color.fromRGBO(79, 75, 75, 1)
                                        ),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: const BorderSide(color: Color.fromRGBO(182, 181, 181, 1),),
                                          ),
                                          labelText: "Phone Number",
                                          labelStyle: GoogleFonts.roboto(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: const Color.fromRGBO(146, 140, 140, 1),
                                            fontStyle: FontStyle.normal,
                                          ),
                                          hintText: "Enter you phone number",
                                          hintStyle: GoogleFonts.roboto(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            color: const Color.fromRGBO(79, 75, 75, 1),
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                        validator: (pass){
                                          if(pass!.isEmpty){
                                            showErrorBox("please enter the phone number", context);
                                            return "please enter the phone number";
                                          }else if(pass.toString().length < 11){
                                            showErrorBox("Number is not valid", context);
                                            return "Number is not valid";
                                          }else if(pass.toString().length > 11){
                                            showErrorBox("Number is not valid", context);
                                            return "Number is not valid";
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ),



                        //dynamic question sliverlist
                        SliverList(delegate: SliverChildBuilderDelegate(
                                (BuildContext context,int index){
                                  int length = snapshot.data!.length;
                                  _controller.add(TextEditingController());
                                  selectdropdownList.length = length;
                                  selectcheckList.length = length;
                                  selectRedioList.length = length;
                              if(snapshot.data![index].type == "text" ||
                                  snapshot.data![index].type=="float"
                              )
                              {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: RichText(
                                        text: TextSpan(
                                          text: "${snapshot.data![index].question} ",
                                          style:  GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            color: const Color.fromRGBO(146, 140, 140, 1),
                                          ),
                                          children:  [
                                            snapshot.data![index].is_required == true ?
                                            TextSpan(
                                              text: "*",
                                              style: GoogleFonts.roboto(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                color: Colors.red,
                                              ),
                                            ) : TextSpan(
                                              text: " ",
                                              style: GoogleFonts.roboto(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                      child: TextFormField(
                                        controller: _controller[index],
                                        keyboardType: snapshot.data![index].type == "float"?
                                        TextInputType.number : snapshot.data![index].type == "email" ? TextInputType.emailAddress:
                                        TextInputType.text,
                                        inputFormatters: snapshot.data![index].type == "float" ?
                                        [FilteringTextInputFormatter.allow(RegExp("[0-9.]")),] :
                                        [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@,.?/@!`~<>{} ]")),],
                                        style: GoogleFonts.roboto(
                                            fontSize: 20,
                                            color: const Color.fromRGBO(79, 75, 75, 1)
                                        ),
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: const BorderSide(color: Color.fromRGBO(182, 181, 181, 1),),
                                            ),
                                            labelText: "${snapshot.data![index].type}",
                                            labelStyle: GoogleFonts.roboto(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: const Color.fromRGBO(146, 140, 140, 1),
                                              fontStyle: FontStyle.normal,
                                            ),
                                            hintText: "${snapshot.data![index].question}",
                                            hintStyle: GoogleFonts.roboto(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: const Color.fromRGBO(79, 75, 75, 1),
                                              fontStyle: FontStyle.normal,
                                            )
                                        ),
                                        onChanged: (value){
                                          if(snapshot.data![index].type == "float"){
                                            setState(() {
                                              _controller[index].value = _controller[index].value.copyWith(
                                                text: value,
                                                selection: TextSelection(baseOffset: value.length, extentOffset: value.length),
                                              );
                                              var id = snapshot.data![index].id;
                                              _onUpdate(id!, _controller[index].text);
                                            });
                                          }if(snapshot.data![index].type == "text"){
                                            _controller[index].value = _controller[index].value.copyWith(
                                              text: value,
                                              selection: TextSelection(baseOffset: value.length, extentOffset: value.length),
                                            );
                                            setState(() {
                                              var id = snapshot.data![index].id;
                                              _onUpdate(id!, _controller[index].text);
                                            });
                                          }
                                          //var id = snapshot.data![index].id;
                                          //_onUpdate(id!, value);
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              } if(snapshot.data![index].type == "email"){
                                    return Form(
                                      key: _email,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: RichText(
                                              text: TextSpan(
                                                text: "${snapshot.data![index].question} ",
                                                style:  GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                  color: const Color.fromRGBO(146, 140, 140, 1),
                                                ),
                                                children:  [
                                                  snapshot.data![index].is_required == true ?
                                                  TextSpan(
                                                    text: "*",
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w700,
                                                      fontStyle: FontStyle.normal,
                                                      color: Colors.red,
                                                    ),
                                                  ) : TextSpan(
                                                    text: " ",
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w700,
                                                      fontStyle: FontStyle.normal,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                            child: TextFormField(
                                              autovalidateMode: AutovalidateMode.onUserInteraction,
                                              controller: _controller[index],
                                              keyboardType: TextInputType.emailAddress,
                                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@.]")),],
                                              style: GoogleFonts.roboto(
                                                  fontSize: 20,
                                                  color: const Color.fromRGBO(79, 75, 75, 1)
                                              ),
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                    borderSide: const BorderSide(color: Color.fromRGBO(182, 181, 181, 1),),
                                                  ),
                                                  labelText: "${snapshot.data![index].type}",
                                                  labelStyle: GoogleFonts.roboto(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color.fromRGBO(146, 140, 140, 1),
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                  hintText: "${snapshot.data![index].question}",
                                                  hintStyle: GoogleFonts.roboto(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color.fromRGBO(79, 75, 75, 1),
                                                    fontStyle: FontStyle.normal,
                                                  )
                                              ),
                                              validator: (value){
                                                if(EmailValidator.validate(value.toString()) == false){
                                                  return "enter a valid email address";
                                                }else if(value!.isEmpty){
                                                  return "email field must be fill up";
                                                }
                                              },
                                              onSaved: (value){
                                                setState(() {
                                                  var id = snapshot.data![index].id;
                                                  _onUpdate(id!, _controller[index].text);
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                              }
                              if(snapshot.data![index].type=="date"){
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: RichText(
                                        text: TextSpan(
                                          text: "${snapshot.data![index].question} ",
                                          style:  GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            color: const Color.fromRGBO(146, 140, 140, 1),
                                          ),
                                          children:  [
                                            snapshot.data![index].is_required == true ?
                                            TextSpan(
                                              text: "*",
                                              style: GoogleFonts.roboto(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                color: Colors.red,
                                              ),
                                            ) : TextSpan(
                                              text: " ",
                                              style: GoogleFonts.roboto(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap:() async {
                                        print("index :  ${index}");
                                        DateTime? pickedTime = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1945),
                                            lastDate: DateTime(3000));
                                        if(pickedTime != null ){
                                          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedTime);

                                          setState(() {
                                            //_controller[index].text = formattedDate;
                                            dateController.text = formattedDate;
                                            _onUpdate(snapshot.data![index]!.id!.toInt(), dateController.text);
                                          });
                                        }else{
                                          print("Date is not selected");
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                        child: TextFormField(
                                          controller: dateController,
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
                                              hintText: "Select Date",
                                              hintStyle: GoogleFonts.roboto(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                                color: const Color.fromRGBO(79, 75, 75, 1),
                                                fontStyle: FontStyle.normal,
                                              )
                                          ),
                                          validator: (value){
                                            if(value!.isEmpty){
                                              return "Please pick a date";
                                            }else{
                                              setState(() {
                                                var id = snapshot.data![index].id;
                                                _onUpdate(id!, value);
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }else if(snapshot.data![index].type == "radio"){
                                List<String>? select = snapshot.data![index].choices?.cast<String>();
                                int? length = select?.length.toInt();
                                return Container(
                                  height: MediaQuery.of(context).size.height * (length! * .12),
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: RichText(
                                          text: TextSpan(
                                            text: "${snapshot.data![index].question} ",
                                            style:  GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              color: const Color.fromRGBO(146, 140, 140, 1),
                                            ),
                                            children:  [
                                              snapshot.data![index].is_required == true ?
                                              TextSpan(
                                                text: "*",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.red,
                                                ),
                                              ) : TextSpan(
                                                text: " ",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                          child: RadioButtonGroup(
                                            labels: select,
                                            picked: selectRedioList[index],
                                            onSelected: (String selected){
                                              setState(() {
                                                selectRedioList[index] = selected;
                                                print("${selected.toString()}");
                                                var id = snapshot.data![index].id;
                                                _onUpdate(id!, selected.toString());
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              else if(snapshot.data![index].type == "select"){
                                List<String>? check = snapshot.data![index].choices?.cast<String>();
                                return Container(
                                  height: MediaQuery.of(context).size.height/6,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: RichText(
                                          text: TextSpan(
                                            text: "${snapshot.data![index].question} ",
                                            style:  GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              color: const Color.fromRGBO(146, 140, 140, 1),
                                            ),
                                            children:  [
                                              snapshot.data![index].is_required == true ?
                                              TextSpan(
                                                text: "*",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.red,
                                                ),
                                              ) : TextSpan(
                                                text: " ",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                          child: DropdownButton(
                                            hint: const Text("please select"), // Not necessary for Option 1
                                            value: selectdropdownList[index],
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectdropdownList[index] = newValue.toString();
                                                print("$selectdropdown");
                                                var id = snapshot.data![index].id;
                                                _onUpdate(id!, newValue.toString());
                                              });
                                            },
                                            items: check?.map((val){
                                              return DropdownMenuItem<String>(
                                                value: val,
                                                child: Text(val),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              else if(snapshot.data![index].type == "select_multiple"){
                                List<String>? check = snapshot.data![index].choices?.cast<String>();
                                int? length = check?.length.toInt();
                                return Container(
                                  height: MediaQuery.of(context).size.height * (length! * .099),
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: RichText(
                                          text: TextSpan(
                                            text: "${snapshot.data![index].question} ",
                                            style:  GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              color: const Color.fromRGBO(146, 140, 140, 1),
                                            ),
                                            children:  [
                                              snapshot.data![index].is_required == true ?
                                              TextSpan(
                                                text: "*",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.red,
                                                ),
                                              ) : TextSpan(
                                                text: " ",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                          child: CheckboxGroup(
                                            labels: check,
                                            checked: selectcheckList[index],
                                            onSelected: (List<String> selected){
                                              setState(() {
                                                selectcheckList[index] = selected;
                                                print("${selected.toString()}");
                                                var id = snapshot.data![index].id;
                                                _onUpdate(id!, selected.toString());
                                              });
                                            }
                                          )
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              else{
                                return  Text(
                                  "${snapshot.data![index].question}",
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      color: const Color.fromRGBO(146, 140, 140, 1),
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500
                                  ),
                                );
                              }
                            },
                            childCount: snapshot.data!.length
                        ),),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                            child: ElevatedButton(
                              onPressed: (){
                                if(_formKey.currentState!.validate()){
                                  if(_email.currentState!.validate()){
                                    _email.currentState!.save();
                                    loginClientDio.sendDataTotheServer(
                                      id: surveyId,
                                      name: nameController.text,
                                      phoneNumber: phoneController.text,
                                      location_name: LocalStorageInstance.storage.getItem("LocationName"),
                                      location_type: LocalStorageInstance.storage.getItem("LocationType"),
                                      json: _result!,
                                      onSuccess: (e){
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content:
                                          Text(
                                            "$e",
                                            style: GoogleFonts.roboto(
                                                fontSize: 20,
                                                color: const Color.fromRGBO(0, 255, 0, 1),
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal
                                            ),
                                          ),
                                            duration: const Duration(seconds: 3),
                                          ),
                                        );
                                        Navigator.push(
                                          context, MaterialPageRoute(builder:
                                            (context)=> SurvayDynamicFormPage(
                                          id: widget.id,
                                          surveyId: widget.surveyId,
                                          campaignName: widget.campaignName,
                                          campaignDescription: widget.campaignDescription,
                                          campaignId: widget.campaignId,
                                          accesstoken: widget.accesstoken,
                                          surveyName: widget.surveyName,
                                          image: widget.image,
                                          isDilogeBoxShow: false,
                                        ),
                                        ),
                                        );
                                      },
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
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                  primary: const Color.fromRGBO(15, 117, 189, 1)
                              ),
                              child: Center(
                                child: Text(
                                  "SUBMIT",
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }else {
                  return const Center(child: CircularProgressIndicator(),);
                }
              },
            ),
      ),
    );
  }




  void showDiloge(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return WillPopScope(
          onWillPop: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                SingleCampaignViewPage(
                  campaignId: widget.campaignId,
                  campaignName: widget.campaignName,
                  campaignDescription: widget.campaignDescription,
                  accesstoken: widget.accesstoken,
                  image: widget.image,
                ),
            ),
            );
            ResponseModel.deleteValueOfLocationTypeLocationName();
            return true;
          },
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              AlertDialog(
                scrollable: false,
                content: Container(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Form(
                          key: _dilogeBoxFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Location Name : ",
                                      style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  controller: locationController,
                                  style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      color: const Color.fromRGBO(79, 75, 75, 1)
                                  ),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: Color.fromRGBO(182, 181, 181, 1),),
                                      ),
                                      labelText: "Location Name",
                                      labelStyle: GoogleFonts.roboto(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: const Color.fromRGBO(146, 140, 140, 1),
                                        fontStyle: FontStyle.normal,
                                      ),
                                      hintText: "Enter you Location",
                                      hintStyle: GoogleFonts.roboto(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: const Color.fromRGBO(79, 75, 75, 1),
                                        fontStyle: FontStyle.normal,
                                      )
                                  ),
                                  validator: (location){
                                    if(location!.isEmpty){
                                      return "please enter a location";
                                    }else{
                                      setState(() {
                                        locationName = location;
                                      });
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Location type : ",
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: RadioButtonFormField(
                                  toggleable: true,
                                  context: context,
                                  value: 'value',
                                  display: 'display',
                                  data: dilogeBoxRadioItems,
                                  validator: (value){
                                    if(value.toString() == "null"){
                                      return "Please select a value";
                                    }else{
                                      setState(() {
                                        locationType = value.toString();
                                      });
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue.shade600,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: (){
                                    if(_dilogeBoxFormKey.currentState!.validate()){
                                      print("${locationType}");
                                      print("${locationName}");
                                      ResponseModel.setValueOfLocationTypeLocationName(locationName, locationType);
                                      Navigator.pop(context);
                                      /*if(myValue != "null"){
                                          print("${myValue}");
                                        }else{
                                          print("please fill all the value");
                                        }*/
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content:
                                        Text(
                                          "please fill the value of all field",
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
                                  },
                                  child: const Center(
                                    child: Text("Submit"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                SingleCampaignViewPage(
                                  campaignId: widget.campaignId,
                                  campaignName: widget.campaignName,
                                  campaignDescription: widget.campaignDescription,
                                  accesstoken: widget.accesstoken,
                                  image: widget.image,
                                ),
                            ),
                            );
                            ResponseModel.deleteValueOfLocationTypeLocationName();
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
          ),
        );
      },
    );
  }



  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? showErrorBox(String error, BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content:
      Text(
        "${error}",
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
}
