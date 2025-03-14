FROM python:3.8.3-slim-buster

LABEL "maintainer"="Aleksandr Medvedev <alexandr.mdr@gmail.com>"
LABEL "original-author"="Scott Ng <thuongnht@gmail.com>"
LABEL "repository"="https://github.com/Lexty/ssh-scp-ssh-pipelines"
LABEL "version"="v1.2.0"

LABEL "com.github.actions.name"="ssh-scp-ssh-pipelines"
LABEL "com.github.actions.description"="Pipeline: ssh -> scp(upload) -> scp(download) -> ssh"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="gray-dark"

RUN apt-get update -y && \
  apt-get install -y ca-certificates openssh-client openssl sshpass

COPY requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt

RUN mkdir -p /opt/tools

COPY entrypoint.sh /opt/tools/entrypoint.sh
RUN chmod +x /opt/tools/entrypoint.sh

COPY app.py /opt/tools/app.py
RUN chmod +x /opt/tools/app.py

ENTRYPOINT ["/opt/tools/entrypoint.sh"]