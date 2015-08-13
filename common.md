# Общие положения

Запрос посылается методом POST, если не указано другое.
Авторизация происходит через токен в header. Например, 
 
```
POST /user/current HTTP/1.1
Token: Bearer <your token here>
```
 
Успешный ответ приходит со статусом 200. 
При ошибке ответ приходит со статусом 500, формат ошибки
```
{
    message: <string> error message
}
```

Параметры, значение которых должно быть установлено в null, могут не передаваться.

Версия api передается через accept. Например,
``` 
GET /user/current HTTP/1.1
Accept: application/json; version=1.0
```
В данный момент передавать версию не обязательно.

Запросы передаются на сайт http://funstream.tv для общего апи и на http://funstream.tv:3811 для чата.

Примеры запросов на curl:
```
curl -H "Content-Type: application/json" -H "Accept: application/json; version 1.0" -X POST -d '{name: "...", password: "..."}' http://funstream.tv/api/user/login
curl -H "Content-Type: application/json" -H "Accept: application/json; version 1.0" -H "Token: Bearer ..." -X POST -d '{content: "stream"}' http://funstream.tv/api/subscribe/subscribers
```
 
## Пользователь

#### /api/user
запрос (можно передать как отдельно id или name, так и вместе)
``` 
{
    id: <int|null> id of user,
    name: <string|null> login of user
}
```
ответ
```
{
    id: <int> id of user
    name: <string> login of user
}
```
возвращает ошибку в случае если пользователь с таким именем или id не найден, либо если и имя и id 
переданы как null

#### /api/user/current
запрос пустой, под этой фразой в дальнейшем подразумевается запрос вида {}

ответ, если токена авторизации нету
```
{
    guest: true,
    settings: <obj> default user settings, see /api/user/settings,
    roles: <obj> {
        ...
    } default user roles
}
```
ответ, если токен авторизации есть
```
{
    guest: false,
    id: <int> id of current user
    name: <string> login of current user
    settings: <obj> user settings, see /api/user/settings,
    roles: <obj> {
        support: <bool> support role, false by default
        canUseSupport: <bool> allow to ask questions to support and join support channels, true by default
        moderator: <bool> allow to undo ban, false by default,
        citizen: <int> vote power of citizen moderation, 0 by default,
    } user roles
}
```
возвращает ошибку если токен авторизации ошибочный

#### /api/user/login
запрос
```
{
    name: <string> user login ,
    password: <string> user password
}
```
ответ
```
{
    token: <string> string with token,
    current: <obj> {...data from /user/current api request...}
}
```
возвращает ошибку если пользователь с таким именем и паролем не найден

#### /api/user/settings
запрос и ответ идентичны:
```
{
 
    stream: <obj> {
        autostart: <bool>, start player automatically, true by default,
        player: <string>, preferred player, not set by default,
        skipmain: <bool>, skip main page and to to filter, default is false,
    },
    chat: <obj> {
        smiles: <bool>, show smile pictures, true by default
        images: <bool>, show images preview in chat, false by default
        fontsize: <int>, chat font size, default 12
        namecolor: <int>, chat username color, default 0
        mychannels: <array of strings>, chat locked channels list, default empty array
        theme: <string>, theme of chat, default is 'default'
        disablenamecolor: <bool>, use only default nickname color for chat, default is false
        thirdparty: <bool>, show messages from twitch and goodgame, default is true
    }
}
```
вернет ошибку если токена авторизации нету или он ошибочен, или если указаны ошибочные настройки
в запросе могут отсутствовать все поля, или их часть
если в запросе присутствуют поля - их значения будут сохранены для текущего пользователя

#### /api/user/logout
запрос пустой, ответ пустой
уничтожает куку, установленную при логине

#### /api/user/register
запрос
```
{
    name: <string> user login ,
    password: <string> user password,
    email: <string> user email, 
    recaptchaResponse: <string> response string to google recaptcha
}
```
ответ
```
{
    token: <string> string with token,
    current: <obj> {...data from /user/current api request...}
}
```
возвращает ошибку если пользователь с таким именем уже существует, либо если не была пройдена капча

## Категория

#### /api/category
запрос
```
{
    content: <string> type of category, currently only 'stream',
    id: <int|null> id of category,
    slug: <string|null> slug name of category,
    options: <object|null> {
        subCategories: <bool|null> include subcategories if true,
        contentAmount: <bool|null> include amount of content if true
    }
}
```
ответ
```
{
    id: <int> id of category,
    slug: <string> slug name of category,
    name: <string> name of category,
    subCategories: <array|null> {... same data as /stream/category api request...},
    contentAmount: <int|null> number of content
}
```
subCategories=true возвращает только один уровень подкатегорий, рекурсии нет
вернет ошибку если категория с таким id или slug не найдена, самая верхняя категория ищется по slug, 
с именем 'top', если id и slug установлены в null одновременно, вернет ошибку

## Стрим

#### /api/stream
запрос
```
{
    id: <int|null> id of stream,
    streamer: <string|null> login of user,
    options: <obj|null> {
        players: <bool|null> include players for current stream if true
    }
}
```
ответ
```
{
    streamer: <obj> {...same data as /user api request...},
    name: <string> stream name,
    description: <string> stream description,
    category: <obj> {...same data as /stream/category api request, no options...},
    image: <string> url of preview image,
    thumbnail: <string> url of the player thumbnail image,
    adult: <bool> adult flag,
    rating: <int> current rating of the stream,
    players: <array|null> [
        ...,
        {
            name: <string> name of player provider, e.g. twitch,
            channel: <string> name of channel for this provider
            code: <string> html code of player
        },
        ...,
    ]
}
```
вернет ошибку если стрима с данным id не существует, либо не указаны ни id ни streamer. 

