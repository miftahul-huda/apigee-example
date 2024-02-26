# Define base image
FROM python:3.9

# Create work directory
WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl unzip

# Download and install apigeetool
RUN curl -sL https://apigee.enterprise/downloads/apigee-tool/v4.x | bash -s -- -v 4.19.03

# Copy API proxy bundle (replace with your actual path)
COPY my-apiproxy.zip /app/my-apiproxy.zip

# Define environment variables (replace with actual values)
ENV APIGEE_ORG your-organization
ENV APIGEE_ENV your-environment
ENV APIGEE_USERNAME your-username
ENV APIGEE_PASSWORD $(gcloud secrets access latest --project=$PROJECT_ID --secret=apigee_credentials --format=value)

# Deploy the API proxy (replace with proxy name)
CMD ["apigeetool", "deploy", "--name", "my-apiproxy", "--bundle", "/app/my-apiproxy.zip", "--environment", "$APIGEE_ENV"]

# Alternatively, specify deployment command in script
# COPY deploy.sh /app/deploy.sh
# CMD ["sh", "/app/deploy.sh"]