#### Задать вопрос:  
#####URL:[`/api/support/ask`](http://funstream.tv/api/support/ask)  
**запрос:**
```js
{
    category: <int>, //"Идентификатор категории."
    question: <string> //"Текст вопроса."
}
```
**ответ:**
```js
{
    id: <int>, //"Идентификатор вопроса."
    time: <string>, //"Дата и время вопроса(Юникс формат)."
    category: <obj> {/*"... Те же данные, что и  /stream/category API запрос, без опций..."*/},
    question: <string>, //"Текст вопроса."
    active: <bool> //"true если нет ответа."
}
```
