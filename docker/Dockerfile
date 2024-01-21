FROM node:16

WORKDIR /app

ARG version=3.2.0

RUN npm create @moodlenet@${version} .
RUN rm default.config.json && rm default.crypto.privateKey && rm default.crypto.publicKey

EXPOSE 8080

CMD [ "npm", "start" ]
