FROM ubuntu:22.04

COPY wordpress.tar.gz .
COPY wp-cli.phar .

ARG DEBIAN_FRONTEND=noninteractive 
RUN apt update && apt install -y --no-install-recommends tzdata apache2 php php-mysql libapache2-mod-php php-ldap php-xml ldap-account-manager ca-certificates curl

ARG SITENAME=wordpress
COPY wordpress.sh .
RUN chmod +x wordpress.sh
RUN ./wordpress.sh

COPY start.sh .
RUN chmod +x start.sh
ENTRYPOINT [ "/bin/bash", "-c", "./start.sh" ]

EXPOSE 80/tcp