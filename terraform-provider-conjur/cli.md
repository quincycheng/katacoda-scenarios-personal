
Next, let's connect the database using cli

![image](https://user-images.githubusercontent.com/4685314/180113232-9da138e8-ab35-496f-97ba-34368642759e.png)

Postgres database client has been installed for you. To check the installed version, execute:

```
psql --version
```{{execute}}

We can login now by executing:
```
psql -h host01 -U postgres
```{{execute}}

...wait, we don't have the password!

Guess a few times or press `Ctrl-C` to abort
