FROM estat/rlang
LABEL author="fazenda"
LABEL project="rsmd"

WORKDIR /usr/src/app

COPY DESCRIPTION .

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
RUN [ "R", "-e", "remotes::install_local('.', upgrade = 'never')" ]

COPY . .

EXPOSE 80
