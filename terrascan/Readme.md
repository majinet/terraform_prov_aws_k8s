# Installation

- curl -L "$(curl -s https://api.github.com/repos/tenable/terrascan/releases/latest | grep -o -E "https://.+?_Linux_x86_64.tar.gz")" > terrascan.tar.gz
- tar -xf terrascan.tar.gz terrascan && rm terrascan.tar.gz
- install terrascan /usr/local/bin && rm terrascan
- terrascan
