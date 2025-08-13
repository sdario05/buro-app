import 'dart:io';

import 'package:http/http.dart' as http;

class CvService {
  Future<void> sendCv(File file) async {
    /*print('*********************************');
    print(file.path);

    final url = Uri.parse('https://reqres.in/api/users/2');
    final request = http.MultipartRequest('POST', url);
    request.files.add(
      await http.MultipartFile.fromPath(
        'cv', // esto es el nombre del campo que espera el servidor
        file.path,
        filename: file.path.split('/').last, // esto es opcional, solo para enviar el nombre original
      ),
    );

    // Asi se pueden agregar campos adicionales si hicieran falta
    // request.fields['userId'] = '123';
    final response = await request.send();
    final respStr = await response.stream.bytesToString();

    print('Status save cv: ${response.statusCode}');
    print('Response save cv: $respStr');
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Hubo un error al guardar cv');
    }*/

    print('*********************************');
    print(file.path);
    final url = Uri.parse('https://reqres.in/api/users/2');

    final response = await http.get(
      url,
      headers: {
        'x-api-key': 'reqres-free-v1',
      },
    );

    print('Status save cv: ${response.statusCode}');
    print('Response save cv: ${response.body}');
    if (response.statusCode != 200) {
      throw Exception('Hubo un error al guardar cv');
    }
  }
}