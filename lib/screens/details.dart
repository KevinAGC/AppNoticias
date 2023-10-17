import 'package:appnoticias/models/models.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final News noticia = ModalRoute.of(context)?.settings.arguments as News;
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.orange, title: Text(noticia.source)),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate.fixed(
                [TitleAuthorImage(noticia: noticia)]),
          ),
        ],
      ),
    );
  }
}

class TitleAuthorImage extends StatelessWidget {
  const TitleAuthorImage({super.key, required this.noticia});
  final News noticia;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          alignment: Alignment.topLeft,
          child: Text(
            noticia.title,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          alignment: Alignment.topLeft,
          child: Text(
            noticia.hasAuthor ? noticia.author.toString() : noticia.source,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: FadeInImage(
              //height: 150,
              fit: BoxFit.fitHeight,
              placeholder: AssetImage('assets/images/generic/loading.gif'),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/generic/1.png',
                  height: 150,
                );
              },
              //image: NetworkImage(news.image.toString()),
              //AssetImage('assets/images/generic-news.png')
              image: noticia.hasPicture
                  ? NetworkImage(noticia.image.toString()) as ImageProvider
                  : AssetImage('assets/images/generic-news.png')

              //image: const AssetImage('assets/no-image.jpg'),
              ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          alignment: Alignment.topLeft,
          child: Text(
            noticia.description,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
/*
Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        noticia.title,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    );
 */