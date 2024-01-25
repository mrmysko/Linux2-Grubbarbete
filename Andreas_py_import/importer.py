import time
import os
import ldap
import ldif

print("Waiting for 10 seconds...")
time.sleep(10)

ldap_server = "ldap://ldap:389"
ldap_bind_dn = "cn=admin,dc=hemlis,dc=com"
ldap_bind_password = "ldap_password"
ldif_file = "/app/users.ldif"


print("Connecting to LDAP server...")
print(f"LDAP Server: {ldap_server}")
print(f"Bind DN: {ldap_bind_dn}")
try:
   ldap_conn = ldap.initialize(ldap_server)
   print("Before binding...")
   ldap_conn.simple_bind_s(ldap_bind_dn,ldap_bind_password)
   print("After binding...")
   print("LDAP connection established")


   ldif_parser = ldif.LDIFRecordList(open(ldif_file))
   ldif_parser.parse()


   for dn, entry in ldif_parser.all_records:
      print(f"LDIF Entry: {dn}")
      print(entry)
      full_dn = dn
      try:
         print(f"Before adding entry: {full_dn}")
         ldap_conn.add_s(full_dn, [(k, v[0]) for k, v in entry.items()])
         print(f"Good imported entry: {full_dn}")
      except ldap.LDAPError as e:
         print(f"Error importing entry {full_dn}: {e}")

   print("LDAP import completed. Unbinding...")
   ldap_conn.unbind_s()
   print("LDAP connection closed.")
   # Robin was here.
   os.remove(ldif_file)
except ldap.SERVER_DOWN as e:
   print(f"LDAP server is down or unreachable: {e}")
except Exception as e:
   import traceback
   traceback.print_exc()
   print(f"An error occurred: {e}")