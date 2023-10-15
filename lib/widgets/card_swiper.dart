import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:appnoticias/models/models.dart';
import 'dart:math';

class CardSwiper extends StatelessWidget {
  final List<News> noticias;
  const CardSwiper({super.key, required this.noticias});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: noticias.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height,
        itemBuilder: (_, int index) {
          final news = noticias[index];
          //print(news.image);
          //print(news.fullPosterImg);
          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: news),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  fit: BoxFit.fitWidth,
                  placeholder: AssetImage('assets/images/generic/loading.gif'),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/generic/1.png',
                    );
                  },
                  //image: NetworkImage(news.image.toString()),
                  //AssetImage('assets/images/generic-news.png')
                  image: news.hasPicture
                      ? NetworkImage(news.image.toString()) as ImageProvider
                      : AssetImage('assets/images/generic-news.png')

                  //image: const AssetImage('assets/no-image.jpg'),
                  ),
            ),
          );
        },
      ),
    );
  }
}
