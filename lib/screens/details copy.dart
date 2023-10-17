/*import 'package:appnoticias/models/models.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Recibir argumentos de otra pantalla
    final News noticia = ModalRoute.of(context)?.settings.arguments as News;
    return Scaffold(
      body: CustomScrollView(
        //Widget con comportamientos predefinidos al scroll
        slivers: [
          _CustomAppBar(
            noticia: noticia,
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                _PosterAndTitle(
                  noticia: noticia,
                ),
                _Overview(
                  noticia: noticia,
                ),
                // _ActorsSlider(movie: movie)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({required this.noticia});
  final News noticia;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      //wIDGET PARA QUE SE AGUSTE AL TAMAÑO
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        //Eliminar padding
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(
            noticia.title,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/images/generic/loading.gif'),
          fit: BoxFit.fitHeight,
          image: NetworkImage(noticia.image.toString()),
          //image: const AssetImage('assets/no-image.jpg'),
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({required this.noticia});
  final News noticia;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              //image: NetworkImage(movie.fullPosterImg),
              image: const AssetImage('assets/no-image.jpg'),
              height: 200,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  noticia.title.toString(),
                  style: const TextStyle(fontSize: 30),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  noticia.title,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_outline,
                      size: 20,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      noticia.category.toString(),
                      style: const TextStyle(fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({required this.noticia});
  final News noticia;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Text(
        noticia.description.toString(),
        textAlign: TextAlign.justify,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}

class _ActorsSlider extends StatelessWidget {
  const _ActorsSlider({required this.noticia});
  final News noticia;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * .3,
      color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Actores',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (_, int index) => _Actors(noticia),
          ))
        ],
      ),
    );
  }
}

class _Actors extends StatelessWidget {
  const _Actors(
    this.noticia,
  );
  final News noticia;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 210,
      color: Colors.red,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'details', arguments: ''),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: AssetImage('assets/no-image.jpg'),
              width: 130,
              height: 145,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Id ut ullamco non quis aliqua nulla duis.',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
*/