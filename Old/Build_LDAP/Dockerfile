FROM debian:12-slim

ARG DEBIAN_FRONTEND=noninteractive 
RUN apt update && apt install -y -q ldap-utils slapd

# Automatiserad installation av slapd får inget lösenord, så man kan inte logga in på admin-kontot för config.
# Samma sak för dpkg-reconfigure slapd, måste skriva in domän och adminlösen manuellt.

# Broken, slapd får inget config-lösen och jag förstår inte ldap-syntax för att fixa det.
# Överger den här imagen nu.

COPY . .
RUN chmod +x start.sh
ENTRYPOINT [ "/bin/bash", "-c", "./start.sh" ]

EXPOSE 389
EXPOSE 389/udp
EXPOSE 636
EXPOSE 636/udp