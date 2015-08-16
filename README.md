*[Funstream.tv](http://funstream.tv) API и утилиты для помощи с интеграцией.*

F.A.Q:
------------------
  - Почему документация API именно на [Github.com](https://github.com/)?
    - Потому, что будут еще и утилиты.

API:
------------------
  1. [**API Модерации:**](moderation/README.md)  
    - [`/api/moderation/check` Проверить забанен ли пользователь](moderation/check/README.md#Проверить-забанен-ли-пользователь) 
    - [`/api/moderation/accuse` Забанить пользователя](moderation/accuse/README.md#Забанить-пользователя)  
    - [`/api/moderation/reasons` Получить причину бана](moderation/reasons/README.md#Получить-причину-бана)  
    - [`/api/moderation/list` Получить список банов](moderation/list/README.md#Получить-список-банов)  
    - [`/api/moderation/undo` Отменить бан](moderation/undo/README.md#Отменить-бан)  
  2. [**API Поддержки:**](support/README.md)  
    - [`/api/support/ask` Получить список вопросов](support/list/README.md#Получить-список-вопросов)  
    - [`/api/support/list` Задать вопрос](support/ask/README.md#Задать-вопрос)  
  3. [**API чата:**](chat/README.md)
    - [**Протокол взаимодействия:**](chat/protocol.md#Протокол-взаимодействия)  
      - [Пример на `Node.js`](chat/example/Node.js)
      - [Пример на `C#`](chat/example/CSharp.cs)
    - **Оповещение сервера:**
      - [`/chat/login` Подписаться на события пользователя](chat/login/README.md#Подписаться-на-события-пользователя)
      - [`/chat/logout` Отписаться от событий пользователя](chat/logout/README.md#Отписаться-от-событий-пользователя)
      - [`/chat/join` Присоединится к каналу](chat/join/README.md#Присоединится-к-каналу)
      - [`/chat/leave` Покинуть канал](chat/leave/README.md#Покинуть-канал)
      - [`/chat/history` История канала](chat/history/README.md#История-канала)
      - [`/chat/publish` Отправить сообщение](chat/publish/README.md#Отправить-сообщение)
      - [`/chat/command` Выполнить команду](chat/command/README.md#Выполнить-команду)
    - **Оповещение клиента о новом событии:**
      - [`/chat/message` Сообщение](chat/message/README.md#Сообщение) 
      - [`/chat/message/remove` Удаление](chat/message/remove/README.md#Удаление)
      - [`/chat/user/join` Присоединение к каналу](chat/user/join/README.md#Присоединение-к-каналу)  
      - [`/chat/user/leave` Отсоединение от канала](chat/user/leave/README.md#Отсоединение-от-канала)
    - [**Каналы чата, текущие и запланированные**](chat/channels.md) 
  4. [**OAuth API:**](oauth/README.md)
    - [`/api/oauth/request` Запросить разрешение](oauth/request/README.md#Запросить-разрешение)
    - [`/api/oauth/exchange` Получить токен](oauth/exchange/README.md#Получить-токен)
    - [`/api/oauth/check` Проверка прав](oauth/check/README.md#Проверка)
    - [`/api/oauth/grant` Предоставить права](oauth/grant/README.md#Предоставить-права)
