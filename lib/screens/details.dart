import 'package:appnoticias/models/models.dart';
import 'package:appnoticias/services/services.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:url_launcher/url_launcher.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(noticia.source),
        leading: IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () async {
            var result =
                await AuthService().sendPostRequest(noticia.title, noticia.url);
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: const Text('Favoritas'),
                      content: Text((result.toString())),
                    ));
          },
        ),
      ),
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
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: FadeInImage(
              fit: BoxFit.fitHeight,
              placeholder:
                  const AssetImage('assets/images/generic/loading.gif'),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/generic/1.png',
                );
              },
              //image: NetworkImage(news.image.toString()),
              //AssetImage('assets/images/generic-news.png')
              image: noticia.hasPicture
                  ? NetworkImage(noticia.image.toString()) as ImageProvider
                  : const AssetImage('assets/images/generic/1.png')

              //image: const AssetImage('assets/no-image.jpg'),
              ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          alignment: Alignment.topLeft,
          child: Text(
            HtmlUnescape().convert(noticia.description),
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          alignment: Alignment.topLeft,
          child: ElevatedButton(
            child: const Text("Leer Noticia Completa"),
            onPressed: () async {
              Uri url = Uri.parse(noticia.url);
              var urllaunchable = await canLaunchUrl(
                  url); //canLaunch is from url_launcher package
              if (urllaunchable) {
                await launchUrl(
                    url); //launch is from url_launcher package to launch URL
              } else {
                //print("URL can't be launched.");
              }
            },
          ),
        )
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
