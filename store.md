API Магазина
============
- [**Бонусы**](#Бонусы)
    - [Типы бонусов и их параметры](#Типы-бонусов-и-их-параметры)
    - [`POST` `StA` `/api/store/bonus/modify` Создание/изменение бонуса](#Создание-изменение-бонуса)
    - [`POST` `StA` `/api/store/bonus/list` Список бонусов](#Список-бонусов)
- [**Баллы**](#Баллы)
    - [`POST` `StS` `/api/store/points/get` Баллы пользователя](#Баллы-пользователя)
    - [`POST` `A` `/api/store/points/my` Баллы текущего пользователя](#Баллы-текущего-пользователя)
    - [`POST` `StS` `/api/store/points/set` Изменить баллы пользователя](#Изменить-баллы-пользователя)


---

Все запросы недоступны внутри [пакетного запроса](common.md#Пакетный-запрос).

---


## Бонусы


#### Типы бонусов и их параметры
Для каждого типа бонусов указан его тип `type` и параметры `config` из соответствующих полей данных бонуса далее.

##### Минимальный уровень гражданки
```
'citizenMinLevel'

config: {
    level: number; // Значение
}
```

##### Цвет ника
```
'nickColor'

config: {
    color: string; // Цвет в '#HEX' формате
}
```

##### Смайлы
```
'smiles'

config: {
    smiles: string[]; // Коды смайлов
}
```

##### Смайлов в сообщении
```
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
    duration: number; // Длительность купленного бонуса
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
    duration: number; // Длительность купленного бонуса
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
{
```
**ответ**
```ts
[
    Object, // Данные бонуса, объект из ответа /api/store/bonus/modify
    ...
]
```
*[`/api/store/bonus/modify`](#Создание-изменение-бонуса)*  



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
*Вернёт ошибку если передан неверный идентификатор пользователя.*  


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
*Вернёт ошибку если передан неверный идентификатор пользователя.*