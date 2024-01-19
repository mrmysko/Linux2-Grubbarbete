FROM debian:12-slim

ARG DEBIAN_FRONTEND=noninteractive 
RUN apt update && apt install -y -q ldap-utils slapd
# Broken, slapd får inget config-lösen och jag förstår inte ldap-syntax för att fixa det.
# Överger den här imagen nu.

COPY . .
RUN chmod +x start.sh
ENTRYPOINT [ "/bin/bash", "-c", "./start.sh" ]

EXPOSE 389
EXPOSE 389/udp
EXPOSE 636
EXPOSE 636/udp