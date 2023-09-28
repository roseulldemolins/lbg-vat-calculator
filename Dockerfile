FROM node:19-alpine AS build

# Sets working directory
WORKDIR /app

# Copying file with dependencies first, before  copying
COPY package.json .
RUN npm install

# Copy from current folder into working directory
COPY . .

# Now run the build
RUN npm run build

FROM nginx:1.23-alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]