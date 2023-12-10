import 'package:flutter/material.dart';
import 'package:appnoticias/providers/news_provider.dart';
import 'package:appnoticias/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:appnoticias/services/services.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        title: const Text('Noticias'),
        actions: [
          IconButton(
            icon: const Icon(Icons.login_outlined),
            onPressed: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_rounded),
            onPressed: () {
              Navigator.pushNamed(
                context,
                'favorites',
              );
            },
          ),
        ],
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
