#STAGE 1 BUILD ANGULAR dist
FROM node:latest as node
WORKDIR /app
COPY . .
RUN npm install
ARG env=prod
# RUN npm run build -- --prod --environment $env
RUN npm run build

#STAGE 2 DEPLOY ON NGINX
FROM nginx:alpine
# VOLUME /var/cache/nginx
COPY --from=node /app/dist /usr/share/nginx/html
COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf

USER 1001