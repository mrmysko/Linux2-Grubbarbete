FROM debian:12-slim

ARG DEBIAN_FRONTEND=noninteractive 
RUN apt update && apt install -y ldap-utils slapd

COPY . .
RUN chmod +x start.sh
ENTRYPOINT [ "/bin/bash", "-c", "./start.sh" ]

EXPOSE 389
EXPOSE 389/udp
EXPOSE 636
EXPOSE 636/udp