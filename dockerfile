FROM node:10-alpine AS build

WORKDIR /app

COPY . .

RUN npm install

RUN npm run build

FROM nginx:1.25.4-alpine3.18

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /var/www/html/

EXPOSE 8080

ENTRYPOINT ["nginx","-g","daemon off;"]