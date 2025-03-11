# Use an official Python runtime as a base image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy only requirements.txt first to leverage Docker caching
COPY requirements.txt /app/requirements.txt

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Now copy the rest of the application files
COPY . /app

# Expose the required port (Cloud Run will set this automatically)
EXPOSE $PORT

# Start the application using Gunicorn
CMD gunicorn --workers=4 --bind 0.0.0.0:$PORT app:app
