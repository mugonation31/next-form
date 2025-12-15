# Use offical Python slim image
FROM python:3.12-slim

# Set working directory 
WORKDIR /app

# Copy requirements first (for Docker layer caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose port
EXPOSE 8001

# Run application 
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8001"]