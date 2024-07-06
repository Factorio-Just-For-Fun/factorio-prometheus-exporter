# Use Python 3.8 as base image
FROM python:3.8

# Arguments passed from docker-compose.yml
ARG REPO_URL

# Set the working directory in the container
WORKDIR /app

# Install git and other dependencies
RUN apt-get update && apt-get install -y git

# Clone the repository
RUN git clone ${REPO_URL} .

# Copy the requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt

# Command to run the exporter
CMD ["python", "factorio_prometheus_exporter.py"]
