import 'dart:convert';

import 'package:buro_app/features/welcome/domain/model/carousel_model.dart';
import 'package:buro_app/shared/action/getgifanimation/presentation/cubit/gif_animation_cubit.dart';
import 'package:http/http.dart' as http;

class GifAnimationService {
  Future<String> getAnimation(GifType type) async {
    final url = Uri.parse('https://reqres.in/api/users/2');
    final response = await http.get(
      url,
      headers: {
        'x-api-key': 'reqres-free-v1',
      },
    );
    print('Status code welcome explorer gif: ${response.statusCode}');
    print('Response body welcome explorer gif: ${response.body}');
    if (response.statusCode == 200) {
      switch(type) {
        case GifType.explorerExplanation:
          return 'https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExc3lwam1oZDN5Y281ZGpvZGtieDQxajh3OXQxMDZ5bnozYnVzcjR6byZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l4KibOaou932EC7Dy/giphy.gif';
        case GifType.explorerWelcome:
        return 'https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExODN1YWxxOGt4YmVod3JieHJuM3NwbnRpdWV0bmVwY3FuZ2Q3dnhhNCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/bqkFZzzE9E5WfnkZTO/giphy.gif';
      }
    } else {
      throw Exception('Hubo un error al hacer obtener la info del carousel');
    }
  }
}