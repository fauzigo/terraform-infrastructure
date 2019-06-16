#!/bin/bash

sudo apt-get update
sudo apt-get install -yq build-essential python-pip rsync jq python-pip openvpn git
pip install yq
git -C /home/${user} clone https://github.com/fauzigo/easyOpenVPN.git
