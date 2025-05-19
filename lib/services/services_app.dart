
import 'package:http/http.dart' as http;
import '../models/noticias.dart';

class NoticiaServices {
  static const String _baseUrl = 'https://newsapi.org/v2/everything?q=bitcoin&apiKey=6aa3fddbb3584389bab5f14a6d07c204';

  Future<Noticias> fetchNoticias() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return noticiasFromJson(response.body);
    } else {
      throw Exception('Failed to load news: ${response.statusCode}');
    }
  }
}
