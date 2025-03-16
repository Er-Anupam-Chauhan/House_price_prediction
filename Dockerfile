FROM rocker/r-ver:3.6.3

# Install system dependencies for RGtk2
RUN apt-get update && apt-get install -y \
    libgtk2.0-dev \
    libxml2-dev \
    libcairo2-dev \
    xvfb \
    gtk2.0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install R packages (RGtk2 and rattle)
RUN R -e "install.packages(c('RGtk2', 'rattle'), repos='https://cran.r-project.org')"

# Copy your project files to the image
WORKDIR /usr/src/app
COPY . /usr/src/app

# Set environment variables for R
ENV R_HOME=/usr/lib/R
ENV R_LIBS_USER=/usr/local/lib/R/site-library

# Set the entrypoint to run your R script (e.g., main.R)
CMD ["Rscript", "main.R"]
