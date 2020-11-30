# 2221 11/26/20 100349302
- [Installation](#installation)
- [Backend](#backend)
- [Frontend](#frontend)
- [Queries Used](#queries-used)
- [Extra Features](#extra-features)
- [Disclaimer](#disclaimer)
# Group Project (done solo)
-  **[Codebase Permalink](https://gitlab.com/cnajm/2210_digital_museum)** 
- SQL DB setup file included. The backend looks for the DB in the root directory.

This project aims to create a digital museum where online visitors will be able to find info on select works of art with prominent thematic elements or interesting stories.

## Installation 

This project uses the SEVN stack (SQL, Express, Vue, NodeJS) and is to be run off your localhost.

There is a frontend, which abstracts a lot of the DB logic and is easy on the eyes as well as a backend which serves the data and communicates with the DB engine.

### Backend
The two share several dependencies. After the first install, the second should finish quickly due to the cached modules. The frontend is chunkier than the backend, it took around ~2 minutes to get it online on a 1 MB/s connection.
```
cd backend/
npm install
npm run start
```
### Frontend
```
cd frontend/
npm install
npm run serve
```
Run both simultaneously in two terminal instances then navigate to `localhost:8080`

## Queries Used
- Projection
- Selection
- Join
- Aggregation
- Nested Aggregation
- Delete (on cascade functionality can be found on Creators page, delete a relevant inspiration row)
- Update (edit Art description)

Queries can be found all over the place, most centralized usage of them is in the backend's `server.js` file.

## Extra Features
The fronend implements Vue+Vuetify. 

Vuetify is a UI component library for Vue that uses the [material design](https://material.io/design) specifications, similar to Bootstrap.

## Disclaimer 
All commits past the due date (27@00:00) (everything after 9d3791d0) are commits that update this README file to add more details about the project.

Commit d1ace345 adds cosmetic changes to the About page to make it look more aesthetically pleasing and to mirror some of the info found in this README. The code added is raw HTML and does not affect the project's functionality in any way. 