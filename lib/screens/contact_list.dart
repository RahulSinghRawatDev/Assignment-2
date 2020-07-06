import 'package:flutter/material.dart';
import 'package:rahulassignment2/bloc/contact_bloc.dart';
import 'package:rahulassignment2/model/contact.dart';
import 'package:rahulassignment2/utility/util.dart';

import 'add_contact_screen.dart';

class ContactListDummy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContactListDummy();
}

class _ContactListDummy extends State {
  ContactBloc _contactBloc = ContactBloc();

  @override
  void dispose() {
    _contactBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getContactWidget(),
    );
  }

  Widget getContactWidget() {
    //  _contactBloc.getContacts();
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
          return GestureDetector(
/*
            onLongPress: () {
              _contactBloc
                  .deleteContact(snapshot.data[index].id)
                  .then((value) => onContactDeleted(value));
            },
            onTap: () {
              navigateToUpdateContact(snapshot.data[index]);
            },
*/
            onTap: () {
              navigateToUpdateContact(snapshot.data[index]);
            },
            child: Card(
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
                    updateFavIcon(snapshot.data[index].isFav)
                  ],
                ),
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

  Widget updateFavIcon(int favStatus) {
    if (favStatus == 0) {
      return Icon(
        Icons.star_border,
        color: Colors.blueAccent,
      );
    } else {
      return Icon(
        Icons.star,
        color: Colors.blueAccent,
      );
    }
  }

  Widget loadContacts() {
    _contactBloc.getContacts();
    return Center(
      child: Text('Loading Data, Please Wait'),
    );
  }

  void navigateToUpdateContact(Contact selContact) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => AddContactScreen(),
            settings: RouteSettings(arguments: selContact)))
        .whenComplete(() => loadContacts());
  }
}
