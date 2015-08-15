## Поддержка

Роли получаются вызовом /api/user/current, некоторые вызовы требуют наличие определенной роли.
Если в вызове не написано какую роль он требует, значит может быть вызван пользователем с любой ролью.

#### /api/support/list
запрос
```
{
    category: <int|null> id of category,
    from: <int|null> starting date of search (unix timestamp)
    onlyActive: <bool|null> return only active questions (unanswered), true by default
}
```
ответ
```
[
    ...,
    {... /support/ask request ...},
    ...
]
```
вернет ошибку если нет прав или неверная категория, требует наличия роли support

#### /api/support/ask
запрос
```
{
    category: <int> id of category,
    question: <string> text of question
}
```
ответ
```
{
    id: <int> id of question,
    time: <string> datetime of question (unix timestamp),
    category: <obj> {... same data as /stream/category api request, no options...},
    question: <string> text of question,
    active: <bool> true if no answer
}
```

вернет ошибку если пользователь неавторизован, или указана неверная категория

## Модерация

#### /api/moderation/check
запрос
```
{
    userId: <int> id of user to check
}
```
ответ
```
{
    banned: <bool> true if banned, false if not or if user is not exist
    expire: <int> ban expire timestamp, or 0 if not banned
}
```
Если банов несколько, то вернет тот, который заканчивается позднее всего. Вернёт ошибку на пустой или 
несуществующий userId

#### /api/moderation/accuse
запрос
```
{
    userId: <int> id of user for ban attempt
    reasonId: <int> id of reason
    data: <object|null> any custom data to store
}
```
ответ пустой, вернет ошибку если пользователь или причина не существует, 
либо если пользователь не авторизован

#### /api/moderation/reasons
запрос
```
{
    content: <string> content of the ban reason, "chat" by default
}
```
 
ответ
```
[
    ...,
    {
        id: <int> id of reason,
        name: <string> name of reason,
        content: <string> content of reason
    }
    ...,
]
```

#### /api/moderation/list
запрос
```
{
    from: <int|null> from timestamp,
    to: <int|null> to timestamp,
    reason: <int|null> filter by given reason,
}
```
ответ
```
[
    ...,
    {
        id: <int> id of ban,
        start: <int> start time of ban, timestamp,
        end: <int> end time of ban, timestamp,
        reason: <obj> same as /api/moderation/reasons object
    }
    ...,
]
```
вернет ошибку если польователь неавторизован, у него недостаточно прав, либо передано неверное id причины
Требует роль moderation
 
#### /api/moderation/undo
запрос
```
{
    ban: <int> id of ban
}
```
ответ пустой
Отменяет выбранный бан, при этом выдавая бан всем пользователям, которые его ставили. 
Даст ошибку если пользователь не авторизован или у него недостаточно прав. Требует роль moderation.