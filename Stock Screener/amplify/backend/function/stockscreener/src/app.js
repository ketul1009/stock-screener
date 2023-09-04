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

app.put('/stockscreener/*', function(req, res) {
  // Add your code here
  res.json({success: 'put call succeed!', url: req.url, body: req.body})
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
    if(data[0]['password']==req.body.password){
      console.log("Login successful");
      res.setHeader('Content-Type', 'text/plain');
      res.send('true');
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
    await collection.insertOne({userId: req.body.userId, password: req.body.password});
    res.send("Successfully created user");
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

// Export the app object. When executing the application local this does nothing. However,
// to port it to AWS Lambda we will create a wrapper around that will load the app from
// this file
module.exports = app
