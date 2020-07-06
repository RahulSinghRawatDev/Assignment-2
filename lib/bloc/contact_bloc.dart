import 'dart:async';

import 'package:rahulassignment2/model/contact.dart';
import 'package:rahulassignment2/repository/contact_repository.dart';

class ContactBloc {
  final _contactRepository = ContactRepository();
  final _contactController = StreamController<List<Contact>>.broadcast();

  get contacts => _contactController.stream;

  ContactBloc() {
    getContacts();
  }

  getContacts() async {
    _contactController.sink.add(await _contactRepository.getAllContacts());
  }

  Future<int> addContact(Contact contact) async {
    var result = await _contactRepository.insertContact(contact);
    return result;
  }

  getFavContacts() async {
    _contactController.sink.add(await _contactRepository.getFavContacts());
  }

  Future<int> deleteContact(int id) async {
    var result = await _contactRepository.deleteContact(id);
    return result;
  }

  Future<int> updateContact(Contact contact) async {
    var result = await _contactRepository.updateContact(contact);
    return result;
  }

  dispose() {
    _contactController.close();
  }
}
