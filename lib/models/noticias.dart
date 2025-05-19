
import 'dart:convert';

Noticias noticiasFromJson(String str) => Noticias.fromJson(json.decode(str));

String noticiasToJson(Noticias data) => json.encode(data.toJson());

class Noticias {
    String status;
    int totalResults;
    List<Article> articles;

    Noticias({
        required this.status,
        required this.totalResults,
        required this.articles,
    });

    factory Noticias.fromJson(Map<String, dynamic> json) => Noticias(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
    };
}

class Article {
  String title;
  String? description;
  String url;
  String? urlToImage;
  DateTime publishedAt;
  Source source;

  Article({
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.source,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        title: json["title"] ?? "Sin título",
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        source: Source.fromJson(json["source"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "source": source.toJson(),
      };
}

class Source {
  String? id;
  String name;

  Source({
    this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"] ?? "Fuente desconocida",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}