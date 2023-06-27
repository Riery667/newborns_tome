import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newborns_tome/screens/home_page.dart';
import 'package:newborns_tome/screens/library_page.dart';
import 'package:newborns_tome/screens/login_page.dart';
import 'package:newborns_tome/screens/wish_list_page.dart';
import 'package:newborns_tome/utils/firebase_auth_service.dart';
import 'package:newborns_tome/utils/newborns_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDRsdWoIsfmjWm6xi0mh5ZIQqVwcVJtCsU",
        authDomain: "newsborns-tome.firebaseapp.com",
        projectId: "newsborns-tome",
        storageBucket: "newsborns-tome.appspot.com",
        messagingSenderId: "968990508677",
        appId: "1:968990508677:web:3c017d8f209b0288fc0bec"),
  );

  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        ),
        GoRoute(
          path: 'library',
          builder: (BuildContext context, GoRouterState state) {
            return const LibraryPage();
          },
        ),
        GoRoute(
          path: 'wish',
          builder: (BuildContext context, GoRouterState state) {
            return const WishListPage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = NewbornsTome.dark();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      showSemanticsDebugger: false,
      theme: theme,
      routerConfig: _router,
    );
  }
}
