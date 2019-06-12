# SaltDocker-WebUI
SaltStack Docker &amp; Admin Web UI

# What Improved.
* This image is to build saltstack master with docker
  * Included web admin UI (SaltGUI: https://github.com/erwindon/SaltGUI )
  * current version is "2019.2"
* User Authentication is used with Linux-PAM.
  * the user is 'salt'. and default password is 'salt123'. or you can set it with environment value 'SALT_SHARED_SECRET'

# How to USE

```
docker run -d \
  --name salt \
  --hostname salt \
  -p 8000:8000 \
  -p 4505:4505 \
  -p 4506:4506 \
  -v `pwd`/pki:/etc/salt/pki/master \
  -v `pwd`/var:/var/cache/salt \
  -v `pwd`/log:/var/log/salt \
  -e SALT_SHARED_SECRET='supersecret' \
  ziozzang/saltdocker-admin
````

* Volumes to mount
  * /etc/salt/pki/master
  * /var/cache/salt
  * /var/log/salt

# Issues

* In order to make volumes available to the salt user in the container, assign the group id 450 to the directory before it mounting it on the container.


# License
* BSD
