# How to start 
## Create a user
POST `http://localhost:4000/api/users`\
Body:
```json
{
  "user": {
    "email": "someone@mail.com",
    "name": "someone",
    "password": "123123"
  }
}
```

## Get a token
POST `http://localhost:4000/api/users/token`\
Body:
```json
{
  "data": {
    "email": "someone@mail.com",
    "password": "123123"
  }
}
```
## Create a Lambda
POST `http://localhost:4000/api/lambdas`\
Header: `Authorization: Bearer <TOKEN>`\
Body:
```json
{
  "lambda": {
    "name": "Hello Lambda",
    "code": ":ok",
    "path": "hello",
    "params": {},
    "user_id": "ebd17da6-910a-4f1d-b1f3-19e2f45e46a0"
  }
}
`user_id` will be the id of the user created in the first step.
```