import 'package:buro_app/shared/action/getImage/presentation/cubit/image_cubit.dart';
import 'package:http/http.dart' as http;

class ImageService {
  Future<String> getImage(ImageType imageType) async {
    print('*********************************');
    print(imageType.name);
    final url = Uri.parse('https://reqres.in/api/users/2');
    final response = await http.get(
      url,
      headers: {
        'x-api-key': 'reqres-free-v1',
      },
    );
    print('Status code image: ${response.statusCode}');
    print('Response body image: ${response.body}');
    if (response.statusCode == 200) {
      switch(imageType) {
        case ImageType.explorerExplanation:
          return 'https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExc3lwam1oZDN5Y281ZGpvZGtieDQxajh3OXQxMDZ5bnozYnVzcjR6byZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l4KibOaou932EC7Dy/giphy.gif';
        case ImageType.explorerWelcome:
          return 'https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExODN1YWxxOGt4YmVod3JieHJuM3NwbnRpdWV0bmVwY3FuZ2Q3dnhhNCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/bqkFZzzE9E5WfnkZTO/giphy.gif';
        case ImageType.explorerCvSuccess:
          return 'https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExM2IyYWpsZjMzeXJkYWZxc3RuaXFvbmxtNGV6cnk1aGZ1emEzeXhhdSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3oz9ZE2Oo9zRC/giphy.gif';
        case ImageType.explorerProfessionSuccess:
          return 'https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExZzg5eHR4NnNocGFidmw0bG91bzgwMWg2aTNqcWltYm4xZmJhZGJ2YyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Oj5w7lOaR5ieNpuBhn/giphy.gif';
        case ImageType.explorerCompleted:
          return 'https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExcXlseGZpMXlmMDVtenhqNnc0cGx6dW01ZTZ0ZWM1MGdoeHc4d2xqOSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l4EpblDY4msVtKAOk/giphy.gif';
        case ImageType.explorerReminder:
          return 'https://plus.unsplash.com/premium_photo-1673606176850-07628ce98892?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
      }
    } else {
      throw Exception('Hubo un error al hacer obtener imagen');
    }
  }
}