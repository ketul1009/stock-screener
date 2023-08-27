import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stock_market_filter/Common/Toast.dart';
import 'package:stock_market_filter/Constants/StockData.dart';

import '../Models/Watchlist.dart';

class ResultsPage extends StatefulWidget{
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => ResultsPageState();
}

class ResultsPageState extends State<ResultsPage>{

  String watchlistButton = "Add to Watchlist";

  @override
  Widget build(BuildContext context){
    WatchlistProvider watchlistProvider = context.watch<WatchlistProvider>();
    Watchlist watchlist = watchlistProvider.watchlist;
    int serialNo = 1;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Image.asset('images/logo.png',
              height: 100,),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: TextButton(
              onPressed: (){
                context.go("/watchlist");
              },
              child: const Text("Watchlist"),
            )
          ),
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
                    child: Text("Found ${stocks.length} results", style: const TextStyle(fontSize: 20),),
                  )
                ]
            ),
            Row(
                children: [
                  const SizedBox(width: 80,),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: DataTable(
                        showCheckboxColumn: false,
                        columns: const [
                          DataColumn(label: Text("Sr. No", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                          DataColumn(label: Text("Stock", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                          DataColumn(label: Text("LTP", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                          DataColumn(label: Text("", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                        ],
                        rows: stocks.map(
                                (stock) => DataRow(
                                cells: [
                                  DataCell(
                                    Text((serialNo++).toString()),
                                    showEditIcon: false,
                                    placeholder: false,
                                  ),
                                  DataCell(
                                    Text((stock[0]).toString()),
                                    showEditIcon: false,
                                    placeholder: false,
                                  ),
                                  DataCell(
                                    Text((stock[1]).toString()),
                                    showEditIcon: false,
                                    placeholder: false,
                                  ),
                                  DataCell(
                                    TextButton(
                                      onPressed: (){
                                        if(watchlist.watchlist.contains(stock)){
                                          ToastService.showToast(context, "Already in watchlist");
                                        }
                                        else{
                                          watchlist.watchlist.add(stock);
                                        }
                                      },
                                      child: Text(watchlistButton),
                                    ),
                                    showEditIcon: false,
                                    placeholder: false,
                                  ),
                                ]
                            )
                        ).toList()
                    )
                  )
                ]
            ),
          ],
        ),
      )
    );
  }
}