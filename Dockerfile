FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
# Add this line to skip ESLint during the build
ENV DISABLE_ESLINT_PLUGIN=true
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html