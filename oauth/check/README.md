#### Проверка прав: 
#####URL:[`/api/oauth/check`](http://funstream.tv/api/oauth/check)  
**запрос:**
```js
{
    code: <string> //"Код доступа OAuth"
}
```
**ответ:**
```js
{
    id: <int>, //"Идентификатор кода доступа."
    text: <string>, //"Текст переданный с кодом доступа."
}
```
