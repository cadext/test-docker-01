# etapa de compilación
#FROM node:21.6.1-alpine as build-stage
#WORKDIR /app
#COPY package*.json ./
#RUN npm install
#COPY . .
#RUN npm run build

# etapa de producción
FROM nginx:1.25.4-alpine as production-stage
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en'
ENV TZ="America/Guayaquil"
#COPY --from=build-stage /app/dist /usr/share/nginx/html/sri-base-vue
COPY dist /usr/share/nginx/html/sri-base-vue
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
