FROM node:16-alpine

WORKDIR /app
COPY . .

RUN npm i && npm run build && npm i -g serve

EXPOSE 80
CMD ["sh", "-c", "npx react-inject-env set && serve -s build -l 80"]