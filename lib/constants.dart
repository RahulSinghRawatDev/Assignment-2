import 'package:flutter/material.dart';

const kdrawerTileStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0XFF8D8E98),
);

const kdrawerHeaderStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 35.0,
);

const KTextFieldInputDecorator = InputDecoration(
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
    ));
