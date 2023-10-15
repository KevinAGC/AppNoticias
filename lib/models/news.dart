import 'dart:convert';

class News {
  String? author;
  String title;
  String description;
  String url;
  String source;
  String? image;
  String category;
  String language;
  String country;
  DateTime publishedAt;

  News({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.source,
    required this.image,
    required this.category,
    required this.language,
    required this.country,
    required this.publishedAt,
  });

  factory News.fromRawJson(String str) => News.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  bool get hasPicture {
    if (image != null) {
      return true;
    }
    return false;
  }

  factory News.fromJson(Map<String, dynamic> json) => News(
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        source: json["source"],
        image: json["image"],
        category: json["category"]!,
        language: json["language"]!,
        country: json["country"]!,
        publishedAt: DateTime.parse(json["published_at"]),
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "source": source,
        "image": image,
        "category": category,
        "language": language,
        "country": country,
        "published_at": publishedAt.toIso8601String(),
      };
}
