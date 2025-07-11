# Base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy source files
COPY /devops-build/build/ /usr/share/nginx/html

# Serve the app using Nginx
FROM nginx:alpine

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

