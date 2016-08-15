Build Trusty .deb packages: `thrift`, `thrift-fb303`, `scribe`

1. `./list-versions.sh` to list the currently existing build numbers
1. `./build.sh $buildnumber` where buildnumber is an increasing number, increment it with each package built, manually, based on the output of `list-versions.sh`
2. Get coffee
3. You have your debs in the dir `output`
4. `./publish $buildnumber`
5. Your Trusty packages are published.
