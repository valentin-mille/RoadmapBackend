# RoadmapBackend 🗺️

A swift vapor back-end to run your own [Roadmap](https://github.com/AvdLee/Roadmap) server and database.
The database uses postgreSQL.

To run your own back-end there is 2 solutions:
1. Use a free Remote server & database
2. Use your server

# Remote server & database

This method has the advantage of being free and accessible for the roadmap usage. 

## Requirements 👷
- [Koyeb](https://www.koyeb.com/) account to expose the API.
- [ElephantSQL](https://www.elephantsql.com/) account for the database.

## Database - ElephantSQL 📦 

It is pretty straightforward. Create your account with a `Tiny Turtle` plan, and you are ready.

## 🗡️ API - Koyeb

Koyeb offers the possibility to deploy an API easily. Once you have your account and started to create your instance, this is the configuration you could use to run a healthy service:

1. Choose deployment using a Github repository.
2. Add this link: https://github.com/valentin-mille/RoadmapBackend
3. Choose the Dockerfile builder
4. Override the entrypoint : `["./App"]`
5. Override the command: `serve`
6. Override the arguments `["--env","production","--hostname","0.0.0.0","--port","8080"]`
7. Choose the **Web Service** type.
8. Choose the region you want.
9. Choose the instance (nano instance should be sufficient for this API)
10. Next add the following environment variables so your API knows how to connect to the database:

| Variable Name     | Type      | Value       |
| ----------------- | --------- | ----------- |
| DATABASE_HOST     | PlainText | db_server   |
| DATABASE_USERNAME | PlainText | db_username |
| DATABASE_PASSWORD | PlainText | db_password |
| APP_PORT          | PlainText | 8080        |

> [!NOTE]
> You can find and manage that informations in your elephantSQL account console.

11. Expose the `8080` port with the `HTTP` protocol and `/` for the Path.
12. Put a scaling number of one (it should be plenty for our usage).

<details>
<summary>Step 1 to 6 in image</summary>
  
![CleanShot 2023-09-13 at 11 07 46@2x](https://github.com/valentin-mille/RoadmapBackend/assets/40181807/8d5ee0d9-76ae-47d0-88f5-066f66e72698)
</details>

<details>
<summary>Step 7 to 12 in image</summary>
  
![CleanShot 2023-09-13 at 21 11 27@2x](https://github.com/valentin-mille/RoadmapBackend/assets/40181807/b378e1e9-9bcf-4f01-8936-660362595efe)
</details>


# Your server

## Requirements 👷
- [Docker](https://www.docker.com/) to deploy the API and the database.

## Deployment

If you have your own server already, you can put a `.env` file at the root of this repository with the following values:

```
DATABASE_HOST=[db_host]
DATABASE_USERNAME=[db_username]
DATABASE_PASSWORD=[password]
APP_PORT=8080
```

<details>
<summary>Those values depend on how you want to configure your database. See a simple and complete example here 👇</summary>
  
```
DATABASE_HOST=db
DATABASE_USERNAME=vapor_username
DATABASE_PASSWORD=vapor_password
APP_PORT=8080
```
</details>

When you have the `.env` file set up, you can run this command at the repository root to build and run the API and the database:

```bash
docker-compose up --build
```

Next you should expose the API port and you are ready.

# How to call your in server in your iOS app?

You can take inspiration from the [gist](https://gist.github.com/tylerstillwater/b129d1f3fe6efc87c08db6085053613f) from [Tyler Stillwater](https://github.com/tylerstillwater) that already shows how to use a custom API.

⚠️ You must change the URL endpoint call to be:

`https://[YOUR_APP].koyeb.app/get/{namespace}/{featureId}` to get the feature count.

`https://[YOUR_APP].koyeb.app/add/{namespace}/{featureId}/{delta}` to increment or decrement the feature count.

# Acknowledgement 🙏

Thanks for [Antoine](https://twitter.com/twannl), [Jordi](https://twitter.com/jordibruin) and [Hidde van der Ploeg](https://twitter.com/hiddevdploeg) a valuable Swift Package like [Roadmap](https://github.com/AvdLee/Roadmap).

Also thanks for [Tyler Stillwater](https://github.com/tylerstillwater) that inspire me to develop this project. 


