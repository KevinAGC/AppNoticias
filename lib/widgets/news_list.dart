import 'package:appnoticias/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:appnoticias/models/models.dart';

class NewsList extends StatelessWidget {
  final List<News> news;
  const NewsList({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        final noticia = news[index];
        return ListTile(
          onTap: () => Navigator.pushNamed(
            context,
            'details',
            arguments: (noticia),
          ),
          shape: const ContinuousRectangleBorder(
            //<-- SEE HERE
            side: BorderSide(width: 1),
            borderRadius: BorderRadius.horizontal(),
          ),
          title: Text(noticia.source),
          subtitle: Text(noticia.title),
          subtitleTextStyle: TextStyle(fontWeight: FontWeight.bold),
        );
      },
    );
  }
}
