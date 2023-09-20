import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stock_market_filter/AppPages/FilterPage.dart';
import 'package:stock_market_filter/AppPages/LoginPage.dart';
import 'package:stock_market_filter/AppPages/SignUpPage.dart';
import 'package:stock_market_filter/AppPages/HomePage.dart';
import 'package:stock_market_filter/AppPages/AccountPage.dart';
import 'package:stock_market_filter/AppPages/WatchlistPage.dart';

import 'AppPages/ResultsPage.dart';
import 'Models/Watchlist.dart';
void main() {

  final GoRouter router = GoRouter(
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
    ],
  );

  runApp(
      ChangeNotifierProvider<WatchlistProvider>(
          create: (context) => WatchlistProvider(Watchlist([])),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            title: 'Stock Trading App',
            theme: ThemeData.dark(),
            darkTheme: ThemeData.dark(),
          )
      )
  );
}