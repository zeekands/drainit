import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextPoppinsBold extends StatelessWidget {
  const TextPoppinsBold({
    Key? key,
    required this.text,
    required this.fontSize,
    this.overflow,
    this.textColour,
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final Color? textColour;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        color: textColour,
      ),
    );
  }
}

class TextPoppinsRegular extends StatelessWidget {

  const TextPoppinsRegular({
    Key? key,
    required this.text,
    required this.fontSize,
    this.textColour,
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final Color? textColour;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.normal,
        fontSize: fontSize,
        color: textColour,
      ),
    );
  }
}

class TextPoppinsItalic extends StatelessWidget {
  const TextPoppinsItalic({
    Key? key,
    required this.text,
    required this.fontSize,
    this.textColour,
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final Color? textColour;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: textColour,
          fontWeight: FontWeight.normal,
          fontSize: fontSize,
          fontStyle: FontStyle.italic,),
    );
  }
}
