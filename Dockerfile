FROM r-base:4.3.2

MAINTAINER Andrew Kane <andrew@ankane.org>

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
  libxml2-dev libssl-dev libcurl4-openssl-dev libsodium-dev libssh2-1-dev

RUN mkdir -p /app
WORKDIR /app

COPY init.R DESCRIPTION renv.lock ./
RUN Rscript init.R

COPY . .

# Ensure all necessary R packages are installed
RUN Rscript -e "install.packages(c('stringi', 'anytime', 'padr', 'plumber', 'forecast'), repos='https://cloud.r-project.org/')"

CMD Rscript server.R

