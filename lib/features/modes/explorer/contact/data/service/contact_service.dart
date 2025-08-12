import 'dart:convert';
import 'package:buro_app/features/modes/explorer/contact/domain/model/contact_model.dart';
import 'package:buro_app/features/modes/explorer/profession/presentation/screen/explorer_profession_screen_content.dart';
import 'package:http/http.dart' as http;

class ContactService {
  Future<void> sendContacts(ContactModel contacts) async {
    print('*********************************');
    print(contacts.email);
    print(contacts.phone);
    contacts.additional?.forEach((item) {
      print(item);
    });
    final url = Uri.parse('https://reqres.in/api/users/2');


    /*final body = jsonEncode(
      contacts.toJson(),
    );

    final response = await http.put(
      url,
      headers: {
        'x-api-key': 'reqres-free-v1',
      },
      body: body
    );*/

    final response = await http.get(
        url,
        headers: {
          'x-api-key': 'reqres-free-v1',
        },
    );

    print('Status save contacts: ${response.statusCode}');
    print('Response save contacts: ${response.body}');
    if (response.statusCode != 200) {
      throw Exception('Hubo un error al guardar los contactos');
    }
  }
}