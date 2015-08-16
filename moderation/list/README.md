#### Получить список банов:
#####URL:[`/api/moderation/list`](http://funstream.tv/api/moderation/list)
**запрос:**
```js
{
    from: <int|null>, //"От временной метки."
    to: <int|null>, //"До временной метки."
    reason: <int|null> //"Фильтр по указанной причине."
}
```
**ответ:**
```js
[
    ...,
    {
        id: <int>, //"Идентификатор бана."
        start: <int>, //"Время начала бана, временная метка."
        end: <int>, //"Время истечения бана, временная метка."
        reason: <obj> //"То же самое, что и /api/moderation/reasons объект"
    }
    ...,
]
```
