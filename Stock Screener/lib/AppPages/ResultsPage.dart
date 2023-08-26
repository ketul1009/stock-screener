import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_filter/Constants/StockData.dart';

class ResultsPage extends StatefulWidget{
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => ResultsPageState();
}

class ResultsPageState extends State<ResultsPage>{
  List<String> s = stocks.keys.toList();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: [
          Image.asset('images/logo.png',
            height: 100,),
        ],
        elevation: 2,
        //backgroundColor: Colors.black45,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                children: [
                  const SizedBox(width: 100,),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text("Found ${s.length} results", style: const TextStyle(fontSize: 20),),
                  )
                ]
            ),
            SizedBox(
                  height: 600,
                  //width: 300,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(3),
                    itemCount: stocks.length,
                    itemBuilder: (BuildContext context, int index) {
                      String stock = s[index];
                      int price = stocks[stock]![0];
                      return SizedBox(
                        height: 30,
                        child: Row(
                          children: [
                            const SizedBox(width: 30,),
                            Text(stock),
                            const SizedBox(width: 15,),
                            Text("LTP"),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                  )
            )
          ],
        ),
      )
    );
  }
}