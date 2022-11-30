D:\SngnFlutter\eclass\eclass App>keytool -genkey -v -keystore learnacadmy.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias learnacadm
y
Enter keystore password:
Re-enter new password:
What is your first and last name?
  [Unknown]:  F
What is the name of your organizational unit?
  [Unknown]:  F
What is the name of your organization?
  [Unknown]:  F
What is the name of your City or Locality?
  [Unknown]:  F
What is the name of your State or Province?
  [Unknown]:  F
What is the two-letter country code for this unit?
  [Unknown]:  F
Is CN=F, OU=F, O=F, L=F, ST=F, C=F correct?
  [no]:  y

Generating 2,048 bit RSA key pair and self-signed certificate (SHA256withRSA) with a validity of 10,000 days
        for: CN=F, OU=F, O=F, L=F, ST=F, C=F
Enter key password for <learnacadmy>
        (RETURN if same as keystore password):
Re-enter new password:
[Storing learnacadmy.jks]

Warning:
The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -
srckeystore learnacadmy.jks -destkeystore learnacadmy.jks -deststoretype pkcs12".

D:\SngnFlutter\eclass\eclass App>
