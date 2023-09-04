import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stock_market_filter/Models/Watchlist.dart';

class WatchlistPage extends StatefulWidget{
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => WatchlistPageState();
}

class WatchlistPageState extends State<WatchlistPage>{


  //int serialNo=1;
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
                    context.go("/home");
                  },
                  child: const Text("Home"),
                )
            ),
            Padding(
                padding: const EdgeInsets.all(5),
                child: TextButton(
                  onPressed: (){
                    context.go("/screener");
                  },
                  child: const Text("Screener"),
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
                      child: Text("${watchlist.watchlist.length} in watchlist", style: const TextStyle(fontSize: 20),),
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
                              DataColumn(label: Text("Change", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                              DataColumn(label: Text("Strategy", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                              DataColumn(label: Text("", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                            ],
                            rows: watchlist.watchlist.map(
                                    (stock) {
                                  return DataRow(
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
                                          Text((stock[1]).toStringAsFixed(2).toString()),
                                          showEditIcon: false,
                                          placeholder: false,
                                        ),
                                        DataCell(
                                          Text((stock[2]).toStringAsFixed(2).toString()),
                                          showEditIcon: false,
                                          placeholder: false,
                                        ),
                                        DataCell(
                                          Text((stock[3])),
                                          showEditIcon: false,
                                          placeholder: false,
                                        ),
                                        DataCell(
                                          TextButton(
                                            onPressed: (){
                                              watchlist.watchlist.remove(stock);
                                              watchlistProvider.setWatchlist(watchlist);
                                            },
                                            child: const Text("Remove from Watchlist"),
                                          ),
                                          showEditIcon: false,
                                          placeholder: false,
                                        ),
                                      ]
                                  );
                                }
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