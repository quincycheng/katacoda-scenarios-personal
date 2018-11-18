

## 1. 安裝Helm和CyberArk charts

Helm是一個單獨的二進製文件，用於管理將圖表部署到Kubernetes。 圖表是kubernetes軟件的打包單元。 它可以從https://github.com/kubernetes/helm/releases下載

`curl -LO https://storage.googleapis.com/kubernetes-helm/helm-v2.8.2-linux-amd64.tar.gz
tar -xvf helm-v2.8.2-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/`{{execute}}

安裝後，初始化更新本地緩存以將最新可用軟件包與環境同步。

`helm init`{{execute}}

追加 CyberArk Helm repo

`helm repo add cyberark https://cyberark.github.io/helm-charts
helm repo update`{{execute}}

## 2. 查看和檢查 CyberArk charts (optional)

查看所有 CyberArk charts

`helm search -r 'cyberark/*'`{{execute}}

安裝 CyberArk chart

`helm inspect cyberark/conjur-oss`{{execute}}

## 3. 使用Helm安裝Conjur

`helm install \
  --set dataKey="$(docker run --rm cyberark/conjur data-key generate)" \
  cyberark/conjur-oss`{{execute}}
  
  