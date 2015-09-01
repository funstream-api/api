#!/bin/bash
grep -o '`.*` `.*`' 'README.md' > ~tmp.sh
sed -i -r 's/\//\\\//g' ~tmp.sh;
sed -i -r 's/`(.*)` `(.*)` `(.*)`/ sed -i -r \x27s\/#####.*\3.*\/#####\[`\1` `\2` `\3`\](http:\\\/\\\/funstream.tv)\/g\x27 $1/g' ~tmp.sh;
find *.md -type f -exec sh ~tmp.sh {} \;
rm ~tmp.sh
