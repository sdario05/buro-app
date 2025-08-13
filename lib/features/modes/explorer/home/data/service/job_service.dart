import 'dart:convert';

import 'package:buro_app/features/modes/explorer/home/domain/model/job_listing.dart';
import 'package:http/http.dart' as http;

class JobService {
  Future<List<JobListing>> getJobs() async {
    final url = Uri.parse('https://reqres.in/api/users/2');

    final response = await http.get(
        url,
        headers: {
          'x-api-key': 'reqres-free-v1',
        },
    );

    print('Status get jobs: ${response.statusCode}');
    print('Response get jobs: ${response.body}');
    if (response.statusCode == 200) {
      String jsonString = '''
          [{"id":"1","name":"La Cantera BarberShop","title":"Barbero & Estilista","type":"generator","description":"Buscamos un Barbero Estilista con experiencia en cortes modernos y clásicos.","location":"Buenos Aires","salary":"\$150,000 - \$200,000"},
          {"id":"2","name":"Mi sabor","title":"Cocinero","type":"generator","description":"Se busca un cocinero para nuestra tienda de empanadas en Villa Crespo.","location":"CABA","salary":"\$600,000 - \$700,000"},
          {"id":"3","name":"Café del Centro","title":"Barista","type":"generator","description":"Buscamos barista con experiencia para café de especialidad.","location":"Córdoba","salary":"\$180,000 - \$220,000"}]
        '''
          ;
      final List<dynamic> data = json.decode(jsonString);

      return data.map((e) => JobListing.fromJson(e)).toList();
    } else {
      throw Exception('Hubo un error al obtener trabajos');
    }
  }
}