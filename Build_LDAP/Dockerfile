FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive 
RUN apt update && apt install -y --no-install-recommends tzdata ldap-utils slapd

COPY start.sh .
RUN chmod +x start.sh
ENTRYPOINT [ "/bin/bash", "-c", "./start.sh" ]

EXPOSE 389
EXPOSE 389/udp
EXPOSE 636
EXPOSE 636/udp