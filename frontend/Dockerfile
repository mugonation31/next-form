# ==================================
# Stage 1: Build Angular Application
# ==================================
FROM node:20-alpine AS Build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies 
RUN npm ci

# Copy source code
COPY . .

# Build for production 
RUN npm run build -- --configuration production 

# ==================================
# Stage 2: Serve with Nginx
# ==================================
FROM nginx:alpine

# Copy built app from previous stage
COPY --from=build /app/dist/frontend/browser /usr/shre/nginx/html

# Copy custom Nginx confirguration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 
EXPOSE 80

# Enginx start automatically