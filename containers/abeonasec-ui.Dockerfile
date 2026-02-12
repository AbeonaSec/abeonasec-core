# stage 1: build quasar project
# use node base image and set working directory
FROM node:24-slim AS builder
WORKDIR /app

# copy Quasar project into container and build
COPY abeonasec-ui/. .
RUN npm install
RUN npm run build

# stage 2: start nginx and serve built project
# copy the built Quasar project to the default site location
FROM docker.io/library/nginx:alpine
COPY --from=builder /app/dist/spa /usr/share/nginx/html/abeonasec-spa

# copy default configuration file
COPY abeonasec-ui/nginx-default.conf /etc/nginx/conf.d/default.conf

# expose port 80 and start nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
