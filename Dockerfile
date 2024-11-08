# etapa de compilación
#FROM node:21.6.1-alpine as build-stage
#WORKDIR /app
#COPY package*.json ./
#RUN npm install
#COPY . .
#RUN npm run build

# etapa de producción
#FROM nginx:1.25.4-alpine AS production-stage
FROM nginx:1.27.2-alpine AS production-stage
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en'
ENV TZ="America/Guayaquil"
# Crear un usuario no privilegiado
RUN addgroup -S nginxgroup && adduser -S nginxuser -G nginxgroup
COPY dist /usr/share/nginx/html/sri-base-vue
# Ajustar permisos
##RUN chown -R nginxuser:nginxgroup /usr/share/nginx/html/sri-base-vue
##RUN chmod g+rwx -R /etc/nginx/
##RUN chmod g+rwx -R /var/cache/
##RUN chmod g+rwx -R /var/run/

RUN chown -R nginxuser:nginxgroup /usr/share/nginx/html/sri-base-vue
RUN chmod 755 /usr/share/nginx/html/sri-base-vue
RUN chown -R nginxuser:nginxgroup /var/cache/nginx
RUN chown -R nginxuser:nginxgroup /var/log/nginx
RUN chown -R nginxuser:nginxgroup /etc/nginx/conf.d

RUN touch /var/run/nginx.pid
RUN chown -R nginxuser:nginxgroup /var/run/nginx.pid



# Cambiar al usuario no privilegiado
USER nginxuser
EXPOSE 8080
#USER root
CMD ["nginx", "-g", "daemon off;"]

