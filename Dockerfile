FROM ubuntu:latest

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes git-core gitk git-gui curl lvm2 thin-provisioning-tools \
     python-pkg-resources python-virtualenv python-oauth2client gnupg

# something about debconf: delaying package configuration, since apt-utils is not installed
# also --force-yes is deprecated


RUN adduser --home /home/chromiumos --shell /bin/bash chromiumos --disabled-password --gecos ""
RUN mkdir -p /home/chromiumos/chromiumos/
RUN chown -R chromiumos /home/chromiumos/
RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
RUN cp -r depot_tools/ /home/chromiumos/depot_tools/
ENV PATH="${PATH}:/home/chromiumos/depot_tools"
WORKDIR /home/chromiumos
RUN repo init -u https://chromium.googlesource.com/chromiumos/manifest.git --repo-url https://chromium.googlesource.com/external/repo.git

RUN repo sync


