#### /api/oauth/exchange

запрос
```
{
    code: <string> oauth access code
}
```

ответ 
```
{
    token: <string> api access token
}
```

вернет ошибку если код не найден, либо если код не подтвержден пользователем
