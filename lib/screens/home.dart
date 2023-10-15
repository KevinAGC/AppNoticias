import 'package:appnoticias/widgets/news_list.dart';
import 'package:flutter/material.dart';
import 'package:appnoticias/providers/news_provider.dart';
import 'package:appnoticias/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        title: const Center(
          child: Text('Noticias'),
        ),
      ),
      body: Column(
        children: [
          /*CardSwiper(
            noticias: newsProvider.newsTechnology,
          ),*/
          const NewsFilter(),
          Expanded(child: NewsList(news: newsProvider.newsList)),
        ],
      ),
    );
  }
}

class NewsFilter extends StatefulWidget {
  const NewsFilter({super.key});

  @override
  State<NewsFilter> createState() => _NewsFilterState();
}

class _NewsFilterState extends State<NewsFilter> {
  final Map categoryList = {
    "Generales": "general",
    "Negocios": "business",
    "Entretenimiento": "entertainment",
    "Salud": "health",
    "Ciencia": "science",
    "Deportes": "sports",
    "Tecnología": "technology",
  };
  final Map languageList = {
    "Español": "es",
    "Inglés": "en",
  };
  String valorDropCategory = "general";
  String valorDropLanguage = "en";

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          //Categoria
          DropdownButton<String>(
            items: categoryList
                .map((description, value) {
                  return MapEntry(
                      description,
                      DropdownMenuItem<String>(
                        value: value,
                        child: Text(description),
                      ));
                })
                .values
                .toList(),
            value: valorDropCategory,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  valorDropCategory = newValue;
                });
              }
              newsProvider.setCategory(valorDropCategory);
              newsProvider.getNews();
            },
          ),
          //Lenguaje
          DropdownButton<String>(
            items: languageList
                .map((description, value) {
                  return MapEntry(
                      description,
                      DropdownMenuItem<String>(
                        value: value,
                        child: Text(description),
                      ));
                })
                .values
                .toList(),
            value: valorDropLanguage,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  valorDropLanguage = newValue;
                });
              }
              newsProvider.setLanguage(valorDropLanguage);
              newsProvider.getNews();
            },
          ),
        ],
      ),
    );
  }
}
