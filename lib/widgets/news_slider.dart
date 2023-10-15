import 'package:flutter/material.dart';
import 'package:appnoticias/models/models.dart';

class NewsSlider extends StatelessWidget {
  final List<News> news;
  final String? title;
  const NewsSlider({super.key, required this.news, this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.30,
      color: Colors.orange.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'C Slider',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: news.length,
              itemBuilder: (_, int index) => _NewsPoster(news: news[index]),
            ),
          )
        ],
      ),
    );
  }
}

class _NewsPoster extends StatelessWidget {
  final News news;
  const _NewsPoster({required this.news});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.4,
      height: size.height,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: ''),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder:
                    const AssetImage('assets/images/generic/loading.gif'),
                image: news.hasPicture
                    ? NetworkImage(news.image.toString()) as ImageProvider
                    : AssetImage('assets/images/generic-news.png'),
                width: size.width,
                height: 165,
              ),
            ),
          ),
          const SizedBox(height: 1),
          Text(
            news.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
