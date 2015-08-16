#### Запросить разрешение: 
#####URL:[`/api/oauth/exchange`](http://funstream.tv/api/oauth/exchange)  
**запрос:**
```js
{
    code: <string> //"Код доступа OAuth."
}
```
**ответ:**
```js
{
    token: <string> //"Токен доступа API."
}
```
Вернет ошибку если код не найден, либо если код не подтвержден пользователем.