## Чат

#### /api/smile
запрос
````
{
    channel: <string> chat channel, for streams it is 'stream/<streamer id>'
}
```
ответ
```
[
    ...,
    [
        ...,
        {
            code: <string> smile code,
            image: <string> smile image,
            position: <int> smile position on this tab,
            usable: <bool> smile can be posted by user,  
            width: <int> width of the smile,
            height: <int> height of the smile, 
        },
        ...
    ],
    ...
]
```

#/api/channel/data
запрос
```
{
    channels: <array> [
        <string> channel unique id, for stream it is 'stream/<streamer id>'
        ...
    ]
}
```
ответ
```
[
    {
        id: <string> channel unique id,
        name: <string> channel name,
        user: <obj|null> {id: <int>, name: <string>} user object
 }
]
```
если в запросе пустой массив, запрос пустой или если среди запрошенных каналов есть хотя бы один 
некорректный - вернет ошибку
если token отсутствует или неверный - вернет ошибку

## Фильтр

#### /api/content
запрос
```
{
    content: <string> type of content, currently only 'stream',
    type: <string> type of filter, can be: 'all, 'my',
    category: <obj|null> {
        id: <int|null> category id
        slug: <string|null> category slug   
    },
    options: <obj|null> {
        save: <bool|null> saves current type and category for this type of content to options if true
    }
}
```
ответ
```
{
    category: <obj> {
        parent: <obj|null> {... same data as /stream/category api request, no options...},
        current: <obj> {...same data as /stream/category api request, with contentAmount=true, subCategories=true...},
    },   
    content: <array> [
        ...,
        <content obj>
        ...,
    ],
    subscribed: <null|int> amount of elements for this category in subscriptions, null if not logged in   
}
```
для стримов аналогичен ответу /api/stream, players=false
вернет ошибку если указан ошибочный тип контента, ошибочный тип фильтра или несуществующая категория
вернет ошибку если установлена опция save=true, и при этом токен авторизации не передан или ошибочный
вернет ошибку, если type=my, и при этом токен авторизации не передан или ошибочный

#### /api/content/top
запрос
```
{  
    content: <string> type of content, currently only 'stream',
    category: <obj|null> { 
        id: <int|null> category id 
        slug: <string|null> category slug 
    }, 
    amount: <int> amount of top elements
}
```
ответ
```
{
    content: <array> [
        ...,
        <content obj>
        ...,
    ]   
}
```
вернет amount элементов с наивысшим рейтингом, сортировка по рейтингу
вернет ошибку если amount > 10
для стримов аналогичен ответу /api/stream, players=true
вернет ошибку если указан ошибочный тип контента, ошибочный тип фильтра или несуществующая категория

## Подписки

#### /api/subscribe/add
запрос
```
{
    content: <string> type of content, currently only 'stream',
    id: <int> id of content element
}
```
Ответ пустой. Вернет ошибку если неверно указан контент, id не существует, не авторизован или неверный token.

#### /api/subscribe/check
запрос
```
{
    content: <string> type of content, currently only 'stream',
    id: <int> id of content element
}
```
ответ
```
{
    result: <bool> true if subscribed
}
```
Вернет ошибку если неверно указан контент, id не существует, не авторизован или неверный token.

#### /api/subscribe/remove
запрос
```
{
    content: <string> type of content, currently only 'stream',
    id: <int> id of content element
}
```
Ответ пустой. Вернет ошибку если неверно указан контент, id не существует, не авторизован или неверный token.

#### /api/subscribe/list
запрос
```
{
    content: <string> type of content, currently only 'stream'
}
```
ответ
```
[
    <obj> object of given content, only /api/stream currently,
    ...,
    <obj>
]
```
Вернет ошибку если пользователь не авторизован, либо передан неверный контент.

#### /api/subscribe/subscribers
Если пользователь стример, то вернет всех подписанных на него пользователей.
запрос
```
{
    content: <string> type of content, currently only 'stream'
}
```
ответ
```
[
    <obj> same as /api/user object,
    ...,
    <obj>
]
```
 
Вернет ошибку если пользователь неавторизован, либо не является стримером, либо передан неверный контент.

#### /api/subscribe/amount
Считает количество активных элементов в подписках у пользователя.
запрос
```
{
    content: <string> content of request, currently only 'stream'
}
```
ответ:
```
{
    amount: <int> amount of active subscribes with given content
}
``` 
 
## Игноры

#### /api/ignore/add
запрос
```
{
    content: <string> content of ignore,
    item: <int> item id
}  
```
ответ пустой, даст ошибку если пользователь неавторизован

#### /api/ignore/remove
запрос
```
{
    content: <string> content of ignore,
    item: <int> item id
}  
```
ответ пустой, даст ошибку если пользователь неавторизован

#### /api/ignore/list
запрос
```
{
    content: <string> content of ignore
}
```
ответ
```
[
    ...,
    {
        content: <string> content of ignore,
        item: <int> item id
    },
    ...
]
```
вернет ошибку если пользователь неавторизован

#### /api/ignore/in
запрос
```
{
    content: <string> content of ignore,
    item: <int> item id
}
```
ответ
```
{
    ignored: <bool> true if ignored
}
```
вернет ошибку если пользователь неавторизован

## Дополнительные вызовы

#### /api/support?name=<streamer_name> (заменить на json?)
Получить список последних поддержавших для данного стримера за 5 минут. 
ответ
``` 
[
    {
        "date": <float> unixtime of support, e.g. 1435324807.598,
        "support": <string> supporter name
        "amount": <float> amount,
        "msg": <string> message
    },
    ...
]
```