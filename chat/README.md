API Чата:
------------------
1. [**Протокол взаимодействия:**](protocol.md#Протокол-взаимодействия)  
  - [Пример на `Node.js`](example/Node.js)
  - [Пример на `C#`](example/CSharp.cs)
2. **Оповещение сервера:**
  - [`/chat/login` Подписаться на события пользователя](login/README.md#Подписаться-на-события-пользователя)
  - [`/chat/logout` Отписаться от событий пользователя](logout/README.md#Отписаться-от-событий-пользователя)
  - [`/chat/join` Присоединится к каналу](join/README.md#Присоединится-к-каналу)
  - [`/chat/leave` Покинуть канал](leave/README.md#Покинуть-канал)
  - [`/chat/history` История канала](history/README.md#История-канала)
  - [`/chat/publish` Отправить сообщение](publish/README.md#Отправить-сообщение)
  - [`/chat/command` Выполнить команду](command/README.md#Выполнить-команду)
3. **Оповещение клиента о новом событии:**
  - [`/chat/message` Сообщение](message/README.md#Сообщение) 
  - [`/chat/message/remove` Удаление](message/remove/README.md#Удаление)
  - [`/chat/user/join` Присоединение к каналу](user/join/README.md#Присоединение-к-каналу)  
  - [`/chat/user/leave` Отсоединение от канала](user/leave/README.md#Отсоединение-от-канала)
4. [**Каналы чата, текущие и запланированные**](channels.md) 
