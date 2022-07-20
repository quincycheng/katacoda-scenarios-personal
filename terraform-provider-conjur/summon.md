

### Install Summon
Installing `summon` is simple.  Simply install 2 files and summon is ready to go.

```
curl -sSL https://raw.githubusercontent.com/cyberark/summon/main/install.sh | bash
curl -sSL https://raw.githubusercontent.com/cyberark/summon-conjur/main/install.sh | bash
```{{execute}}

### Postgres Client
Postgres database client has been installed for you. 
To check the installed version, execute:
```
psql --version
```{{execute}}

### Review secrets.yml
To inject the password to Postgres client using Summon, `secrets.yml` file is needed.   

To review, execute `cat secrets.yml`{{execute}}

`PGPASSWORD: !var postgres/admin-password`

### Client Application Identity

We can configure the client application identity using environment variables

```
export CONJUR_AUTHN_LOGIN="host/postgres/client-01"
export CONJUR_AUTHN_API_KEY=$(grep api_key postgres.out | cut -d: -f2 | tr -d ' \r\n' | xargs)
export CONJUR_APPLIANCE_URL=https://proxy:8443
export CONJUR_ACCOUNT=default
export CONJUR_SSL_CERTIFICATE="$(openssl s_client -showcerts -connect proxy:8443 < /dev/null 2> /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p')"
```{{execute}}

### Connect to Postgres DB using Summon

As we have exposed TCP port 5432 from postgres database, we can connect to it to by:

```
summon psql -h host01 -U postgres
```{{execute}}

You should have logged in using the postgres database client without knowing the password! Cool!
