

### Install Summon
Installing `summon` is simple.  Simply install 2 files and summon is ready to go.

```
curl -sSL https://raw.githubusercontent.com/cyberark/summon/main/install.sh | bash
curl -sSL https://raw.githubusercontent.com/cyberark/summon-conjur/main/install.sh | bash
```{{execute}}

### Install Postgres Client

```
apt-get -y -f install postgresql-client
```{{execute}}


### Review secrets.yml
To inject the password to Postgres client using Summon, `secrets.yml` file is needed.   

To review, execute `cat secrets.yml`{{execute}}

`PGPASSWORD: !var postgres/admin-password`

### Connect to Postgres DB using Summon

As we have exposed TCP port 5432 from postgres database, we can connect to it to by:

```
summon psql -h host01 -U postgres
```{{execute}}

You should have logged in using the postgres database client without knowing the password! Cool!
