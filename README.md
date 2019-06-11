# SaltDocker-WebUI
SaltStack Docker &amp; Admin Web UI

# What Improved.
* This image is extend version of https://github.com/saltstack/saltdocker
  * Included web admin UI (SaltGUI: https://github.com/erwindon/SaltGUI )
* This Docker image can be used to set up master server of saltstack
* User Authentication is used with Linux-PAM.
  * the user is 'salt'. and default password is 'supersecret'. or you can set it with environment value 'SALT_SHARED_SECRET'

# How to USE

```
docker run -d \
  --name salt \
  --hostname salt \
  -p 8000:8000 \
  -p 4505:4505 \
  -p 4506:4506 \
  -e SALT_SHARED_SECRET='SALT_PASSWORD_HERE' \
  --name= ziozzang/saltdocker-admin

````

# Issues

* In order to make volumes available to the salt user in the container, assign the group id 450 to the directory before it mounting it on the container.


# License
* BSD? nothing to declare. feel free to use.
