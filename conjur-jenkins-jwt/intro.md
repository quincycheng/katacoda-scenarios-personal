
In this tutorial, you will learn how to secure Jenkins pipelines using Conjur JWT authentication & credentials plugins.

Not only the secret used by Jenkins will be protected, we will also elimate secret zero. [Secret zero](https://www.conjur.org/blog/secret-zero-eliminating-the-ultimate-secret/) is when all of your secrets are protected under another secrets, a single master key or ultimate secret that grants access to everything, the keys to the kingdom.

![image](https://user-images.githubusercontent.com/4685314/179661213-5b74a974-aee5-4f99-837f-deb1d92e87af.png)

The sample pipeline will trigger Jenkins to access the target web apps with HTTP authentication.
Three native attributes are picked for granting access to the secret
 - **Only** specific `Freestyle project` can access to the secret
 - Freestyle project name **must** be `Secure_Freestyle_Project`
 - The project **must** be located under folder named `Demo`



