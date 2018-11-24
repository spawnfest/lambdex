# How to start 
## Create a user
POST `http://localhost:4000/api/users`
body
```json
{
	"user": {
		"email": "pbrudnick@gmail.com",
	    "name": "pablo",
	    "password": "123123"
	}
}
```

## Get a token
POST `http://localhost:4000/api/users/token`
body
```json
{
	"data": {
		"email": "pbrudnick@gmail.com",
	    "password": "123123"
	}
}
```
## Create a Lambda
POST `http://localhost:4000/api/lambdas`
header `Authorization: Bearer <TOKEN>`
body
```json
{
	"lambda": {
		"code": ":ok",
	    "path": "hello",
	    "params": {},
	    "user_id": "ebd17da6-910a-4f1d-b1f3-19e2f45e46a0"
	}
}
`user_id` will be the id of the user created in the first step.
```