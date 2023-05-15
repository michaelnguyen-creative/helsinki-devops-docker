// example-frontend app
FROM node:16-alpine
WORKDIR /usr/src/app

COPY package*.json .
RUN npm i -g serve && npm ci --only=production

COPY . .
RUN npm run build

CMD ["serve", "-sl", "4000", "build"]