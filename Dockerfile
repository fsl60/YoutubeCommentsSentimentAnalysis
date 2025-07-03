# Use a lightweight Python image
FROM python:3.11-slim

# Install system dependencies (important!)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 \
    gcc \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy all files into the container
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 5000 for the Flask app
EXPOSE 5000

# Run the Flask app using gunicorn (Render's recommended way)
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:5000"]
