###################
# BUILD FOR LOCAL DEVELOPMENT
###################

FROM node:18-alpine As development

WORKDIR /usr/src/app

COPY --chown=node:node index.js package*.json ./

RUN npm install

COPY --chown=node:node . .

USER node

###################
# BUILD FOR PRODUCTION
###################

FROM node:18-alpine As build

WORKDIR /usr/src/app

COPY --chown=node:node index.js package*.json ./
COPY --chown=node:node --from=development /usr/src/app/db ./db
COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules

COPY --chown=node:node . .

ENV NODE_ENV production

RUN npm ci --omit=dev && npm cache clean --force

USER node

###################
# PRODUCTION
###################

FROM node:18-alpine As production

COPY --chown=node:node --from=build /usr/src/app/index.js ./index.js
COPY --chown=node:node --from=build /usr/src/app/db ./db
COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules

EXPOSE 3000

CMD [ "node", "index.js" ]
