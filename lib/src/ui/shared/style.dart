import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Colors

const Color kBlue = Color(0xFF07627F);
const Color kYellow = Color(0xFFFAB70A);
const Color kText = Color(0xFF282F39);
Color kGrey = Colors.grey.shade300;
const Color kBorder = Color(0xffDADEE3);
const Color kBlack = Color(0xff303030);
const Color accentOrange = Color(0xFFF36F20);

// Padding
const double kPaddingS = 8.0;
const double kPaddingM = 16.0;
const double kPaddingL = 32.0;

// Spacing
const double kSpaceS = 8.0;
const double kSpaceM = 16.0;

EdgeInsets bodyMargin =
    EdgeInsets.only(top: 60.0, left: 24, right: 24, bottom: 24);

TextStyle heading = TextStyle(fontWeight: FontWeight.bold, fontSize: 24);
TextStyle subHeading =
    TextStyle(fontWeight: FontWeight.bold, color: kText, fontSize: 18);
TextStyle subtrail = TextStyle(color: kGrey, fontSize: 18);

OutlineInputBorder searchBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: BorderSide(color: Colors.transparent),
);
