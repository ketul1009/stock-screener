import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:stock_market_filter/Models/Watchlist.dart';
// import 'package:provider/provider.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth > 600 ? 300.0 : 150.0;
    final buttonTextSize = screenWidth > 600 ? 30.0 : 15.0;
    final multiplier = screenWidth > 600 ? 1 : 0.33;
    // WatchlistProvider watchlistProvider = context.watch<WatchlistProvider>();
    // Watchlist watchlist = watchlistProvider.watchlist;
    debugPrint(screenWidth.toString());
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
        body: SingleChildScrollView(
          child: Center(
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
                      width: buttonWidth,
                      height: buttonWidth,
                      padding: EdgeInsets.all((10*multiplier) as double),
                      child: Padding(
                        padding: EdgeInsets.all(30*multiplier as double),
                        child: ElevatedButton(
                          onPressed: () {
                            context.go("/screener");
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Screen", style: TextStyle(fontSize: buttonTextSize),),
                              SizedBox(height: 20*multiplier as double,),
                              Text("Screen stocks", style: TextStyle(fontSize: buttonTextSize/1.5),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0*multiplier),
                    Container (
                      width: buttonWidth,
                      height: buttonWidth,
                      padding: EdgeInsets.all(10*multiplier as double),
                      child: Padding(
                        padding: EdgeInsets.all(30*multiplier as double),
                        child: ElevatedButton(
                          onPressed: () {
                            context.go("/watchlist");
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Watchlist", style: TextStyle(fontSize: buttonTextSize),),
                              SizedBox(height: 20*multiplier as double),
                              Text("Stocks in watchlist", style: TextStyle(fontSize: buttonTextSize/1.5),),
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
        )
      );
  }
}
