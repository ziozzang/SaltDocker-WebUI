FROM ubuntu:18.04

CMD ["/saltinit"]
ADD saltinit.sh /saltinit
EXPOSE 4505 4506 8000
VOLUME /etc/salt/pki/

# Add User for PAM auth.
RUN useradd salt && echo "salt:salt123" | chpasswd
RUN DEBIAN_FRONTEND=noninteractive apt update && \
    apt-get install -y tzdata curl wget gnupg unzip vim ssh net-tools
#    ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
#    dpkg-reconfigure --frontend noninteractive tzdata

RUN curl -L https://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add - && \
    echo "deb http://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest bionic main" > \
      /etc/apt/sources.list.d/saltstack.list && \
    apt update && apt install -fy salt-master salt-api && \
    apt install -fy python3-timelib python3-pygit2 python3-cffi python3-ioflo python3-pycryptodome \
      python3-raet python3-mysqldb python3-mako python3-docker python3-progressbar

RUN chmod +x /saltinit && \
    cd /opt && \
    curl -L https://github.com/erwindon/SaltGUI/archive/master.zip > master.zip && \
    unzip master.zip && \
    rm -f master.zip
