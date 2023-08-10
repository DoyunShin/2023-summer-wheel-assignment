FROM node:16-alpine

WORKDIR /app
COPY . .

RUN apk update && apk add curl

RUN npm ci

EXPOSE 80
ENV PORT 80
CMD ["npm", "run", "serve"]