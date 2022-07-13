
Let's centralize the secrets & server info and add them to Conjur

```
conjur variable set -i db/host1/host -v "172.17.0.2" && \
conjur variable set -i db/host1/user -v "service01" && \
conjur variable set -i db/host1/pass -v "W/4m=cS6QSZSc*nd" && \
conjur variable set -i db/host2/host -v "172.17.0.3" && \
conjur variable set -i db/host2/user -v "service02" && \
conjur variable set -i db/host2/pass -v "5;LF+J4Rfqds:DZ8"
```{{execute}}
