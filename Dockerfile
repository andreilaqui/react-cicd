# # Use Node 20 Alpine as the base image
# FROM node:20-alpine

# # Set the working directory in the container
# WORKDIR /app

# # Copy package.json and package-lock.json to the working directory FIRST
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy the rest of the application code to the working directory AFTER installing dependencies to leverage Docker caching
# COPY . .

# # Vite uses port 5173 by default, so we expose that port
# EXPOSE 5173

# # Start the development server with the --host flag to allow access from outside the container
# CMD ["npm", "run", "dev", "--", "--host"]


FROM nginx:1.27-alpine
COPY dist /usr/share/nginx/html