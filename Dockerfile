FROM estat/rlang AS base
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



FROM estat/rlang AS build

COPY --from=base / /
WORKDIR /usr/src/app

COPY DESCRIPTION .

RUN [ "R", "-e", "remotes::install_local('.', upgrade = 'never')" ]



FROM estat/rlang AS test

COPY --from=build / /
WORKDIR /usr/src/app

COPY R R/
COPY tests tests/
COPY .lintr .

RUN [ "R", "-e", "devtools::document()" ]
RUN [ "R", "-e", "remotes::install_local('.', force = TRUE, upgrade = 'never')" ]

FROM estat/rlang AS run

COPY --from=test / /
WORKDIR /usr/app

COPY inst inst/

EXPOSE 80
