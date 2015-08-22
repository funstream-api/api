API Чата
------
1. [**Протокол взаимодействия**](#Протокол-взаимодействия)
  - [Пример на `Node.js`](#Примеры-использования-на-nodejs)
  - [Пример на `C#`](#Примеры-использования-на-c)
2. [**Оповещение сервера**](#Оповещение-сервера)
  - [`WS` `P` `/chat/login` Подписаться на события пользователя](#Подписаться-на-события-пользователя)
  - [`WS` `A` `/chat/logout` Отписаться от событий пользователя](#Отписаться-от-событий-пользователя)
  - [`WS` `P` `/chat/join` Присоединится к каналу](#Присоединится-к-каналу)
  - [`WS` `P` `/chat/leave` Покинуть канал](#Покинуть-канал)
  - [`WS` `P` `/chat/history` История канала](#История-канала)
  - [`WS` `A` `/chat/publish` Отправить сообщение](#Отправить-сообщение)
  - [`WS` `P` `/chat/command` Выполнить команду](#Выполнить-команду)
3. [**Оповещение клиента**](#Оповещение-клиента)
  - [`WS` `P` `/chat/message` Новое сообщение](#Сообщение)
  - [`WS` `P` `/chat/message/remove` Удаление сообщения](#Удаление)
  - [`WS` `P` `/chat/user/join` Присоединение к каналу](#Присоединение-к-каналу)
  - [`WS` `P` `/chat/user/leave` Отсоединение от канала](#Отсоединение-от-канала)
4. [**Каналы чата, текущие и запланированные**](#Каналы-чата-текущие-и-запланированные)

## Протокол взаимодействия

Клиент и сервер обмениваются событиями через [`socket.io`](http://socket.io/).
При соединении значении опции `transports` может быть только 'websocket'.
Все события для сервера получают ответ через коллбек.

**Формат ответа**
```js
{
    status: <string>, // ""ok" on success, "error" on failure"
    result: <array|obj|null>
}
```
в случае ошибки `result` обязательно присутствует и содержит поле `message`.
Примеры взаимодействия клиента можно посмотреть на сайте [`socket.io`](http://socket.io/).

#### Примеры использования на `Node.js`

```js
var io = require('socket.io-client');

var socket = io.connect('http://funstream.tv:3811', {transports: ['websocket']});

socket.on('connect', function (data) {console.log("connect: ", data)});
socket.on('/chat/message', function(data) {console.log("message: ", data)});

socket.emit('/chat/login', {token: null}, function (data) {console.log("login: ", data)});
socket.emit('/chat/join', {channel: "main"}, function (data) {console.log("chat: ", data)});
```

#### Примеры использования на `C#`
```C#
socket = IO.Socket("http://funstream.tv:3811", new IO.Options { Transports = ImmutableList.Create("websocket") });

socket.On(Socket.EVENT_CONNECT, (a) =>
{
    socket.Emit("/chat/login", (b) => { }, new JObject {["token"] = token });
    socket.Emit("/chat/join", (b) => {}, "{ \"channel\": \"stream/" + streamerID + "\"}");
});

socket.On(Socket.EVENT_CONNECT_ERROR, (b) => {});
```

## Оповещение сервера

#### Подписаться на события пользователя
#####[`/chat/login`](http://funstream.tv/api/chat/login)
```js
{
    token: <string>, jwt токен*
}
```
*[`jwt.io`](http://jwt.io/)

Подписывает на события, относящиеся к пользователю.

#### Отписаться от событий пользователя
#####[`/chat/logout`](http://funstream.tv/api/)

Отписывает от событий, относящихся к пользователю.

#### Присоединится к каналу
#####[`/chat/join`](http://funstream.tv/api/chat/join)
```js
{
    channel: <string|null>  // Идентификатор канала, null  по умолчанию
}
```

Присоединяет к событиям выбранного канала, если канал не указан - присоединяет к общему.

#### Покинуть канал
#####[`/chat/leave`](http://funstream.tv/api/chat/leave)
```js
{
    channel: <string|null> // имя канала
}
```
Отсоединяет от событий выбранного канала.

#### История канала
#####[`/chat/history`](http://funstream.tv/api/chat/history)
```js
{
    channel: <string|null>, // имя канала, канал по умолчанию если null
    id: <int|null>, // идентификатор начального сообщения, последнее если null
    amount: <int>, // необходимое количество сообщений для выборки
    direction: <string>, // 'up' и 'down', направление выборки
    options: <obj|null> {
        addressed: <int|null> // указать идентификатор пользователя
          //если нужны только адресованные сообщения +user", все сообщения если null"
    }
}
```
Возвращает `amount` сообщений в указанном направлении от текущего. Если направление вниз - то вернет более поздние, если вверх - более ранние.
*(На примере SQL: Для более поздних `order by id`, для более ранних `order by id desc`,)*

#### Отправить сообщение
#####[`/chat/publish`](http://funstream.tv/api/chat/publish)
```js
{
    channel: <string>, // имя канала
    from: <obj> {
        id: <int>, // идентификатор пользователя, требует дополнительных привилегий
        name: <string> // имя пользователя
    }
    to: <obj|null> {
        id: <int>, // идентификатор пользователя
        name: <string> // имя пользователя
    }
    text: <string> // текст сообщения
}
```
Будет работать только после `/chat/login`

#### Выполнить команду
#####[`/chat/command`](http://funstream.tv/api/chat/command)
```js
{
    command: <string>, // имя команды
    params: <obj> // параметры команды
}
```

## Оповещение клиента

#### Сообщение
#####[`/chat/message`](http://funstream.tv/api/chat/message)
```js
{
    id: <int>, // идентификатор сообщения
    from: <obj> {
        id: <int>, // идентификатор пользователя
        name: <string> // имя пользователя
    },
    to: <obj|null>, // user object, тоже самое что и from
    channel: <string|null>  // Идентификатор канала, null  по умолчанию
    text: <string>, // текст сообщения
    time: <datetime> // дата и время сообщения
}
```
Приходит для всех сообщений в текущий канал пользователя. Если пользователь авторизован, то и для всех сообщений, адресованных текущему пользователю, для любого канала.

#### Удаление
#####[`/chat/message/remove`](http://funstream.tv/api/chat/message/remove)
```js
{
    id: <int>, // идентификатор сообщения
    channel: <string> "канал сообщения"
}
```
Приходит для сообщений, которые должны быть удалены из чата.

#### Присоединение к каналу
#####[`/chat/user/join`](http://funstream.tv/api/chat/user/join)
Ответ пустой. Приходит для каждого пользователя подключившегося к каналу, после` /chat/join`.

#### Отсоединение от канала
#####[`/chat/user/leave`](http://funstream.tv/api/chat/user/leave)
Ответ пустой. Приходит для каждого пользователя покинувшего канал.


## Каналы чата, текущие и запланированные
  1. `main` - Мэин чат
  2. `admin` - Админка(доступ у модераторов, саппортов)
  3. `stream/<streamer id>` - Стрим
  4. `goodgame.ru/<streamer id>` - Сообщения с гудгейма, если у стримера активен этот плеер
  5. `twitch.tv/<streamer id>` - Сообщения с твича, если у стримера активен этот плеер
  6. `support/<id>` - Вопрос к хелпдеску
  7. `private/<from_id>/<to_id>` - Личные сообщения
  8. `notifications/<user_id>` - Системные уведомления для пользователя