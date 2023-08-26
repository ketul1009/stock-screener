import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Image.asset('images/logo.png',
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
                        context.go("/filter");
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
