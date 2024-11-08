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
RUN chown -R nginxuser:nginxgroup /usr/share/nginx/html/sri-base-vue
RUN chmod o+rwx -R /etc/nginx/
RUN chmod o+rwx -R /var/cache/
RUN chmod o+rwx -R /var/run/
# Cambiar al usuario no privilegiado
USER nginxuser
EXPOSE 8080
#USER root
CMD ["nginx", "-g", "daemon off;"]
