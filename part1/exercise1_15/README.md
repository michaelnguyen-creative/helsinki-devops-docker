# Phonebook App
Restructure phonebook app from Full-Stack Open part3 (frontend) & part4 (backend) projects as a mono-repo

The fullstack app runs in Node 18

## Project goals:
- Develop a CI/CD pipeline for legacy code
- Practice code refactoring & software configuration management (webpack etc.)
- Practice app containerization with Docker

## Play with the code:

1. Run locally in production mode:

### Frontend
To create a production build of the frontend, run `npm run build`. This will create a `dist` folder at the root of the project

### Backend
By default, express app runs on port 8080

Run `npm run start-prod` to start express server in production mode

2. Run in a container

### Docker container
Run container with `docker run -p 8080:8080 michaelnguyencreative/fso-phonebook-fullstack`

---
## Other information
App deployed at https://fso-phonebook-fullstack.fly.dev/

> Note: Refactoring follows instructions & project template from Full-stack-open part 7's [example app](https://github.com/fullstack-hy2020/create-app)

Project source code at https://github.com/michaelnguyen-creative/full-stack-open-phonebook
