FROM python:3.11-slim

# Install PostgreSQL command-line tools
RUN apt-get update && \
    apt-get install -y postgresql-client-15 && \
    pip install --upgrade pip && \
    pip install jupyter

# Set working directory
WORKDIR /app

# Copy requirements.txt file and install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy Jupyter configuration
#COPY jupyter_notebook_config.py /root/.jupyter/

# Copy all other files (including scripts and notebooks)
COPY . .

# Set the default command for the Jupyter container
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
