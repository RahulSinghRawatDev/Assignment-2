import 'package:flutter/material.dart';
import 'package:rahulassignment2/screens/add_contact_screen.dart';
import 'package:rahulassignment2/screens/contact_list.dart';
import 'package:rahulassignment2/screens/favourites_list.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedItem = "contacts";
  String _title = "Contact List";

  _getDrawerScreen(String screenTag) {
    switch (screenTag) {
      case "contacts":
        {
          _title = "Contacts";
          return ContactListDummy();
        }
      case "fav":
        {
          _title = "Favourites";
          return FavouriteList();
        }
      case "add":
        {
          _title = "Add Contact";
          return AddContactScreen();
        }
    }
  }

  _onItemSelection(String newItem) {
    setState(() {
      _selectedItem = newItem;
      _getDrawerScreen(_selectedItem);
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blueAccent),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '$_title',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.all(50.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('images/navimg.jpg'),
                fit: BoxFit.cover,
              )),
              child: Text(
                'Contact App',
                style: kdrawerHeaderStyle,
                textAlign: TextAlign.left,
              ),
            ),
            ListTile(
              onTap: () {
                _onItemSelection('contacts');
              },
              selected: "contacts" == _selectedItem,
              title: Text(
                "Contact List",
                style: kdrawerTileStyle,
              ),
            ),
            ListTile(
              onTap: () {
                _onItemSelection('fav');
              },
              selected: "fav" == _selectedItem,
              title: Text(
                "Favourite contacts",
                style: kdrawerTileStyle,
              ),
            ),
            ListTile(
              onTap: () {
                _onItemSelection('add');
              },
              selected: "add" == _selectedItem,
              title: Text(
                "Add new contact",
                style: kdrawerTileStyle,
              ),
            ),
          ],
        ),
      ),
      body: _getDrawerScreen(_selectedItem),
    );
  }
}
