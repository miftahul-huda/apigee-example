# Define base image
FROM python:3.9

# Create work directory
WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl unzip

# Download and install apigeetool
#RUN curl -sL https://apigee.enterprise/downloads/apigee-tool/v4.x | bash -s -- -v 4.19.03

RUN npm install -g apigeetool

# Copy API proxy bundle (replace with your actual path)
COPY apiproxy.zip /app/apiproxy.zip

# Define environment variables (replace with actual values)
ENV APIGEE_ORG lv-playground-appdev
ENV APIGEE_ENV eval
ENV APIGEE_USERNAME test
ENV APIGEE_PASSWORD rotikeju98

# Deploy the API proxy (replace with proxy name)
CMD ["apigeetool", "deploy", "--name", "my-apiproxy", "--bundle", "/app/apiproxy.zip", "--environment", "$APIGEE_ENV"]

# Alternatively, specify deployment command in script
# COPY deploy.sh /app/deploy.sh
# CMD ["sh", "/app/deploy.sh"]