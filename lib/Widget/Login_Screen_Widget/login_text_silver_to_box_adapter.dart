import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

Widget loginTextSliverToBoxAdapter(BuildContext context){
  return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: SizedBox(
          height: MediaQuery.of(context).size.height/10,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
                "LOGIN",
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  color: const Color.fromRGBO(4, 98, 169, 1),
                )
            ),
          ),
        ),
      )
  );
}