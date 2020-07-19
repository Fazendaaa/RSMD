FROM estat/rlang
LABEL author="fazenda"
LABEL project="rsmd"

WORKDIR /usr/src/app

COPY DESCRIPTION . 

RUN [ "apk", "add", "--no-cache", \
    "cyrus-sasl-dev", \
    "libjpeg-turbo-dev", \
    "libx11-dev", \
    "openssl", \
    "tiff-dev" \
]
RUN [ "R", "-e", "remotes::install_local('.')" ]

COPY . .

EXPOSE 80
