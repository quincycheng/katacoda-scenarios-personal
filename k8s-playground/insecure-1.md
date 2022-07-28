
## System Changes

### /etc/docker/daemon.json
adding `"insecure-registries":[ "controlplane:5000" ]`
```
cat /etc/docker/daemon.json
```{{execute}}

### /etc/docker/daemon.json
add last 3 lines

```
[[registry]]
location="controlplane:5000"
insecure=true
```

```
cat /etc/containers/registries.conf
```{{execute}}

### /etc/containerd/config.toml
add line 142-147
```
        [plugins."io.containerd.grpc.v1.cri".registry.mirrors."controlplane:5000"]
          endpoint = ["http://controlplane:5000"]
      
      [plugins."io.containerd.grpc.v1.cri".registry.configs]
        [plugins."io.containerd.grpc.v1.cri".registry.configs."controlplane:5000".tls]
          insecure_skip_verify = true
```

```
cat /etc/containerd/config.toml
```{{execute}}

## App

We have prepared a sample application

To view the source code of the main logic, execute:
```
cat apps/original-app/src/main.go 
```{{execute}}

To build the application, execute:

```
podman build -t original-app:latest  apps/original-app/src
podman tag original-app:latest controlplane:5000/original-app:latest
podman push controlplane:5000/original-app:latest
```{{execute}}

To deploy, execute:
```
kubectl apply -f apps/original-app/k8s/deployment.yml
```{{execute}}

Now the application has been installed.

```
kubectl get pods -n demo -w
```{{execute}}

Let's wait for it to get started.

Wait for `original-app` to have `Running` status.
Press `Ctrl-C` to stop

## Troubleshooting Local Registry
```
export POD_NAME=$(k get pods -n demo -l "app=original-app" -o jsonpath="{.items[0].metadata.name}")
k describe pod/$POD_NAME -n demo
 ```{{execute}}
