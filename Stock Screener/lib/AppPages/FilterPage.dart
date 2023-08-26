import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget{
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => FilterPageState();
}

class FilterPageState extends State<FilterPage>{

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
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // TODO: Handle search button press
              },
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
