#!/bin/bash
set -e
echo "Creating Lambda hello..."
echo ">>> init.bash STARTED" >> /tmp/init.log

cd /workspace

make create-hello