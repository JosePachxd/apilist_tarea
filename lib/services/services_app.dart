
import 'package:http/http.dart' as http;
import '../models/noticias.dart';

class NoticiaServices {
  static const String _baseUrl = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=300e83b8ce1b47689e7d5a4da33f0038';

  Future<Noticias> fetchNoticias() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return noticiasFromJson(response.body);
    } else {
      throw Exception('Failed to load news: ${response.statusCode}');
    }
  }
}