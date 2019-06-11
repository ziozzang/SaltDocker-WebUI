FROM saltstack/salt:2019.2

ADD saltinit.py /usr/local/bin/saltinit

RUN chmod +x /usr/local/bin/saltinit && \
  apk update && apk add linux-pam curl git py3-pygit2 && \
  cd /opt && curl -L https://github.com/erwindon/SaltGUI/archive/master.zip | busybox unzip -

