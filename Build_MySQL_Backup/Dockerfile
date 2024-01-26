FROM debian:12-slim

RUN apt update && apt install -y --no-install-recommends mysql-client openssl

COPY . .

ENTRYPOINT ["mysql_backup.sh"]