FROM ubuntu:18.04

RUN mkdir /home/karl
RUN useradd --home-dir /home/karl -s /bin/bash karl
RUN usermod -aG sudo karl
RUN chown -R karl:karl /home/karl
RUN apt-get update && apt-get -y install sudo
RUN sed -i '/%sudo/ s/.*/%sudo ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
USER karl

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

WORKDIR /home/karl
COPY --chown=karl:karl . ./

CMD ["./bootstrap-ansible.sh", "test"]
