import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stock_market_filter/Models/Watchlist.dart';
import 'package:http/http.dart' as http;
import '../Common/CustomDrawer.dart';

List<List<dynamic>> filtered = [];

class FilterPage extends StatefulWidget{
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => FilterPageState();
}

class FilterPageState extends State<FilterPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool drawerOpen = false;
  List<String> universe = [
    "Select stock universe",
    "Nifty 50"
  ];
  List<String> strategy = [
    "Select strategy",
    "EMA Crossover",
    "RSI - Oversold",
    "RSI - Overbought",
  ];
  String selectedUniverse = "Select stock universe";
  String selectedStrategy = "Select strategy";
  List<dynamic> stocks = [];

  void _search() async {
    final url = Uri.parse("https://0uzp72ur4a.execute-api.ap-south-1.amazonaws.com/dev/stockscreener/stocks");
    var res = await http.get(
      url,
    );
    var data = json.decode(res.body);
    var temp = data["payload"][0]["data"];
    setState(() {
      stocks=temp;
    });
    _emaCrossover(stocks);
    context.go("/results");
  }
  void _emaCrossover(List<dynamic> stocks){
    filtered = [];
    Watchlist temp = Watchlist([]);
    for(var stock in stocks){
      for(var key in stock.keys){
        if(stock[key]["EMA20"]>stock[key]["EMA50"]){
          filtered.add([key, stock[key]["close"], stock[key]["change"], "EMA Crossover"]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    WatchlistProvider watchlistProvider = context.watch<WatchlistProvider>();
    Watchlist watchlist = watchlistProvider.watchlist;
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
                padding: const EdgeInsets.all(5),
                child: TextButton(
                  onPressed: (){
                    context.go("/home");
                  },
                  child: const Text("Home"),
                )
            ),
          ],
        ),
        body: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              DropdownButton(
                // Initial Value
                value: selectedUniverse,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                // Array list of items
                items: universe.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (newValue) {
                  setState(() {
                    selectedUniverse = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              DropdownButton(
                // Initial Value
                value: selectedStrategy,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                // Array list of items
                items: strategy.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (newValue) {
                  setState(() {
                    selectedStrategy = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _search();
                  //context.go("/results");
                },
                child: const Text('Search'),
              ),
            ],
          ),
        )
    );
  }
}
