import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'BB Anonym Pro',
  fontSize: 50.0,
);
const kCelciusTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'BB Anonym Pro',
    fontSize: 46.0,
    textBaseline: TextBaseline.alphabetic);

const kMessageTextStyle = TextStyle(
  fontFamily: 'BB Anonym Pro',
  fontSize: 20.0,
  color: Colors.white38,
);

const kCityTextStyle = TextStyle(
  fontFamily: 'BB Anonym Pro',
  color: Colors.white,
  fontSize: 30.0,
);
const kDateTextStyle = TextStyle(
  fontFamily: 'BB Anonym Pro',
  color: Colors.white38,
  fontSize: 20.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'BB Anonym Pro',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);
const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(40.0),
    ),
    borderSide: BorderSide.none,
  ),
);
