import 'package:appnoticias/services/services.dart';
import 'package:flutter/material.dart';
import 'package:appnoticias/screens/screens.dart';
import 'package:provider/provider.dart';
import 'providers/news_provider.dart';
import 'providers/login_form_provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => LoginFormProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
          lazy: false,
        )
      ],
      child: const AppState(),
    ));

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noticias',
      initialRoute: 'login',
      routes: {
        'login': (_) => LoginScreen(),
        'register': (_) => RegisterScreen(),
        'home': (_) => NewsPage(),
        'details': (_) => const DetailsScreen(),
        'checking': (_) => CheckAuthScreen(),
        'favorites': (_) => FavoritePage()
      },
    );
  }
}
