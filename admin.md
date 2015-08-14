API Администратора:
==================
-[Поддержка](#Поддержка)  
-[Модерация](#Модерация)

## Поддержка

#### `/api/support/list`
**запрос:**
```js
{
    category: <int|null> "id of category",
    from: <int|null> "starting date of search (unix timestamp)",
    onlyActive: <bool|null> "return only active questions (unanswered), true by default"
}
```
**ответ<sup>1</sup>:**
```js
[
    ...,
    {... /support/ask request ...},
    ...
]
```
<sup>1</sup>вернет ошибку если нет прав или неверная категория.

#### `/api/support/ask`
**запрос:**
```js
{
    category: <int> "id of category",
    question: <string> "text of question"
}
```
**ответ:**
```js
{
    id: <int> "id of question",
    time: <string> "datetime of question (unix timestamp)",
    category: <obj> {"... same data as /stream/category api request, no options..."},
    question: <string> text of question",
    active: <bool> "true if no answer"
}
```

## Модерация

#### `/api/moderation/check`
**запрос:**
```js
{
    userId: <int> "id of user to check"
}
```
**ответ:**
```js
{
    banned: <bool> "true if banned, false if not or if user is not exist",
    expire: <int> "ban expire timestamp, or 0 if not banned"
}
```
*Если банов несколько, то вернет тот, который заканчивается позднее всего. Вернёт ошибку на пустой или 
несуществующий `userId`.*

#### `/api/moderation/accuse`
**запрос:**
```js
{
    userId: <int> "id of user for ban attempt",
    reasonId: <int> "id of reason",
    data: <object|null> "any custom data to store"
}
```
*Ответ пустой, вернет ошибку если пользователь или причина не существует, либо если пользователь не залогинен.*

#### `/api/moderation/reasons`
**запрос:**
```js
{
    content: <string> "content of the ban reason, 'chat' by default"
}
```
 
**ответ:**
```js
[
    ...,
    {
        id: <int> "id of reason",
        name: <string> "name of reason",
        content: <string> "content of reason"
    }
    ...,
]
```

#### `/api/moderation/list`
**запрос"**
```js
{
    from: <int|null> "from timestamp",
    to: <int|null> "to timestamp",
    reason: <int|null> "filter by given reason",
}
```
**ответ:**
```js
[
    ...,
    {
        id: <int> "id of ban",
        start: <int> "start time of ban, timestamp",
        end: <int> "end time of ban, timestamp",
        reason: <obj> "same as /api/moderation/reasons object"
    }
    ...,
]
```
 
#### `/api/moderation/undo`
**запрос:**
```js
{
    ban: <int> "id of ban"
}
```
*Ответ пустой.*
*Отменяет выбранный бан, при этом выдавая бан всем пользователям, которые его ставили.*
*Ответ ошибка если пользователь не авторизован или не имеет прав модератора.*
