
To download and install the provider, execute the following commands.

```
wget https://github.com/cyberark/terraform-provider-conjur/releases/download/v0.6.2/terraform-provider-conjur_0.6.2_linux_amd64.zip && \
unzip terraform-provider-conjur_0.6.2_linux_amd64.zip && \
mkdir -p ~/.terraform.d/plugins/local/cyberark/conjur/0.6.2/linux_amd64 && \
mv terraform-provider-conjur_v0.6.2  ~/.terraform.d/plugins/local/cyberark/conjur/0.6.2/linux_amd64/terraform-provider-conjur
```{{execute}}
