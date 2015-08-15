API Чата:
------------------
1. [**Протокол взаимодействия:**](#Протокол-взаимодействия)  
  - [Пример на `Node.js`](#Примеры-использования-на-nodejs)
  - [Пример на `C#`](#Примеры-использования-на-c)
2. [**Оповещение сервера:**](#Оповещение-сервера)  
  - [Подписатся на события пользователя.](#Подписатся-на-события-пользователя)
  - [Отписатся от событий пользователя.](#Отписатся-от-событий-пользователя)
  - [Присоединится к каналу.](#Присоединится-к-каналу)
  - [Покинуть канал.](#Покинуть-канал)
  - [История.](#История)
  - [Отправить сообщение.](#Отправить-сообщение)
  - [Команда.](#Команда)
3. [**Оповищение клиента:**](#Оповещение-клиента)
  - [Сообщение.](#Сообщение) 
  - [Удалить.](#Удалить)
  - [Присоединение к каналу.](#Присоединение-к-каналу)  
  - [Отсоединение от канала.](#Отсоединение-от-канала)
4. [**Каналы чата, текущие и запланированные.**](#Каналы-чата-текущие-и-запланированные)
  
## Протокол взаимодействия:

Клиент и сервер обмениваются событиями через [`socket.io`](http://socket.io/). 
При соединении значении опции `transports` может быть только 'websocket'.
Все события для сервера получают ответ через коллбек.

**Формат ответа:**
```js
{
    status: <string> "ok" on success, "error" on failure
    result: <array|obj|null>
}
```
в случае ошибки `result` обязательно присутствует и содержит поле `message`.
Примеры взаимодействия клиента можно посмотреть на сайте [`socket.io`](http://socket.io/). 

####Примеры использования на `Node.js`:

```js
var io = require('socket.io-client');
 
var socket = io.connect('http://funstream.tv:3811', {transports: ['websocket']});
 
socket.on('connect', function (data) {console.log("connect: ", data)});
socket.on('/chat/message', function(data) {console.log("message: ", data)});
 
socket.emit('/chat/login', {token: null}, function (data) {console.log("login: ", data)});
socket.emit('/chat/join', {channel: "main"}, function (data) {console.log("chat: ", data)});
```

####Примеры использования на `C#`:
```C#
socket = IO.Socket("http://funstream.tv:3811", new IO.Options { Transports = ImmutableList.Create("websocket") });
 
socket.On(Socket.EVENT_CONNECT, (a) =>
{
    socket.Emit("/chat/login", (b) => { }, new JObject {["token"] = token });
    socket.Emit("/chat/join", (b) => {}, "{ \"channel\": \"stream/" + streamerID + "\"}");
});
 
socket.On(Socket.EVENT_CONNECT_ERROR, (b) => {});
```
 
## Оповещение сервера:

#### Подписатся на события пользователя:  
#####URL:[`/chat/login`](http://funstream.tv/api/chat/login)  
```js
{
    token: <string>, jwt токен*
}
```
*[`jwt.io`](http://jwt.io/)   

подписывает на события, относящиеся к пользователю
 
#### Отписатся от событий пользователя:  
#####URL:[`/chat/logout`](http://funstream.tv/api/)  
отписывает от событий, относящихся к пользователю.  

#### Присоединится к каналу:  
#####URL:[`/chat/join`](http://funstream.tv/api/chat/join)  
```js
{
    channel: <string|null> Идентификатор канала, `null`  по умолчанию.
}
```js 
{
    status: 'ok',
}
```
присоединяет к событиям выбранного канала, если канал не указан - присоединяет к общему.

#### Покинуть канал:    
#####URL:[`/chat/leave`](http://funstream.tv/api/chat/leave)  
```js
{
    channel: <string|null> id of channel
}
```
отсоединяет от событий выбранного канала.

#### История:   
#####URL:[`/chat/history`](http://funstream.tv/api/chat/history)  
```js
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

#### Отправить сообщение:
#####URL:[`/chat/publish`](http://funstream.tv/api/chat/publish)  
```js
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
сработает только после `/chat/login`

#### Команда:  
#####URL:[`/chat/command`](http://funstream.tv/api/chat/command)  
```js
{
    command: <string> command name,
    params: <obj> command parameters
}
```
 
## Оповещение клиента:

#### Сообщение:  
#####URL:[`/chat/message`](http://funstream.tv/api/chat/message)  
```js
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

#### Удалить:  
#####URL:[`/chat/message/remove`](http://funstream.tv/api/chat/message/remove)  
```js
{ 
    id: <int> id of message
    channel: <string> channel of message
}
```
Приходит для сообщений, которые должны быть удалены из чата.

#### Присоединение к коналу:  
#####URL:[`/chat/user/join`](http://funstream.tv/api/chat/user/join)  
```js
{...data from /user/current api request...}
```
приходит для всех пользователей, подключившихся к чату, после /chat/join приходит полный список пользователей текущего канала, используя это событие

#### Отсоединение от канала:  
#####URL:[`/chat/user/leave`](http://funstream.tv/api/chat/user/leave)  
```
{
    id: <int> id of user, that had left this channel
}
```
Приходит для всех пользователей данного канала, покинувших его.

## Каналы чата, текущие и запланированные:

```main``` - главный чат списка стримов
```admin``` - чат хелпдеска и модераторов
```stream/<streamer id>``` - стрим
```goodgame.ru/<streamer id>``` - сообщения с гудгейма, если у стримера активен этот плеер
```twitch.tv/<streamer id>``` - сообщения с твича, если у стримера активен этот плеер
```support/<id>``` - вопрос к хелпдеску
```private/<from_id>/<to_id>``` - личные сообщения
```notifications/<user_id>``` - системные уведомления для пользователя
