import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const RoundButton({Key? key,
    required this.title,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 500,
        height: 50,
        decoration: BoxDecoration(
            color: Color.fromRGBO(59, 150, 138, 1),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: Text(title,style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)),),),
      ),
    );
  }
}
