
TODO   

## Target Resource

Let's setup a database for the application

```
kubectl apply -f target/k8s/deployment.yaml
```{{execute}}


## App

We have prepared a sample application where it will connect to the target system via HTTP and verify the response status.

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
kubectl get pods -n testapp -w
```{{execute}}

Let's wait for it to get started.
```
master $ kubectl get pods -n testapp -w
NAME                                READY   STATUS    RESTARTS   AGE
testapp-db-6b6958ccf6-tmzlq         0/1     Pending   0          10s
testapp-insecure-846bdf65db-dbwsj   0/1     Pending   0          10s
testapp-insecure-846bdf65db-dbwsj   0/1     Pending   0          17s
testapp-db-6b6958ccf6-tmzlq         0/1     Pending   0          17s
testapp-insecure-846bdf65db-dbwsj   0/1     Pending   0          28s
testapp-db-6b6958ccf6-tmzlq         0/1     Pending   0          28s
testapp-insecure-846bdf65db-dbwsj   0/1     ContainerCreating   0          28s
testapp-db-6b6958ccf6-tmzlq         0/1     ContainerCreating   0          28s
testapp-db-6b6958ccf6-tmzlq         1/1     Running             0          62s
testapp-insecure-846bdf65db-dbwsj   1/1     Running             0          71s
```

Wait for both `testapp-db` & `testapp-app`to have `Running` status.
Press `Ctrl-C` to stop
