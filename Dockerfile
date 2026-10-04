FROM rhub/r-minimal
LABEL author="fazenda"
LABEL project="rsmd"

WORKDIR /usr/src/

RUN [ "apk", "add", "--no-cache", \
  "cmake", \
  "gcc", \
  "g++", \
  "make", \
  "curl-dev", \
  "openssl-dev", \
  "cyrus-sasl-dev", \
  "fontconfig-dev", \
  "fftw-dev", \
  "libjpeg-turbo-dev", \
  "libx11-dev", \
  "libgit2-dev", \
  "libuv-dev", \
  "harfbuzz-dev", \
  "fribidi-dev", \
  "zlib-dev", \
  "icu-dev", \
  "tiff-dev" \
]

ENV RENV_CONFIG_PAK_ENABLED=true
ARG GITHUB_PAT

COPY DESCRIPTION .
COPY renv.lock .

RUN [ "R", \
  "-e", "install.packages(c('renv', 'pak'), repos = 'https://cloud.r-project.org')", \
  "-e", "renv::restore(prompt = FALSE)" \
]

COPY .lintr .
COPY inst inst/
COPY man man/
COPY tests tests/
COPY R R/

RUN [ "R", "-e", "devtools::document('.')" ]
RUN [ "R", "-e", "renv::install('.')" ]

EXPOSE 80

ENTRYPOINT ["R", "-e", "shiny::runApp('inst/app.R', host = '0.0.0.0', port = 80)"]
