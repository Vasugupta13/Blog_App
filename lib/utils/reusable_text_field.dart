import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableText extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextOverflow? overflow;
  final bool? softWrap;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final int? maxLines;
  const ReusableText(
      {
        super.key,
        required this.text,
        this.fontSize = 15,
        this.overflow ,
        this.softWrap ,
        this.fontWeight = FontWeight.w500,
        this.color = Colors.black,
        this.textAlign = TextAlign.left, this.maxLines
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ,
      textAlign: textAlign,
      overflow: overflow,
      softWrap: softWrap,
      style: GoogleFonts.workSans(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}