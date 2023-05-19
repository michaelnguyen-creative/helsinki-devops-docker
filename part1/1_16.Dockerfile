FROM node:18-alpine AS base
WORKDIR /usr/src/app
COPY package*.json .

FROM base AS frontend-build
RUN npm i
COPY webpack* babel* ./
COPY ./client ./client
RUN npm run build

FROM frontend-build AS start
RUN npm ci --only=production
COPY --from=frontend-build /usr/src/app/dist .
COPY ./server ./server
COPY --chown=node index.js .

ENV NODE_ENV=production
USER node
CMD ["npm", "run", "start-prod"]
