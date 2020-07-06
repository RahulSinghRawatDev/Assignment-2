import 'package:flutter/material.dart';
import 'package:rahulassignment2/bloc/contact_bloc.dart';
import 'package:rahulassignment2/model/contact.dart';
import 'package:rahulassignment2/utility/util.dart';

class FavouriteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavouriteList();
}

class _FavouriteList extends State {
  ContactBloc _contactBloc = ContactBloc();

  @override
  void dispose() {
    _contactBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Favourite List'),
      ),*/
      body: getContactWidget(),
    );
  }

  Widget getContactWidget() {
    return StreamBuilder(
      stream: _contactBloc.contacts,
      builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) =>
          getContactCardWidget(snapshot),
    );
  }

  Widget getContactCardWidget(AsyncSnapshot<List<Contact>> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        padding: EdgeInsets.all(5.0),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5.0,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Utility.loadUserImage(
                          snapshot.data[index].image, 60.0, 60.0),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            snapshot.data[index].name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          Text(snapshot.data[index].mobileNo)
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.blueAccent,
                  ),
                ],
                /*   mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Utility.loadUserImage(snapshot.data[index].image, 60.0, 60.0),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    children: <Widget>[
                      Text(snapshot.data[index].name),
                      Text(snapshot.data[index].mobileNo)
                    ],
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.blueAccent,
                  ),
                ],*/
              ),
            ),
          );
        },
      );
    } else {
      return Center(
        child: loadContacts(),
      );
    }
  }

  Widget loadContacts() {
    _contactBloc.getFavContacts();
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
