FROM node:16

WORKDIR /app

ARG version=3.2.0

RUN npm create @moodlenet@${version} .
RUN echo '{}' > /app/default.config.json \
  && echo '' > /app/default.crypto.privateKey \
  && echo '' > /app/default.crypto.publicKey

EXPOSE 8080

CMD [ "npm", "start" ]
