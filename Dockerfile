FROM redhat/ubi8

# Install Python 3 and pip
RUN yum install python3 -y

# Install Flask and pytest
RUN pip3 install flask 

# Set working directory
WORKDIR /code

# Copy application and test files
COPY app.py app.py
#COPY test_app.py test_app.py

# Default command to run the application
ENTRYPOINT ["python3", "app.py"]

