#Build phase
FROM node:14-alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

#/app/build <- all web files

#RUN Phase with nginx
FROM nginx

EXPOSE 80
#COPY web files from build
COPY --from=builder /app/build /usr/share/nginx/html

#start nginx