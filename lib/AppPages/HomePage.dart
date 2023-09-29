import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_market_filter/Models/Watchlist.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage>{


  void _logOut() async {
    SharedPreferences pref =await SharedPreferences.getInstance();
    pref.setBool("session", false);
  }

  @override
  Widget build(BuildContext context){
    WatchlistProvider watchlistProvider = context.watch<WatchlistProvider>();
    Watchlist watchlist = watchlistProvider.watchlist;
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
                padding: const EdgeInsets.all(5),
                child: TextButton(
                  onPressed: (){
                    _logOut();
                    context.go("/");
                  },
                  child: const Text("Log out"),
                )
            ),
            Padding(
                padding: const EdgeInsets.all(5),
                child: TextButton(
                  onPressed: (){
                    context.go("/account");
                  },
                  child: const Text("Account"),
                )
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Image.asset('assets/images/logo.png',
                  height: 140,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    padding: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: ElevatedButton(
                        onPressed: () {
                          context.go("/screener");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Screen", style: TextStyle(fontSize: 30),),
                            SizedBox(height: 20,),
                            Text("Screen stocks", style: TextStyle(fontSize: 15),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Container(
                    width: 300,
                    height: 300,
                    padding: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: ElevatedButton(
                        onPressed: () {
                          context.go("/watchlist");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Watchlist", style: TextStyle(fontSize: 30),),
                            SizedBox(height: 20,),
                            Text("Stocks in your watchlist", style: TextStyle(fontSize: 15),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
  }
}
