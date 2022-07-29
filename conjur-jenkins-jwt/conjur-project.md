
1. To create a new project, go to `Demo` & click ["New Item"]({{TRAFFIC_HOST1_8081}}/job/Demo/newJob)

   - Enter an item name: `Secure_Freestyle_Project`{{copy}}
   - Type: `Freestyle Project`

2. Click OK

3. Let's auto-populate the secrets. Under `Conjur Appliance`, click `Refresh Credential Store`.   The result text `Refresh` should be shown on the left.

4.  Under `Build Environment`, check `Use secret text(s) or files(s)`

5. Under `Bindings`, click `Add` > `Conjur Secret Credentials` to add the newly auto-populate secret `ConjurSecret:jenkins-app/web_password`

   - Variable : `WEB_PASSWORD`{{copy}}
   - Credentials > Specific credentials: `ConjurSecret:jenkins-app/web_password (CyberArk Conjur Provided)`


5. Click `Build` tab at the top

6. Click `Add build step` and select `Execute shell`
   Copy and paste the following command to access the web application:

   `curl -Is -u theServerAccount:$WEB_PASSWORD http://http-authn-server`{{copy}}

7. Click `Save`.   In case an error is shown, don't worry, it's due to `Folder` plugin issue and can be ignored.   

8. Let's verify the setup by clicking ["Build Now"]({{TRAFFIC_HOST1_8081}}/job/Demo/job/Secure_Freestyle_Project/build?delay=0sec)

9. Like what we did earlier, click on the new build number under `build` & choose `Console Output` on the left menu

10. `Response Code: HTTP/1.0 200 OK` & `Finished: SUCCESS` should be shown in the page.
   Meaning that Jenkins has successfully connect to the target web app with authnication successfully.

11. Now you have a freestyle project with secrets secured by CyberArk Conjur with JWT Authentication! 🎉🎉🎉
