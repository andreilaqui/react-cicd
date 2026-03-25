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

FROM jenkins/jenkins:lts

USER root

RUN apt-get update && \
    apt-get install -y nodejs npm ca-certificates curl gnupg && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER jenkins