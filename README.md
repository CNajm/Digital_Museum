# 2221 11/26/20 100349302

## Group Project (done solo)
-  **[Codebase Permalink](https://gitlab.com/cnajm/2210_digital_museum)** 
- SQL DB setup file included. The backend looks for the DB in the root directory.

This project aims to create a digital museum where online visitors will be able to find info on select works of art with prominent thematic elements or interesting stories.

## Installation 

This project uses the SEVN stack (SQL, Express, Vue, NodeJS) and is to be run off your localhost.

There is a frontend, which abstracts a lot of the DB logic and is easy on the eyes as well as a backend which serves the data and communicates with the DB engine.

#### Backend
The two share several dependencies. After the first install, the second should finish quickly due to the cached modules. The frontend is chunkier, it took around ~2 minutes to get it online on a 1 MB/s connection.
```
cd backend/
npm install
npm run start
```
#### Frontend
```
cd frontend/
npm install
npm run serve
```
Run both simultaneously in two terminal instances then navigate to `localhost:8080`
