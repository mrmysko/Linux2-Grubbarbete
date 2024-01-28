FROM debian:12-slim

ARG DEBIAN_FRONTEND=noninteractive 
RUN apt update && apt install -y --no-install-recommends \
    apache2 php php-mysql libapache2-mod-php php-ldap php-xml ldap-account-manager curl file openssl phpldapadmin

COPY . .
ADD https://wordpress.org/latest.tar.gz .

RUN chmod +x entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]

EXPOSE 80/tcp
EXPOSE 443/tcp