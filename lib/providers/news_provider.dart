import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:appnoticias/models/models.dart';

class NewsProvider extends ChangeNotifier {
  final String _baseUrl = 'api.mediastack.com';
  final String _accessKey = '1969851b2f4120200babf94ee04c1054';
  String _language = "";
  String _category = "";
  List<News> newsList = [];
  //List<News> popularNews = [];

  NewsProvider() {
    getNews();
  }
  void setLanguage(String lang) {
    _language = lang;
    notifyListeners();
  }

  void setCategory(String cat) {
    _category = cat;
    notifyListeners();
  }

  getNews() async {
    var url = Uri.http(_baseUrl, '/v1/news', {
      'access_key': _accessKey,
      'languages': _language,
      'date': "2023-10-01,2023-10-31",
      'categories': _category
    });

    final response = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(response.body);
    //print(decodeData);
    //print(response.body);
    final techResponse = Response.fromRawJson(response.body);
    newsList = techResponse.results;
    //Le comunicamos a todos los widgets que estan escuchando que se cambio la data por lo tanto se tienen que redibujar
    notifyListeners();
    //print(techResponse.results[0].title);
  }

  /*getPopularNews() async {
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _accessKey, 'language': _language, 'page': '1'});

    final response = await http.get(url);

    final popularResponse = PopularResponse.fromRawJson(response.body);

    //Destructurar resultado para cambiar pagina y mantener los actuales
    popularNews = [...popularNews, ...popularResponse.results];
    notifyListeners();
  }*/
}
