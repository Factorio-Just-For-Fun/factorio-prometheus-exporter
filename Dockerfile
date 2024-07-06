# Use Python 3.8 as base image
FROM python:3.8

# Arguments passed from docker-compose.yml
ARG REPO_URL

# Set the working directory in the container
WORKDIR /app

# Ensure /app directory exists and set permissions
RUN mkdir -p /app && chown -R root:root /app

# Install git (if not already installed)
RUN apt-get update && apt-get install -y git

# Clone the repository
RUN git clone ${REPO_URL} .

# Copy the requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt

# Copy entrypoint script into container
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Command to run the exporter
CMD ["python", "factorio_prometheus_exporter.py"]
