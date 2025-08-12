import 'package:buro_app/features/modes/explorer/contact/domain/model/contact_model.dart';
import 'package:buro_app/features/modes/explorer/contact/domain/repository/contact_repository.dart';

class SendContactUseCase {
  final ContactRepository repository;

  SendContactUseCase(this.repository);

  Future<void> call(ContactModel contacts) async {
    return await repository.sendContacts(contacts);
  }
}