#!/bin/bash
set -e
NODE_VERSION=0.10.43
NODE_ARCH=x64

NODE_DIST=node-v${NODE_VERSION}-linux-${NODE_ARCH}

cd /tmp
curl -O -L http://nodejs.org/dist/v${NODE_VERSION}/${NODE_DIST}.tar.gz
tar xvzf ${NODE_DIST}.tar.gz
rm -rf /opt/nodejs
mv ${NODE_DIST} /opt/nodejs

ln -sf /opt/nodejs/bin/node /opt/app-root/bin/node

/opt/nodejs/bin/npm install npm -g
ln -sf /opt/nodejs/bin/npm /opt/app-root/bin/npm