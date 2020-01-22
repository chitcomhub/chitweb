FROM nginx:latest

RUN rm /etc/nginx/conf.d/default.conf
COPY ./compose/production/nginx/chitcom.ru.conf /etc/nginx/conf.d
