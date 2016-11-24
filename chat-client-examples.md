Примеры подключения к WS чата
=============================

- [JavaScript](#javascript)
- [Go](#go)
- [Node.js](#nodejs)
- [C#](#c)


##### JavaScript

```ts
<script src='http://cdn.socket.io/socket.io-1.3.5.js'></script>

<script type='text/javascript'>

    var socket = io('wss://chat.funstream.tv', {
        transports: ['websocket'],
        path: '/',
        reconnection: true,
        reconnectionDelay: 500,
        reconnectionDelayMax: 2000,
        reconnectionAttempts: Infinity
    });

    // listen new messages
    socket.on('/chat/message', function(message) {

        console.log('new message');
        console.log(message);
    });

    socket.on('connect', function () {

        console.log('socket connected');

        // join chat channel
        socket.emit('/chat/join', {channel: 'main'}, function(data) {

            console.log('joined main');
        });
    });

    socket.on('connect_error', function(error) {

        console.log('socket connect error');
        console.log(error);
    });

    socket.on('reconnect', function() {

        console.log('socket reconnect');
    });
</script>
```


##### Go

Клиент и сервер для socket.io https://github.com/graarh/golang-socketio



##### Node.js

```ts
var io = require('socket.io-client');

var socket = io.connect('wss://chat.funstream.tv', {
    transports: ['websocket']
});

socket.on('connect', function(data) {

    console.log('connect: ', data)
});
socket.on('/chat/message', function(data) {

    console.log('message: ', data)
});

socket.emit('/chat/login', {token: null}, function(data) {

    console.log('login: ', data)
});
socket.emit('/chat/join', {channel: 'main'}, function(data) {

    console.log('chat: ', data)
});
```


##### C\#

```c#
socket = IO.Socket("wss://chat.funstream.tv", new IO.Options { Transports = ImmutableList.Create("websocket") });

socket.On(Socket.EVENT_CONNECT, (a) =>
{
    socket.Emit("/chat/login", (b) => { }, new JObject {["token"] = token });
    socket.Emit("/chat/join", (b) => {}, "{ \"channel\": \"stream/" + streamerID + "\"}");
});

socket.On(Socket.EVENT_CONNECT_ERROR, (b) => {});
```
