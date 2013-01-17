var express = require('express');
var http = require('http');
var app = express();
var server = http.createServer(app);
var io = require('socket.io').listen(server);
var ccc = ['a','b','c','d','e'];


app.set('view engine', 'jade');
app.set('view options', {layout: true});
app.set('views', __dirname + '/views');

app.get('/stooges/chat', function(req, res, next){
	res.render('chat');
});
io.sockets.on('connection', function(socket){
	var sendChat = function(title, text){
		socket.emit('chat', {
			title: title,
			contents: text 
		});
	};
	setInterval(function(){
		var randomIndex = Math.floor(Math.random()*ccc.length);
		sendChat('Stooge', ccc[randomIndex]);
	}, 5000);
	sendChat('Welcome to Stooge Chat', 'The Stooges are on the line');
	socket.on('chat', function(data){
		sendChat('You', data.text);
	});
});
app.get('/?', function(req, res){
	res.render('index');
});
server.listen(8888);
