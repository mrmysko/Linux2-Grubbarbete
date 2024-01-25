FROM debian:12-slim

COPY . .

RUN apt-get update && \
   apt-get install -y --no-install-recommends python3 python3-ldap libldap2-dev libsasl2-dev libssl-dev && \
   rm -rf /var/lib/apt/lists/*

CMD ["python3", "importer.py"]