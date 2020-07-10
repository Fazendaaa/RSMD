FROM estat/rlang
LABEL author="fazenda"
LABEL project="rsmd"

WORKDIR /usr/src/app

COPY DESCRIPTION DESCRIPTION 

RUN [ "apk", "add", "--no-cache", "openssl", "cyrus-sasl-dev" ]
RUN [ "R", "-e", "remotes::install_local('.')" ]

COPY . .

EXPOSE 80

ENTRYPOINT [ "R", "-e", "shiny::runApp('.', host = '0.0.0.0', port = 80)" ]
