import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 40.0,


);

const kButtonTextStyle = TextStyle(
  fontSize: 32.0,
  fontFamily: 'Spartan MB',
  color: Colors.black,
  fontWeight:FontWeight.bold,
  backgroundColor: Colors.blueGrey,
  shadows: [Shadow(blurRadius: 8.0, color: Colors.orangeAccent, offset: Offset(0.0, 3.0)),]
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
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);
