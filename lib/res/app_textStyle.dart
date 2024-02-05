

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle authHeadings(Color color) {
    return GoogleFonts.poppins(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: color
    );
  }

  static TextStyle authHintText(Color color) {
    return GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: color
    );
  }

  static TextStyle reqHintText(Color color) {
    return GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color
    );
  }


  static TextStyle logOutDialog(Color color) {
    return GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color
    );
  }
}