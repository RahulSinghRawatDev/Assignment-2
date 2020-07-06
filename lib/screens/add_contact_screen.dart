import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rahulassignment2/bloc/contact_bloc.dart';
import 'package:rahulassignment2/model/contact.dart';
import 'package:rahulassignment2/utility/util.dart';

class AddContactScreen extends StatefulWidget {
  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();
  ContactBloc _contactBloc = ContactBloc();
  Future<int> _dbResult;
  Future<File> _selImage;
  Contact _contact = Contact();

  void _chooseImage() {
    _selImage = Utility.pickImage(context);
  }

  Widget loadInitialImage() {
    if (_contact.image != null) {
      return Container(
        child: Utility.loadUserImage(_contact.image, 120.0, 120.0),
      );
    } else {
      AssetImage assetImage = AssetImage('images/profileplaceholder.png');
      Image image = Image(image: assetImage, width: 120.0, height: 120.0);
      return Container(
        child: image,
      );
    }
  }

  String _isEmpty(String data) {
    return (data.isEmpty) ? 'Field cannot empty' : null;
  }

  @override
  Widget build(BuildContext context) {
    var tempContact = ModalRoute.of(context).settings.arguments;
    if (tempContact != null) _contact = tempContact;

    return Scaffold(
      appBar: tempContact != null
          ? AppBar(
              iconTheme: IconThemeData(
                color: Colors.blueAccent, //change your color here
              ),
              backgroundColor: Colors.white,
              title: Text(
                'Update Contact',
                style: TextStyle(color: Colors.black),
              ),
            )
          : null,
      body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: _chooseImage,
                  child: FutureBuilder(
                    future: _selImage,
                    builder: (context, AsyncSnapshot<File> snapshot) {
                      if (snapshot.hasData) {
                        _contact.image = Utility.base64String(
                            snapshot.data.readAsBytesSync());
                        return Image(image: FileImage(snapshot.data));
                      } else if (snapshot.hasError)
                        debugPrint('Unable to load image');
                      return loadInitialImage();
                    },
                  ),
                ),
                CheckboxListTile(
                  title: Text("Add to Favourite"),
                  value: _contact.isFav == 1 ? true : false,
                  onChanged: (value) {
                    setState(() {
                      value ? _contact.isFav = 1 : _contact.isFav = 0;
                    });
                  },
                ),
                TextFormField(
                  initialValue: _contact.name,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: _isEmpty,
                  onSaved: (newValue) => _contact.name = newValue,
                ),
                TextFormField(
                  initialValue: _contact.mobileNo,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: 'Mobile',
                  ),
                  validator: _isEmpty,
                  onSaved: (newValue) => _contact.mobileNo = newValue,
                ),
                TextFormField(
                  initialValue: _contact.landlineNo,
                  keyboardType: TextInputType.phone,
                  maxLength: 12,
                  decoration: InputDecoration(
                    labelText: 'LandLine',
                  ),
                  validator: _isEmpty,
                  onSaved: (newValue) => _contact.landlineNo = newValue,
                ),
                SizedBox(
                  height: 40.0,
                ),
                ButtonTheme(
                    minWidth: 300.0,
                    height: 40.0,
                    child: FlatButton(
                      onPressed: _submitContact,
                      color: Colors.blueAccent,
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
              ],
            ),
          )),
    );
  }

  void _submitContact() {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _saveContactinDb();
    }
  }

  void _saveContactinDb() {
    var message = "";
    if (_contact.id == null) {
      _dbResult = _contactBloc.addContact(_contact);
      message = 'Contact added successfully!!!';
    } else {
      _dbResult = _contactBloc.updateContact(_contact);
      message = 'Contact updated successfully!!!';
    }
    _dbResult.then((value) {
      if (message.contains('updated')) Navigator.pop(context);
      if (value != -1) {
        print(message);
        Fluttertoast.showToast(msg: message);
      } else
        Fluttertoast.showToast(msg: 'Something went wrong.');
    });
  }
}
