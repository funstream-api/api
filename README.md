*[Funstream.tv](http://funstream.tv) API и утилиты для помощи с интеграцией.*

F.A.Q:
------------------
  - Почему документация API именно на [Github.com](https://github.com/)?
    - Потому, что будут еще и утилиты.

API:
------------------
  1. [**API Модерации:**](moderation/README.md)  
    - [Проверить забанен ли пользователь.](moderation/check/README.md#Проверить-забанен-ли-пользователь)  
    - [Забанить пользователя.](moderation/accuse/README.md#Забанить-пользователя)  
    - [Получить причину бана.](moderation/reasons/README.md#Получить-причину-бана)  
    - [Получить список банов.](moderation/list/README.md#Получить-список-банов)  
    - [Отменить бан.](moderation/undo/README.md#Отменить-бан)  
  2. [**API Поддержки:**](support/README.md)  
    - [Получить список вопросов.](support/list/README.md#Получить-список-вопросов)  
    - [Задать вопрос.](support/ask/README.md#Задать-вопрос)  
  3. [**API чата:**](chat/README.md)
    - [**Протокол взаимодействия:**](chat/protocol.md#Протокол-взаимодействия)  
      - [Пример на `Node.js`](chat/example/Node.js)
      - [Пример на `C#`](chat/example/CSharp.cs)
    - **Оповещение сервера:**
      - [Подписаться на события пользователя.](chat/login/README.md#Подписаться-на-события-пользователя)
      - [Отписаться от событий пользователя.](chat/logout/README.md#Отписаться-от-событий-пользователя)
      - [Присоединится к каналу.](chat/join/README.md#Присоединится-к-каналу)
      - [Покинуть канал.](chat/leave/README.md#Покинуть-канал)
      - [История канала.](chat/history/README.md#История-канала)
      - [Отправить сообщение.](chat/publish/README.md#Отправить-сообщение)
      - [Выполнить команду.](chat/command/README.md#Выполнить-команду)
    - **Оповещение клиента:**
      - [Сообщение.](chat/message/README.md#Сообщение) 
      - [Удаление.](chat/message/remove/README.md#Удаление)
      - [Присоединение к каналу.](chat/user/join/README.md#Присоединение-к-каналу)  
      - [Отсоединение от канала.](chat/user/leave/README.md#Отсоединение-от-канала)
    - [**Каналы чата, текущие и запланированные.**](chat/channels.md) 
  4.[**OAuth API:**](oauth/README.md)
    - [Запросить разрешение.](oauth/README.md#Запросить-разрешение)
    - [Получить токен.](oauth/README.md#Получить-токен)
    - [Проверка.](oauth/README.md#Проверка)
    - [Предоставить права.](oauth/README.md#Предоставить-права)
