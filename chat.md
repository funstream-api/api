## Протокол взаимодействия

Клиент и сервер обмениваются событиями через socket.io. 
Опция 'transports' при соединении только 'websocket'. 
Все события для сервера получают ответ через коллбек. Формат ответа
```
{
    status: <string> "ok" on success, "error" on failure
    result: <array|obj|null>
}
```
в случае ошибки result обязательно присутствует и содержит поле message
Примеры взаимодействия клиента можно посмотреть на сайте socket.io. Примеры использования:

```
nodejs
var io = require('socket.io-client');
 
var socket = io.connect('http://funstream.tv:3811', {transports: ['websocket']});
 
socket.on('connect', function (data) {console.log("connect: ", data)});
socket.on('/chat/message', function(data) {console.log("message: ", data)});
 
socket.emit('/chat/login', {token: null}, function (data) {console.log("login: ", data)});
socket.emit('/chat/join', {channel: "main"}, function (data) {console.log("chat: ", data)});
```

```
c#
socket = IO.Socket("http://funstream.tv:3811", new IO.Options { Transports = ImmutableList.Create("websocket") });
 
socket.On(Socket.EVENT_CONNECT, (a) =>
{
    socket.Emit("/chat/login", (b) => { }, new JObject {["token"] = token });
    socket.Emit("/chat/join", (b) => {}, "{ \"channel\": \"stream/" + streamerID + "\"}");
});
 
socket.On(Socket.EVENT_CONNECT_ERROR, (b) => {});
```
 
## События для сервера

#### /chat/login

```
{
    token: <string>, jwt token
}
```

подписывает на события, относящиеся к пользователю
 
#### /chat/logout
отписывает от событий, относящихся к пользователю

#### /chat/join
```
{
    channel: <string|null> id of channel, null for defult
}
``` 
{
    status: 'ok',
}
присоединяет к событиям выбранного канала, если канал не указан - присоединяет к общему

#### /chat/leave
```
{
    channel: <string|null> id of channel
}
```
отсоединяет от событий выбранного канала

#### /chat/history
```
{
    channel: <string|null> channel id or null for default
    id: <int|null> id of starting message, last if not set
    amount: <int> amount of messages to select
    direction: <string> "up" or "down", the direction of message selection
    options: <obj|null> {
        addressed: <int|null> put user id here to receive only addressed+user messages or all messages
    }
}
```
возвращает amount сообщений в указанном направлении от текущего. Если направление вниз - то вернет более 
поздние, если вверх - более ранние.
(для более поздних в sql order by id, для более ранних order by id desc, чтобы было более понятно)

#### /chat/publish
```
{
    channel: <string> channel id
    from: <obj> {
        id: <int> user id, requires additional priveleges,
        name: <string> user name
    }
    to: <obj|null> {
        id: <int> user id,
        name: <string> user name
    }
    text: <string> message text   
}
```
сработает только после /chat/login

#### /chat/command
```
{
    command: <string> command name,
    params: <obj> command parameters
}
```
 
## События для клиента

#### /chat/message
```
{
    id: <int> id of message,
    from: <obj> {
        id: <int> user id
        name: <string> user name
    },
    to: <obj|null> user object, same as from,
    channel: <int> channel id,
    text: <string> message text
    time: <datetime> date and time of message
}
```
Приходит для всех сообщений в текущий канал пользователя. Если пользователь авторизован, то и для всех сообщений, адресованных текущему пользователю, для любого канала.

#### /chat/message/remove
```
{ 
    id: <int> id of message
    channel: <string> channel of message
}
```
Приходит для сообщений, которые должны быть удалены из чата.

#### /chat/user/join
```
{...data from /user/current api request...}
```
приходит для всех пользователей, подключившихся к чату, после /chat/join приходит полный список пользователей текущего канала, используя это событие

####/chat/user/leave
```
{
    id: <int> id of user, that had left this channel
}
```
Приходит для всех пользователей данного канала, покинувших его.