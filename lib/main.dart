import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insta_json_analyzer/app/di/injector.dart';
import 'package:insta_json_analyzer/presentation/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: HomePage.route,
  routes: [
    GoRoute(
      path: HomePage.route,
      name: HomePage.route,
      builder: (context, state) => const HomePage(),
    )
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Insta json data analyzer",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
        fontFamily: 'roboto',
      ),
      routerConfig: _router,
    );
  }
}
