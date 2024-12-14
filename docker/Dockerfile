FROM node:20

WORKDIR /app

ARG version=4.3.3

RUN npm create @moodlenet@${version} .
RUN echo '{}' > /app/default.config.json \
  && echo '' > /app/default.crypto.privateKey \
  && echo '' > /app/default.crypto.publicKey

EXPOSE 8080

CMD [ "npm", "start" ]
