import 'dart:convert';

import 'package:buro_app/features/welcome/domain/model/carousel_model.dart';
import 'package:http/http.dart' as http;

class CarouselService {
  Future<List<CarouselModel>> getCarousel() async {
    final url = Uri.parse('https://reqres.in/api/users/2');
    final response = await http.get(
      url,
      headers: {
        'x-api-key': 'reqres-free-v1',
      },
    );
    print('Status code welcome carousel: ${response.statusCode}');
    print('Response body welcome carousel: ${response.body}');
    if (response.statusCode == 200) {
      String jsonString = '''
        [
          {"imageUrl":"https://media.istockphoto.com/id/2151496953/photo/unrecognizable-person-reviewing-hotels-online-using-smartphone.jpg?s=1024x1024&w=is&k=20&c=AxoztPTfnqq2KLiYuUvyQQg5c3ieljMxEVPMvWmAv8s=","title":"Visitante (Investigador silencioso)","description":"Podes hechar un vistazo a las distintas propuestas de generadores como exploradores de empleo","mode":"visitante"},
          {"imageUrl":"https://media.istockphoto.com/id/2155090853/photo/datalake-big-data-warehouse-data-lake-platform-analytics-technology.jpg?s=1024x1024&w=is&k=20&c=BCAUrsx1ugA-TvApZ1z5mnU1j1uaVRLPY0ZwqhQ66ZE=","title":"Generador de empleos","description":"Destinado a explorar a futuros empleados. Podes buscar y guardar candidatos y crear convocatorias de empleo!!","mode":"generador"},
          {"imageUrl":"https://media.istockphoto.com/id/2151295139/photo/professional-online-gamer-hand-fingers.jpg?s=1024x1024&w=is&k=20&c=AHQIezrFWpK4JYcl70W7yo8_BuIvinUFNRkIOSTda6E=","title":"Explorador de empleos","description":"Destinado a explorar futuros empleos. Podés buscar y guardar empleos, crear convocatorias y ¡generar tu/s CV/s","mode":"explorador"}
        ]
        ''';
      final a = json.decode(jsonString) as List;
      List<CarouselModel> carouselList = (a)
          .map((data) => CarouselModel.fromJson(data))
          .toList();
      return carouselList;
    } else {
      throw Exception('Hubo un error al hacer obtener la info del carousel');
    }
  }
}