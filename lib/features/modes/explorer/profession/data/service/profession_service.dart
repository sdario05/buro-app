import 'dart:convert';

import 'package:buro_app/features/modes/explorer/profession/presentation/screens/explorer_profession_screen_content.dart';
import 'package:http/http.dart' as http;

class ProfessionService {
  Future<void> sendProfession(List<ProfessionEntry> professions) async {

    final url = Uri.parse('https://reqres.in/api/users/2');
    //Aqui tenemos 2 ejemplos de body, uno que envia un body como un objeto de nombre professions que tiene un array de profesiones,
    //y el otro es simplemente un array de profesiones
    /*final body = jsonEncode({
      'professions': professions.map(
        (p) => p.toJson()
      ).toList(),
    });

    final body = jsonEncode(
      professions.map((p) => p.toJson()).toList(),
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

    print('Status save profession: ${response.statusCode}');
    print('Response save profession: ${response.body}');
    if (response.statusCode != 200) {
      throw Exception('Hubo un error al guardar profesión');
    }
  }
}