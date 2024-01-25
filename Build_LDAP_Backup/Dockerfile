FROM debian:12-slim

RUN apt update && apt install -y ldap-utils

COPY . .

ENTRYPOINT ["backup_ldap.sh"]