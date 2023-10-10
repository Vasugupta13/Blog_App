import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:subspace/consts/colors.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double horizontal;
  final Color? colorBorder;
  final double vertical;
  final Color color;
  final String? text1;
  final double? size;
  final double borderRadius;
  final FontWeight? weight;
  final double? borderWidth;
  final Color textColor;
  final TextOverflow? textOverflow;
  final bool? softWrap;
  final int maxLines;
  const ReusableButton({
    super.key,
    this.borderRadius = 8,
    required this.text,
    required this.horizontal,
    required this.vertical,
    required this.color,

    this.onPressed,
    this.text1, this.size = 20,
    this.weight = FontWeight.w600, this.borderWidth = 2,
    this.colorBorder=Colors.black, this.textColor = Colors.black, this.textOverflow, this.softWrap,  this.maxLines =1,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
       foregroundColor: AppColors.kBlack,
          elevation: 0,
          shape: RoundedRectangleBorder(
              side:  BorderSide(
                width: borderWidth ?? 2,
                color: colorBorder!,
              ),
              borderRadius: BorderRadius.circular(borderRadius)),
          backgroundColor: color,
          padding:
          EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal)),
      child: Align(
        alignment: Alignment.center,
        child: Text(
            text,
            maxLines: maxLines,
            softWrap: softWrap,
            overflow: textOverflow,
            style: GoogleFonts.poppins(
              fontWeight: weight,
              fontSize: size,
              color: textColor,

            )
        ),
      ),);
  }
}
