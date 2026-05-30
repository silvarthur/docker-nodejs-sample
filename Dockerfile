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

# Setup directory and permissions for the non-root 'node' user
RUN chown -R node:node /app

COPY --chown=node:node . .

EXPOSE 3000 5173 9229

# Switch to the non-root user
USER node

CMD ["npm", "run", "dev:docker"]

# ======================================
# Create Production Environement Stage
# ======================================

FROM node:22-alpine3.23 AS production

WORKDIR /app

RUN chown -R node:node /app

COPY --from=prod-dependencies --chown=node:node /app/node_modules ./node_modules
COPY --from=prod-dependencies --chown=node:node /app/package*.json ./
COPY --from=build --chown=node:node /app/dist ./dist

EXPOSE 3000

# Switch to the non-root user
USER node

CMD ["node", "dist/server.js"]
