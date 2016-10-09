API Магазина
============
- [**Бонусы**](#Бонусы)
    - [Типы бонусов и их параметры](#Типы-бонусов-и-их-параметры)
    - [`POST` `StA` `/api/store/bonus/modify` Создание/изменение бонуса](#Созданиеизменение-бонуса)
    - [`POST` `StA` `/api/store/bonus/list` Список бонусов](#Список-бонусов)
- [**Бонусы пользователя**](#Бонусы-пользователя)
    - [`POST` `StS` `/api/store/purchase/list` Список бонусов пользователя](#Список-бонусов-пользователя)
    - [`POST` `A` `/api/store/purchase/my` Список бонусов текущего пользователя](#Список-бонусов-текущего-пользователя)
    - [`POST` `StS` `/api/store/purchase/remove` Удалить бонус пользователя](#Удалить-бонус-пользователя)
    - [`POST` `StS` `/api/store/purchase/modify` Изменение данных бонуса пользователя](#Изменение-данных-бонуса-пользователя)
    - [`POST` `A/StS` `/api/store/purchase/setStatus` Изменение статуса бонуса пользователя](#Изменение-статуса-бонуса-пользователя)
- [**Покупка бонуса**](#Покупка-бонуса)
    - [`POST` `A` `/api/store/buy/pekoins` Покупка бонуса за пекоины](#Покупка-бонуса-за-пекоины)
    - [`POST` `A` `/api/store/buy/points` Покупка бонуса за баллы](#Покупка-бонуса-за-баллы)
- [**Баллы**](#Баллы)
    - [`POST` `StS` `/api/store/points/get` Баллы пользователя](#Баллы-пользователя)
    - [`POST` `A` `/api/store/points/my` Баллы текущего пользователя](#Баллы-текущего-пользователя)
    - [`POST` `StS` `/api/store/points/set` Изменить баллы пользователя](#Изменить-баллы-пользователя)
- [**Подписки на стримеров**](#Подписки-на-стримеров)
    - [`POST` `A` `/api/store/subscription/purchase` Купить подписку на стримера](#Купить-подписку-на-стримера)
    - [`POST` `StS` `/api/store/subscription/list` Список подписок пользователя](#Список-подписок-пользователя)
    - [`POST` `A` `/api/store/subscription/my` Список подписок текущего пользователя](#Список-подписок-текущего-пользователя)
    - [`POST` `StS` `/api/store/subscription/modify` Добавление/изменение подписки пользователя](#Добавлениеизменение-подписки-пользователя)
    - [`POST` `StS` `/api/store/subscription/remove` Удаление подписки пользователя](#Удаление-подписки-пользователя)
    - [`POST` `A/StS` `/api/store/subscription/setStatus` Изменение статуса подписки](#Изменение-статуса-подписки)


---

Все запросы недоступны внутри [пакетного запроса](common.md#Пакетный-запрос).

---


## Бонусы


#### Типы бонусов и их параметры
Для каждого типа бонусов указан его тип `type` и параметры `config` из соответствующих полей данных бонуса далее.

##### Минимальный уровень гражданки
```ts
'citizenMinLevel'

config: {
    level: number; // Значение
}
```

##### Цвет ника
```ts
'nickColor'

config: {
    color: string; // Цвет в '#HEX' формате
}
```

##### Смайлы
```ts
'smiles'

config: {
    smiles: string[]; // Коды смайлов
}
```

##### Смайлов в сообщении
```ts
'smilesPerMessage'

config: {
    amount: number; // Число смайлов в сообщении
}
```


#### Создание/изменение бонуса
##### [`POST` `StA` `/api/store/bonus/modify`](http://funstream.tv/api/store/bonus/modify)
**запрос**
```ts
{
    id?: number; // Идентификатор бонуса, не нужен при создании нового
    type: string; // Тип бонуса, см. типы бонусов выше
    config: Object; // Параметры бонуса, см типы бонусов выше
    duration: number; // Длительность купленного бонуса, в секундах
    name: string; // Название
    price: { // Стоимость
        canBePurchased: boolean; // Возможность купить бонус
        pekoins: number; // Стоимость в пекоинах
        points: number; // Стоимость в баллах
    };
    view: { // Параметры отображения
        category: number; // Идентификатор категории
        position: number; // Позиция
        linked: boolean; //Флаг зависимости от предыдущего бонуса
    };
}
```
**ответ**
```ts
{
    id: number;// Идентификатор бонуса
    type: string; // Тип бонуса, см. типы бонусов выше
    config: Object; // Параметры бонуса, см типы бонусов выше
    duration: number; // Длительность купленного бонуса, в секундах
    name: string;
    price: { // Стоимость
        canBePurchased: boolean; // Возможность купить бонус
        pekoins: number; // Стоимость в пекоинах
        points: number; // Стоимость в баллах
    };
    view: { // Параметры отображения
        category: number; // Идентификатор категории
        position: number; // Позиция
        linked: boolean; //Флаг зависимости от предыдущего бонуса
    };
}
```


#### Список бонусов
##### [`POST` `StA` `/api/store/bonus/list`](http://funstream.tv/api/store/bonus/list)
**запрос**
```ts
{}
```
**ответ**
```ts
[
    Object, // Данные бонуса, объект из ответа /api/store/bonus/modify
    ...
]
```
*[`/api/store/bonus/modify`](#Созданиеизменение-бонуса)*  



## Бонусы пользователя

#### Список бонусов пользователя
##### [`POST` `StS` `/api/store/purchase/list`](http://funstream.tv/api/store/purchase/list)
**запрос**
```ts
{
    userId: number; // Идентификатор пользователя
}
```
**ответ**
```ts
[
    { // Данные бонуса пользователя
        id: number; // Идетификатор бонуса пользователя
        userId: number; // Идентификатор пользователя
        bonusId: number; // Идентификатор бонуса
        expires: unixtime; // Время окончания бонуса, 0 если без времени окончания
        active: boolean; // Статус бонуса (используется например для включения-выключения цвета ника)
    },
    ...
]
```


#### Список бонусов текущего пользователя
##### [`POST` `A` `/api/store/purchase/my`](http://funstream.tv/api/store/purchase/my)
**запрос**
```ts
{}
```
**ответ**
```ts
[
    Object, // Объект из ответа /api/store/purchase/list
    ...
]
```
*[`/api/store/purchase/list`](#Список-бонусов-пользователя)*  


#### Удалить бонус пользователя
##### [`POST` `StS` `/api/store/purchase/remove`](http://funstream.tv/api/store/purchase/remove)
**запрос**
```ts
{
    id: number; // Идентификатор бонуса пользователя
}
```
**ответ**
```ts
{}
```


#### Изменение данных бонуса пользователя
##### [`POST` `StS` `/api/store/purchase/modify`](http://funstream.tv/api/store/purchase/modify)
**запрос**
```ts
{
    // Данные бонуса пользователя, объект из ответа /api/store/purchase/list
}
```
**ответ**
```ts
{
    // Обновлённые данные бонуса пользователя, объект из ответа /api/store/purchase/list
}
```
*[`/api/store/purchase/list`](#Список-бонусов-пользователя)*  


#### Изменение статуса бонуса пользователя
##### [`POST` `A/StS` `/api/store/purchase/setStatus`](http://funstream.tv/api/store/purchase/setStatus)
**запрос**
```ts
{
    id: number; // Идентификатор бонуса пользователя
    active: boolean; // Статус
}
```
**ответ**
```ts
{
    // Обновлённые данные бонуса пользователя, объект из ответа /api/store/purchase/list
}
```
*[`/api/store/purchase/list`](#Список-бонусов-пользователя)*  



## Покупка бонуса

#### Покупка бонуса за пекоины
##### [`POST` `A` `/api/store/buy/pekoins`](http://funstream.tv/api/store/buy/pekoins)
**запрос**
```ts
{
    bonusId: number; // Идентификатор бонуса
}
```
**ответ**
```ts
[
    ... // Новый список бонусов пользователя, массив из ответа /api/store/purchase/list
]
```
*[`/api/store/purchase/list`](#Список-бонусов-пользователя)*  
*Вернёт ошибку если на счету пользователей не хватает пекоинов.*


#### Покупка бонуса за баллы
##### [`POST` `A` `/api/store/buy/points`](http://funstream.tv/api/store/buy/points)
**запрос**
```ts
{
    bonusId: number; // Идентификатор бонуса
}
```
**ответ**
```ts
[
    ... // Новый список бонусов пользователя, массив из ответа /api/store/purchase/list
]
```
*[`/api/store/purchase/list`](#Список-бонусов-пользователя)*  
*Вернёт ошибку если на счету пользователей не хватает баллов.*



## Баллы

#### Баллы пользователя
##### [`POST` `StS` `/api/store/points/get`](http://funstream.tv/api/store/points/get)
**запрос**
```ts
{
    userId: number; // Идентификатор пользователя
}
```
**ответ**
```ts
{
    userId: number; // Идентификатор пользователя
    amount: number; // Число баллов пользователя
}
```


#### Баллы текущего пользователя
##### [`POST` `A` `/api/store/points/my`](http://funstream.tv/api/store/points/my)
**запрос**
```ts
{}
```
**ответ**
```ts
{
    // Объект из ответа  /api/store/points/get
}
```
*[`/api/store/points/get`](#Баллы-пользователя)*  


#### Изменить баллы пользователя
##### [`POST` `StS` `/api/store/points/set`](http://funstream.tv/api/store/points/set)
**запрос**
```ts
{
    userId: number; // Идентификатор пользователя
    amount: number; // Число баллов пользователя
}
```
**ответ**
```ts
{
    // Новые данные баллов пользователя, объект из ответа  /api/store/points/get
}
```
*[`/api/store/points/get`](#Баллы-пользователя)*  



## Подписки на стримеров

#### Купить подписку на стримера
##### [`POST` `A` `/api/store/subscription/purchase`](http://funstream.tv/api/store/subscription/purchase)
**запрос**
```ts
{
    streamerId: number; // Идентификатор стримера
}
```
**ответ**
```ts
{}
```
*Вернёт ошибку если на счету пользователя не хватает пекоинов.*  


#### Список подписок пользователя
##### [`POST` `StS` `/api/store/subscription/list`](http://funstream.tv/api/store/subscription/list)
**запрос**
```ts
{
    userId: number; // Идентификатор пользователя
}
```
**ответ**
```ts
[
    Object, // Подписка пользователя, объект из ответа  /api/store/subscription/modify
    ...
]
```
*[`/api/store/subscription/modify`](#Добавлениеизменение-подписки-пользователя)*  


#### Список подписок текущего пользователя
##### [`POST` `A` `/api/store/subscription/my`](http://funstream.tv/api/store/subscription/my)
**запрос**
```ts
{}
```
**ответ**
```ts
[
    Object, // Подписка пользователя, объект из ответа  /api/store/subscription/modify
    ...
]
```
*[`/api/store/subscription/modify`](#Добавлениеизменение-подписки-пользователя)*  


#### Добавление/изменение подписки пользователя
##### [`POST` `StS` `/api/store/subscription/modify`](http://funstream.tv/api/store/subscription/modify)
**запрос**
```ts
{
    id?: number; // Не нужен при добавлении новой подписки
    userId: number;
    streamerId: number;
    expires: unixtime;
    active: boolean;
}
```
**ответ**
```ts
{
    id: number; // Идентификатор подписки
    userId: number; // Идентификатор пользователя
    streamerId: number; // Идентификатор стримера на которого подписка
    expires: unixtime; // Время окончания подписки, 0 если без времени окончания
    active: boolean; // Статус подписки (используется только для включения/выключения иконки)
}
```


#### Удаление подписки пользователя
##### [`POST` `StS` `/api/store/subscription/remove`](http://funstream.tv/api/store/subscription/remove)
**запрос**
```ts
{
    id: number; // Идентификатор подписки
}
```
**ответ**
```ts
{}
```


#### Изменение статуса подписки
##### [`POST` `A/StS` `/api/store/subscription/setStatus`](http://funstream.tv/api/store/subscription/setStatus)
**запрос**
```ts
{
    id: number; // Идентификатор подписки
    active: boolean; // Статус
}
```
**ответ**
```ts
{
    // Новые данные подписки, объект из ответа /api/store/subscription/modify
}
```
*[`/api/store/subscription/modify`](#Добавлениеизменение-подписки-пользователя)*  
*Влияет только на активную иконку пользователя*  

