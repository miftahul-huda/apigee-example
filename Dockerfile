# Use a base image with Node.js pre-installed
FROM node:latest

# Create work directory
WORKDIR /app

# Download and install apigeetool
#RUN curl -sL https://apigee.enterprise/downloads/apigee-tool/v4.x | bash -s -- -v 4.19.03

RUN npm init
RUN npm install apigeetool --save

# Copy API proxy bundle (replace with your actual path)
COPY apiproxy.zip /app/apiproxy.zip

# Define environment variables (replace with actual values)
ENV APIGEE_ORG lv-playground-appdev
ENV APIGEE_ENV eval
ENV APIGEE_USERNAME test
ENV APIGEE_PASSWORD rotikeju98

# Deploy the API proxy (replace with proxy name)
#CMD ["apigeetool", "deploy", "--name", "my-apiproxy", "--bundle", "/app/apiproxy.zip", "--environment", "$APIGEE_ENV"]
CMD [ "apigeetool", "deployproxy", "-n", "your-api-proxy-name", "-d", ".", "-u", "your-apigee-username", "-p", "your-apigee-password", "-o", "lv-playground-appdev", "-e", "eval" ]


# Alternatively, specify deployment command in script
# COPY deploy.sh /app/deploy.sh
# CMD ["sh", "/app/deploy.sh"]