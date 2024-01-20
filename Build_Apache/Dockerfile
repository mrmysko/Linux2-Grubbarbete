FROM debian:12-slim

ARG DEBIAN_FRONTEND=noninteractive 
RUN apt update && apt install -y apache2 php php-mysql libapache2-mod-php php-ldap php-xml ldap-account-manager ca-certificates curl file

COPY . .

ENV DOMAIN=hemlis.com
RUN chmod +x wordpress.sh
RUN ./wordpress.sh

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
ENTRYPOINT [ "/bin/bash", "-c", "./entrypoint.sh" ]

EXPOSE 80/tcp
EXPOSE 443/tcp