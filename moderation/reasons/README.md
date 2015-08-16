#### Получить причину бана:
#####URL:[`/api/moderation/reasons`](http://funstream.tv/api/moderation/reasons)
**запрос:**
```js
{
    content: <string> //"Содержание причины запрета, 'chat' по умолчанию."
}
```
 
**ответ:**
```js
[
    ...,
    {
        id: <int>, //"Идентификатор причины."
        name: <string>, //"имя причины."
        content: <string> //"Содержание причины."
    }
    ...,
]
```
