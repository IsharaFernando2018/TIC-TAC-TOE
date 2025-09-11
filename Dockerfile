# # Use the official Node.js 16 image
# FROM node:16

# # Set the working directory in the container
# WORKDIR /app

# # Copy package.json and package-lock.json
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy the entire React app source code to the container
# COPY . .

# # Build the React app
# RUN npm run build

# # Expose port 3000 (the port your Node.js app runs on)
# EXPOSE 3000

# # Start the Node.js app
# CMD ["npm", "start"]


# Stage 1: Build the React app
FROM node:16 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Serve with nginx
FROM nginx:alpine

# Copy the build output to nginx's default public folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]

