# Set the base image to Ubuntu
FROM ubuntu

# Add the application resources URL
#RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ $(lsb_release -sc) main universe" >> /etc/apt/sources.list

# Update the sources list
RUN apt-get update

# Install basic applications
#RUN apt-get install -y tar git curl nano wget dialog net-tools build-essential

# Install Python and Basic Python Tools
RUN apt-get install -y python python-dev python-distribute python-pip

RUN mkdir -p /personality-insights-python/public
RUN mkdir -p /personality-insights-python/templates

# Copy the application folder inside the container
ADD public /personality-insights-python/public
ADD templates /personality-insights-python/templates
ADD server.py requirements.txt mobidick.txt /personality-insights-python/
# Get pip to download and install requirements:
RUN pip install -r /personality-insights-python/requirements.txt

# Expose ports
EXPOSE 3000

# Set the default directory where CMD will execute
WORKDIR /personality-insights-python

# Set the default command to execute    
# when creating a new container
# i.e. using CherryPy to serve the application
CMD python server.py
