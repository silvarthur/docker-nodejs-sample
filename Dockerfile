# ===========
# Base Stage
# ===========
FROM node:22-alpine3.23 AS base

WORKDIR /app

# Create a non-root user for security?

# =======================================
# Install Development Dependencies Stage
# =======================================

FROM base AS dev-dependencies

COPY package*.json ./

RUN npm install

# ======================================
# Install Production Dependencies Stage
# ======================================

FROM base AS prod-dependencies

COPY package*.json ./

RUN npm install --omit=dev

# ========================
# Build Application Stage 
# ========================

FROM dev-dependencies AS build

COPY . .

RUN npm run build

# ======================================
# Create Development Environement Stage
# ======================================
FROM dev-dependencies AS development

COPY . .

EXPOSE 3000 5173 9229

CMD ["npm", "run", "dev:docker"]

# ======================================
# Create Production Environement Stage
# ======================================

FROM node:22-alpine3.23 AS production

WORKDIR /app

COPY --from=prod-dependencies /app/node_modules ./node_modules
COPY --from=prod-dependencies /app/package*.json ./
COPY --from=build /app/dist ./dist

EXPOSE 3000

CMD ["node", "dist/server.js"]
