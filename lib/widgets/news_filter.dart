import 'package:flutter/material.dart';
import 'package:appnoticias/providers/news_provider.dart';
import 'package:provider/provider.dart';

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
