import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/services.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({Key? key}) : super(key: key);

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      initialData: [],
      future: AuthService().sendGetRequest(),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        return SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final favorito = snapshot.data![index];
              return ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertFavorito(fav: favorito);
                    },
                  );
                },
                shape: const ContinuousRectangleBorder(
                  side: BorderSide(width: 1),
                  borderRadius: BorderRadius.horizontal(),
                ),
                title: Text(favorito["title"].toString()),
                subtitle: Text(
                  favorito["link"].toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class AlertFavorito extends StatelessWidget {
  final Map<String, dynamic> fav;

  const AlertFavorito({Key? key, required this.fav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(fav["title"].toString()),
      actions: [
        TextButton(
          onPressed: () async {
            Uri url = Uri.parse(fav["link"].toString());
            var urlLaunchable = await canLaunchUrl(url);
            if (urlLaunchable) {
              await canLaunchUrl(url);
            } else {
              // Handle the case where the URL can't be launched.
            }
          },
          child: Text(
            'Leer',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        TextButton(
          onPressed: () async {
            print(fav["id"].toString());

            FutureBuilder<String>(
              future: AuthService().sendDeleteRequest(fav["id"].toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                  } else {
                    print('Deletion successful: ${snapshot.data}');
                    Navigator.pop(context);
                  }
                }

                return Container();
              },
            );
          },
          child: Text(
            'Eliminar',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
