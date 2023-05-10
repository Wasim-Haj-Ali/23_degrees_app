FROM node:18

# Setting the working directory
WORKDIR /app

# Copying the application in the container
COPY . .

# Installing the dependencies
RUN yarn install

# Building the application
RUN yarn build

# Starting the application
CMD ["npm", "run", "serve:ssr"]

