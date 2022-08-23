import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget imageSliverToBoxAdapter(BuildContext context){
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 65),
      child: Container(
        height: MediaQuery.of(context).size.height/4,
        width: MediaQuery.of(context).size.width/4,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/Login_screen_Image/Login_screen_company_image.png"),
              fit: BoxFit.contain,
            )
        ),
      ),
    ),
  );
}