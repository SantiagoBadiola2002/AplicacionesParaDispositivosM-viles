// lib/styles/styles.dart

import 'package:flutter/material.dart';

// Text Styles
const TextStyle kLoginTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 32,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w800,
  height: 0,
  letterSpacing: 1.28,
);

const TextStyle kLabelTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 12,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  height: 0.14,
);

const TextStyle kHintTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 14,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  height: 0.10,
);

const TextStyle kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 14,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
  height: 0.10,
);

// Button Styles
final ButtonStyle kButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Color(0xFF334155),
  padding: EdgeInsets.symmetric(vertical: 10),
);

// Border Styles
final ShapeDecoration kInputDecoration = ShapeDecoration(
  shape: RoundedRectangleBorder(
    side: BorderSide(
      width: 1,
      strokeAlign: BorderSide.strokeAlignCenter,
      color: Colors.white,
    ),
  ),
);
