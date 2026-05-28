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

# ======================================
# Create Development Environement Stage
# ======================================
FROM dev-dependencies AS development

COPY . .

EXPOSE 3000 5173 9230

CMD ["npm", "run", "dev:docker"]