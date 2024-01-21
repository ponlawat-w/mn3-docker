FROM node:16

WORKDIR /app

RUN npm create @moodlenet@3.2.0 .
RUN cp /app/node_modules/@moodlenet/core/dist/ignite.mjs ~/core-ignite-original.mjs \
  && cp /app/node_modules/@moodlenet/react-app/dist/server/webpack/lockFile.mjs ~/react-lockfile-original.mjs \
  && cp /app/node_modules/@moodlenet/key-value-store/dist/server/exports.mjs ~/kvs-original.mjs
RUN sed -i "s|await initAll()|await rootImportLog('@moodlenet\/react-app', 'init')|g" /app/node_modules/@moodlenet/core/dist/ignite.mjs \
  && sed -i "s|await startAll()|await rootImportLog('@moodlenet\/react-app', 'start')|g" /app/node_modules/@moodlenet/core/dist/ignite.mjs \
  && sed -i "s/\s*}\s*from\s*'fs'/, existsSync } from 'fs'/g" /app/node_modules/@moodlenet/react-app/dist/server/webpack/lockFile.mjs \
  && sed -i 's|unlinkSync(LOCKFILE)|(existsSync(LOCKFILE) \&\& unlinkSync(LOCKFILE))|g' /app/node_modules/@moodlenet/react-app/dist/server/webpack/lockFile.mjs
COPY ./build-kv-store.mjs /app/node_modules/@moodlenet/key-value-store/dist/server/exports.mjs
RUN npm start
RUN mv ~/core-ignite-original.mjs /app/node_modules/@moodlenet/core/dist/ignite.mjs \
  && mv ~/react-lockfile-original.mjs /app/node_modules/@moodlenet/react-app/dist/server/webpack/lockFile.mjs \
  && mv ~/kvs-original.mjs /app/node_modules/@moodlenet/key-value-store/dist/server/exports.mjs
RUN rm default.config.json && rm default.crypto.privateKey && rm default.crypto.publicKey

COPY ./restore-kv.mjs /app/node_modules/@moodlenet/react-app/dist/server/init/restore-kv.mjs
RUN sed -i "s|export {};|await import('./init/restore-kv.mjs');export{};|g" /app/node_modules/@moodlenet/react-app/dist/server/init.mjs

EXPOSE 8080

CMD [ "npm", "start" ]
