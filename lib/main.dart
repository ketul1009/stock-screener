import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_market_filter/AppPages/ChangePasswordForm.dart';
import 'package:stock_market_filter/AppPages/FilterPage.dart';
import 'package:stock_market_filter/AppPages/LoginPage.dart';
import 'package:stock_market_filter/AppPages/SignUpPage.dart';
import 'package:stock_market_filter/AppPages/HomePage.dart';
import 'package:stock_market_filter/AppPages/AccountPage.dart';
import 'package:stock_market_filter/AppPages/WatchlistPage.dart';

import 'AppPages/ResultsPage.dart';
import 'Models/Watchlist.dart';
Future<void> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var session = prefs.getBool("session");
  debugPrint(session.toString());
  final GoRouter router = GoRouter(
    initialLocation: session == true ? '/home' : '/',
    navigatorKey: GlobalKey<NavigatorState>(),
    routes: [
      GoRoute(
          name: 'login',
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          }
      ),
      GoRoute(
          name: 'signup',
          path: '/signup',
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpPage();
          }
      ),
      GoRoute(
          name: 'account',
          path: '/account',
          builder: (BuildContext context, GoRouterState state) {
            return const AccountPage(username: "Name", email: "Email", mobile: "Mobile");
          }
      ),
      GoRoute(
          name: 'home',
          path: '/home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          }
      ),
      GoRoute(
          name: 'screener',
          path: '/screener',
          builder: (BuildContext context, GoRouterState state) {
            return const FilterPage();
          }
      ),
      GoRoute(
          name: 'watchlist',
          path: '/watchlist',
          builder: (BuildContext context, GoRouterState state) {
            return const WatchlistPage();
          }
      ),
      GoRoute(
          name: 'results',
          path: '/results',
          builder: (BuildContext context, GoRouterState state) {
            return const ResultsPage();
          }
      ),
      GoRoute(
          name: 'changepwd',
          path: '/account/password',
          builder: (BuildContext context, GoRouterState state) {
            return const ChangePasswordPage();
          }
      ),
    ],
  );
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  runApp(
    ChangeNotifierProvider<WatchlistProvider>(
      create: (context) => WatchlistProvider(Watchlist([])),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        title: 'Stock Trading App',
        theme: ThemeData.dark(),
        darkTheme: ThemeData.dark(),
      ),
    ),
  );
}