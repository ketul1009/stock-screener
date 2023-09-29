/*
Copyright 2017 - 2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at
    http://aws.amazon.com/apache2.0/
or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations under the License.
*/




const express = require('express')
const bodyParser = require('body-parser')
const awsServerlessExpressMiddleware = require('aws-serverless-express/middleware')
const MongoClient = require('mongodb').MongoClient;

// declare a new express app
const app = express()
app.use(bodyParser.json())
app.use(awsServerlessExpressMiddleware.eventContext())

// Enable CORS for all methods
app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*")
  res.header("Access-Control-Allow-Headers", "*")
  next()
});

const url = process.env.MONGODB_CONNECTION_STRING;
const options = { useNewUrlParser: true, useUnifiedTopology: true };
const client = new MongoClient(url, options);

/**********************
 * Example get method *
 **********************/

app.get('/stockscreener/stocks', function(req, res) {
  // Add your code here
  getData(req, res);
});

app.get('/stockscreener/watchlist/:userId', function(req, res) {
  // Add your code here
  getWatchlist(req, res);
});

app.get('/stockscreener/*', function(req, res) {
  // Add your code here
  res.json({success: 'get call succeed!', url: req.url});
});

/****************************
* Example post method *
****************************/

app.post('/stockscreener', function(req, res) {
  // Add your code here
  res.json({success: 'post call succeed!', url: req.url, body: req.body})
});

app.post('/stockscreener/login', function(req, res) {
  // Add your code here
  login(req, res);
});

app.post('/stockscreener/signup', function(req, res) {
  // Add your code here
  signup(req, res);
});

/****************************
* Example put method *
****************************/

app.put('/stockscreener', function(req, res) {
  // Add your code here
  res.json({success: 'put call succeed!', url: req.url, body: req.body})
});

app.put('/stockscreener/watchlist/:userId', function(req, res) {
  addToWatchlist(req, res);
  //res.json({success: 'put call succeed!', url: req.url, body: req.body})
});

app.put('/stockscreener/removewatchlist/:userId', function(req, res) {
  removeWatchlist(req, res);
  //res.json({success: 'put call succeed!', url: req.url, body: req.body})
});

/****************************
* Example delete method *
****************************/

app.delete('/stockscreener', function(req, res) {
  // Add your code here
  res.json({success: 'delete call succeed!', url: req.url});
});

app.delete('/stockscreener/*', function(req, res) {
  // Add your code here
  res.json({success: 'delete call succeed!', url: req.url});
});

app.listen(3000, function() {
    console.log("App started")
});

async function login(req, res){
  
  try {
    await client.connect();
    var dbo = client.db('mydatabase');
    var collection = dbo.collection('users');
    var data = await collection.find({'userId':req.body.userId}).toArray();
    if(data.length==0){
      res.send('nouser');
    }
    else if(data[0]['password']==req.body.password){
      console.log("Login successful");
      res.setHeader('Content-Type', 'text/plain');
      res.json({userId: req.body.userId, password: req.body.password, status: 'true'});
    }
    else{
      console.log("Login unsuccessful");
      res.setHeader('Content-Type', 'text/plain');
      res.send('false');
    }
  } catch (error) {
    res.send(error);
  }

}

async function signup(req, res){
  
  try {
    await client.connect();
    var dbo = client.db('mydatabase');
    var collection = dbo.collection('users');
    var data = await collection.find({'userId':req.body.userId}).toArray();
    if(data.length!=0){
      res.send('unavailable');
    }
    else{
      await collection.insertOne({userId: req.body.userId, password: req.body.password});
      res.send("Successfully created user");
    }
  } catch (error) {
    console.log(error);
  }

}

async function getData(req, res){
  
  try {
    await client.connect();
    var dbo = client.db('mydatabase');
    var collection = dbo.collection('stockdata');
    var data = await collection.find({'stocks':'nifty50'}).toArray();
    res.json({payload: data});
  } catch (error) {
    res.send(error);
  }
}

async function addToWatchlist(req, res){

  try {
    const userId = req.params.userId;

    await client.connect();
    const dbo = client.db('mydatabase');
    const collection = dbo.collection('watchlists');
    const stock = req.body.stock;

    // Fetch the user's current watchlist
    const user = await collection.findOne({ userId: userId});
    if(user==null){
      await collection.insertOne({userId: userId, watchlist: [stock]});
      res.json({success: true, message: "Created new watchlist"});
    }
    else{
      var currentWatchlist = user.watchlist || [];
      if(!contains(currentWatchlist, stock)){
        currentWatchlist.push(stock);
        await collection.updateOne({ userId }, { $set: { watchlist: currentWatchlist } });
        res.json({ success: "Updated watchlist", user: user });
      }
      else{
        res.json({success: "Stock already in watchlist"})
      }
    }
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
}

async function getWatchlist(req, res){
  try {
    const userId = req.params.userId;

    await client.connect();
    const dbo = client.db('mydatabase');
    const collection = dbo.collection('watchlists');

    // Fetch the user's current watchlist
    const user = await collection.findOne({ userId: userId});
    if(user==null){
      res.json({watchlist: []});
    }
    else{
      var currentWatchlist = user.watchlist || [];
      res.json({watchlist: currentWatchlist});
    }
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
}

async function removeWatchlist(req, res){
  try {
    const userId = req.params.userId;

    await client.connect();
    const dbo = client.db('mydatabase');
    const collection = dbo.collection('watchlists');
    const stock = req.body.stock;

    // Fetch the user's current watchlist
    const user = await collection.findOne({ userId: userId});
    if(user!=null){
      var currentWatchlist = user.watchlist || [];
      if(currentWatchlist.length!=0){
        const index = getIndex(currentWatchlist, stock);
        if (index > -1) { // only splice array when item is found
          currentWatchlist.splice(index, 1); // 2nd parameter means remove one item only
        }
        await collection.updateOne({ userId }, { $set: { watchlist: currentWatchlist } });
        res.json({ success: "Updated watchlist", watchlist: currentWatchlist });
      }
    }
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
}

async function changePassword(req, res){
  try {
    const userId = req.params.userId;

    await client.connect();
    const dbo = client.db('mydatabase');
    const collection = dbo.collection('users');
    const newPwd = req.body.password;

    // Fetch the user's current watchlist
    const user = await collection.findOne({ userId: userId});
    if(user==null){
      await collection.insertOne({userId: userId, watchlist: [stock]});
      res.json({success: true, message: "Created new watchlist"});
    }
    else{
      var currentWatchlist = user.watchlist || [];
      if(!contains(currentWatchlist, stock)){
        currentWatchlist.push(stock);
        await collection.updateOne({ userId }, { $set: { watchlist: currentWatchlist } });
        res.json({ success: "Updated watchlist", user: user });
      }
      else{
        res.json({success: "Stock already in watchlist"})
      }
    }
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
}

function contains(currentWatchlist, stockToAdd){
  for(let i=0; i<currentWatchlist.length; i++){
    if(currentWatchlist[i].toString()==stockToAdd.toString()){
      return true;
    }
  }
  return false;
}

function getIndex(currentWatchlist, toRemove){
  for(let i=0; i<currentWatchlist.length; i++){
    if(currentWatchlist[i].toString() == toRemove.toString()){
      return i;
    }
  }
  return -1;
}

// Export the app object. When executing the application local this does nothing. However,
// to port it to AWS Lambda we will create a wrapper around that will load the app from
// this file
module.exports = app
