#### Отправить сообщение:
#####URL:[`/chat/publish`](http://funstream.tv/api/chat/publish)  
```js
{
    channel: <string>, //"имя канала."
    from: <obj> {
        id: <int>, //"идентификатор пользователя, требует дополнительных привилегий."
        name: <string> //"имя пользователя."
    }
    to: <obj|null> {
        id: <int>, //"идентификатор пользователя."
        name: <string> //"имя пользователя."
    }
    text: <string> //"текст сообщения."  
}
```
Будет работать только после `/chat/login`  
