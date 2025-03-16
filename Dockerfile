FROM databricksruntime  # Databricks dbfuse base image

# Install R and dependencies
RUN apt-get update && apt-get install -y \
    r-base \
    libgtk2.0-dev \
    libxml2-dev \
    libcairo2-dev \
    xvfb \
    gtk2.0 \
    libatk1.0-dev \
    libpango1.0-dev \
    libgdk-pixbuf2.0-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install RGtk2 and rattle packages
RUN R -e "install.packages('RGtk2', dependencies=TRUE, repos='https://cran.r-project.org')"
RUN R -e "install.packages('rattle', dependencies=TRUE, repos='https://cran.r-project.org')"

# Copy your project files to the image
WORKDIR /usr/src/app
COPY . /usr/src/app

# Set environment variables for R
ENV R_HOME=/usr/lib/R
ENV R_LIBS_USER=/usr/local/lib/R/site-library
