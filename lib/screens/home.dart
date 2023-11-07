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
