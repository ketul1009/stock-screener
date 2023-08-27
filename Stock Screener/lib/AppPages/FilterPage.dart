import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stock_market_filter/Models/Watchlist.dart';

import '../Common/CustomDrawer.dart';

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
    "Nifty 50",
    "Nifty 100",
    "Nifty 500",
    "Nifty Next 50"
  ];
  List<String> strategy = [
    "Select strategy",
    "EMA Crossover",
    "RSI",
  ];
  String selectedUniverse = "Select stock universe";
  String selectedStrategy = "Select strategy";

  @override
  Widget build(BuildContext context) {
    WatchlistProvider watchlistProvider = context.watch<WatchlistProvider>();
    Watchlist watchlist = watchlistProvider.watchlist;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu, size: 50, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          elevation: 2,
          backgroundColor: Colors.white,
        ),
        drawer: const CustomDrawer(),
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
                  context.go("/results");
                },
                child: const Text('Search'),
              ),
            ],
          ),
        )
    );
  }
}
