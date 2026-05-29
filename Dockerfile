FROM node:24-alpine as base

WORKDIR /app

COPY package*.json .
RUN npm install

COPY . . 

FROM base as dev

EXPOSE 3000 5173 9230
CMD ["npm", "run", "dev:docker"]

FROM base as tests

RUN npm test
RUN touch /.tests-successfull

FROM base as builder

COPY --from=tests /.tests-successfull .
RUN npm run build

FROM node:24-alpine as prod
WORKDIR /app

COPY package*.json .
RUN npm install --omit=dev

COPY --from=builder /app/dist ./dist

CMD ["npm", "run", "start"]