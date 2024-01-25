FROM python:3.8

COPY . .

RUN apt-get update && \
   apt-get install -y libldap2-dev libsasl2-dev libssl-dev && \
   rm -rf /var/lib/apt/lists/*

RUN pip3 install python-ldap

#RUN pip install --no-cache-dir -r requirements.txt
CMD ["python", "importer.py"]