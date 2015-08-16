var io = require('socket.io-client');

var socket = io.connect('http://funstream.tv:3811', {transports: ['websocket']});

socket.on('connect', function (data) {console.log("connect: ", data)});
socket.on('/chat/message', function(data) {console.log("message: ", data)});

socket.emit('/chat/login', {token: null}, function (data) {console.log("login: ", data)});
socket.emit('/chat/join', {channel: "main"}, function (data) {console.log("chat: ", data)});
