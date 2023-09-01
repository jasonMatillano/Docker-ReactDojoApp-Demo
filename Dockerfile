# STAGE 1: Build the React app
FROM node:14-alpine AS build
WORKDIR /app

# Copy package.json and package-lock.json to working directory . (app)
COPY package*.json .

# Install dependencies in the working directory . (app)
RUN npm install

# Copy the rest of the application code to working directory . (app)
COPY . .

# Build the React app
RUN npm run build

# STAGE 2: Serve the app using a lightweight server
FROM nginx:alpine

# Copy built files from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80

# Start the nginx server
CMD ["nginx", "-g", "daemon off;"]
