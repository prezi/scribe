#!/bin/bash

set -euo pipefail
buildnumber=$1

remote_dir=/root/deb/thrift-xenial/$buildnumber
ssh root@oam3.us.prezi.private mkdir -p $remote_dir
cd output
for file in *prezi$buildnumber*.deb; do
    echo "Processing $file"
    scp $file root@oam3.us.prezi.private:$remote_dir/
    ssh root@oam3.us.prezi.private deb-s3-wrapper upload -v public -b package-repository-public -p --codename=prezi-xenial --arch=amd64 $remote_dir/$file
done

ssh root@oam3.us.prezi.private s3cmd setacl --acl-public --recursive s3://package-repository-public
