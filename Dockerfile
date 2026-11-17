# -------- Build Stage --------
FROM node:26.13.0-alpine AS build
WORKDIR /app
COPY . .
RUN npm install -g yarn
RUN yarn install
RUN yarn run build

# ----------------------------------------------------------------
FROM node:26.13.0-alpine
WORKDIR /app
RUN npm install -g http-server
COPY --from=build /app/dist ./dist
ENTRYPOINT ["http-server", "dist"]
