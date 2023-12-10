import 'package:appnoticias/widgets/favorites_list.dart';
import 'package:flutter/material.dart';
import 'package:appnoticias/providers/news_provider.dart';
import 'package:appnoticias/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:appnoticias/services/services.dart';
import '../providers/login_form_provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        title: const Text('Noticias'),
      ),
      body: Column(
        children: [
          /*CardSwiper(
            noticias: newsProvider.newsTechnology,
          ),*/
          const FavoritesList()
        ],
      ),
    );
  }
}
