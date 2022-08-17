FROM estat/rlang
LABEL author="fazenda"
LABEL project="rsmd"

RUN [ "apk", "add", "--no-cache", \
  "cyrus-sasl-dev", \
  "fontconfig-dev", \
  "libjpeg-turbo-dev", \
  "libx11-dev", \
  "libgit2-dev", \
  "harfbuzz-dev", \
  "fribidi-dev", \
  "openssl", \
  "tiff-dev" \
]

COPY DESCRIPTION .
COPY renv.lock .

RUN [ "R", "-e", "renv::restore(prompt = FALSE)" ]

COPY .lintr .
COPY inst inst/
COPY tests tests/
COPY R R/

EXPOSE 80
