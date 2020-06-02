import 'package:flutter/material.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';

///[For the cathegoryCard]

TextStyle categoryNameTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w800,
  fontSize: SizeConfig.safeBlockHorizontal * 4.5,
);
TextStyle categoryTagTextStyle = TextStyle(
    color: Colors.black38,
    fontWeight: FontWeight.w800,
    fontSize: SizeConfig.safeBlockHorizontal * 3.5);

//====================
///[For the Status bar]
Color underlinedColor = Colors.red;
Color transparentColor = Colors.transparent;
TextStyle statusBarTextStyleEnabled = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w800,
    fontSize: SizeConfig.safeBlockHorizontal * 5,
    decoration: TextDecoration.none);

TextStyle statusBarTextStyleDisabled = TextStyle(
    color: Colors.black26,
    fontWeight: FontWeight.w800,
    fontSize: SizeConfig.safeBlockHorizontal * 5,
    decoration: TextDecoration.none);
//=====================
///[For the Header]
TextStyle headerTextStyle = TextStyle(
    fontSize: SizeConfig.safeBlockHorizontal * 33.3,
    fontWeight: FontWeight.w800);
//==================
///[For the right corner]

TextStyle timeTextStyle = TextStyle(
    fontSize: SizeConfig.safeBlockHorizontal * 7,
    fontWeight: FontWeight.w700,
    color: Colors.red);

//===================
///[For The left corner]
TextStyle wifitextStyle = TextStyle(
    fontSize: SizeConfig.safeBlockHorizontal * 2.2,
    fontWeight: FontWeight.w800,
    color: Colors.white);

TextStyle batteryTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: SizeConfig.safeBlockHorizontal * 5);

//===================
///[For the itemCard]
TextStyle lowerTitleTextStyle = TextStyle(
    fontSize: SizeConfig.safeBlockHorizontal * 3,
    fontWeight: FontWeight.w900,
    color: Colors.white);

TextStyle upperTitleTextStyle = TextStyle(
    fontSize: SizeConfig.safeBlockHorizontal * 7,
    fontWeight: FontWeight.w900,
    color: Colors.white);

//===================
///[For the Price Card]
TextStyle priceTextStyle = TextStyle(
    fontSize: SizeConfig.safeBlockHorizontal * 5,
    fontWeight: FontWeight.w800,
    color: Colors.black);

TextStyle counterTextStyle = TextStyle(
    fontSize: SizeConfig.safeBlockHorizontal * 5,
    fontWeight: FontWeight.w500,
    color: Colors.black54);

//=====================
///[For the category Description]
TextStyle categoryDescriptionTextStyle = TextStyle(
    fontSize: SizeConfig.safeBlockHorizontal * 5.5,
    fontWeight: FontWeight.w500,
    color: Colors.black26);

//======================
///[For the Product detail screen]

TextStyle productDescriptionTextStyle = TextStyle(
    fontSize: SizeConfig.safeBlockHorizontal * 4.5,
    fontWeight: FontWeight.w600,
    color: Colors.grey);

TextStyle productDescriptionPriceTextStyle = TextStyle(
  fontSize: SizeConfig.safeBlockHorizontal * 7,
  fontWeight: FontWeight.bold,
);

TextStyle productDescriptionTitleTextStyle = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.w500,
    fontSize: SizeConfig.safeBlockHorizontal * 4.4);

TextStyle productDescriptionAddCardTextStyle = TextStyle(
    color: Colors.white,
    fontSize: SizeConfig.safeBlockHorizontal * 5,
    fontWeight: FontWeight.bold);
