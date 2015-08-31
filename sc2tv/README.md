## Документация, относящаяся к порталу [sc2tv.ru](http://sc2tv.ru)


API
------

Это апи сайта sc2tv, а не фанстрима. Соответственно, все запросы делаются на оригинальный сайт [sc2tv.ru](http://sc2tv.ru).  
Запросы передаются стандартным для POST запроса методом, то есть строкой вида
```name1=value1&name2=value2...```, ответы приходят в формате JSON.  
Для работы с API вам понадобится токен, процедуру получения смотрите в разделе [OAuth](oauth.md).

1. [**OAuth**](oauth.md)
  - [`POST` `/ajax/sc2tv_api/get_token` Получение токена пользователя](oauth.md#Получение-токена-пользователя)
2. [**Донат**](donate.md)
  - [`POST` `/ajax/sc2tv_api/donate` Донат произвольной суммы](donate.md#Донат-произвольной-суммы)
  - [`POST` `/ajax/sc2tv_api/fast_donate` Микродонат](donate.md#Микродонат)
  - [`POST` `/ajax/sc2tv_api/get_user_balance` Баланс пользователя](donate.md#Баланс-пользователя)
  - [`POST` `/ajax/sc2tv_api/get_user_balance_transactions` Транзакции пользователя](donate.md#Транзакции-пользователя)
  - [`POST` `/ajax/sc2tv_api/get_url_for_robo_restore` Пополнение баланса](donate.md#Пополнение баланса)