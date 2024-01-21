FROM node:16

WORKDIR /app

RUN npm create @moodlenet@3.2.0 .
RUN rm default.config.json && rm default.crypto.privateKey && rm default.crypto.publicKey

EXPOSE 8080

CMD [ "npm", "start" ]
