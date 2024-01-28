#!/bin/bash

#   Behöver man ens restora? tar.gz packas upp i build-processen. Så om man modifierar den till att göra det i entrypoint \
#   Så kan man mounta en folder som läser in en tar.gz vid boot.

tar --same-owner -xf "$DB_NAME"