import 'package:buro_app/features/modes/explorer/contact/domain/model/contact_model.dart';

abstract class ContactRepository {
  Future<void> sendContacts(ContactModel contacts);
}