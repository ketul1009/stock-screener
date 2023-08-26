import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stock_market_filter/AppPages/FilterPage.dart';
import 'package:stock_market_filter/AppPages/LoginPage.dart';

import 'AppPages/AccountPage.dart';
import 'AppPages/Home.dart';

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
          name: 'account',
          path: '/account',
          builder: (BuildContext context, GoRouterState state) {
            return const AccountPage();
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
          name: 'filter',
          path: '/filter',
          builder: (BuildContext context, GoRouterState state) {
            return const FilterPage();
          }
      ),
      /*GoRoute(
          name: 'results',
          path: '/results',
          builder: (BuildContext context, GoRouterState state) {
            return ResultPage();
          }
      ),*/
    ],
  );

  runApp(
    MaterialApp.router(
      routerConfig: router,
      title: 'Stock Trading App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    )
  );
}

