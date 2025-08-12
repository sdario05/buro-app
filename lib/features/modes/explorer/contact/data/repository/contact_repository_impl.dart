import 'package:buro_app/features/modes/explorer/contact/data/service/contact_service.dart';
import 'package:buro_app/features/modes/explorer/contact/domain/model/contact_model.dart';
import 'package:buro_app/features/modes/explorer/contact/domain/repository/contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactService service;

  ContactRepositoryImpl(this.service);

  @override
  Future<void> sendContacts(ContactModel contacts) async {
    return await service.sendContacts(contacts);
  }
}