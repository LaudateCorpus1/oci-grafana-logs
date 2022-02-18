#!/bin/bash

#Do grunt work

if [[ ! -d ./node_modules ]]; then
  echo "dependencies not installed try running: npm install"
  exit 1
fi

./node_modules/.bin/grunt

# build go

POST=''
GOOS=''

OS="`uname`"
case $OS in
  'Linux')
      POST='_linux_amd64'
      GOOS="linux"
    ;;
  'Darwin')
      POST='_darwin_amd64'
      GOOS="darwin"
    ;;
  'AIX') ;;
  *) ;;
esac

go mod vendor

if [[ ! -d ./vendor ]]; then
  echo "dependencies not installed try running | go mod vendor didn't work as expected"
  exit 1
fi

echo "building go binary"
#GOOS=$GOOS go build -o ./dist/oci-plugin$POST

# For debugger
 GOOS=$GOOS go build -o ./dist/oci-logs-plugin$POST -gcflags="all=-N -l"

# For release
 GOOS=linux go build -o ./dist/oci-logs-plugin_linux_amd64
# GOOS=windows GOARCH=amd64 go build -o ./dist/oci-plugin_windows_amd64.exe
# tar cvf plugin.tar ./dist

