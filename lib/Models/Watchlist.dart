import 'package:flutter/cupertino.dart';

class Watchlist{
  List<List<dynamic>> watchlist;
  Watchlist(this.watchlist);
}

class WatchlistProvider with ChangeNotifier{
  Watchlist _watchlist;
  WatchlistProvider(this._watchlist);

  Watchlist get watchlist => _watchlist;

  void setWatchlist(Watchlist watchlist){
    _watchlist = watchlist;
    notifyListeners();
  }
}