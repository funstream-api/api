#!/bin/bash
#Выводим протокол, права и ссылку из оглавления README.md в ~README
grep -o '`.*` `.*`' 'README.md' > ~README
#Эскейпим спецсимволы
sed -i -r 's/\//\\\//g' ~README
#Обворачиваем список из ~README в sed для автозамены в оглавлении и выводим в ~tmp.sh
cat ~README | sed -r 's/(.*`(.*)`$)/ sed -i -r \x27s\/(.*-\\s+\\[).*(`\2`)(.*)$\/\\1\1\\3\/g\x27 $1/g' > ~tmp.sh 
#Обворачиваем список из ~README в sed для автозамены в разделах и добавляем в ~tmp.sh
cat ~README | sed -r 's/(.*`(.*)`$)/ sed -i -r \x27s\/(#####.*\2.*)\/#####\[\1\](http:\\\/\\\/funstream.tv\2)\/g\x27 $1/g' >> ~tmp.sh 
#Находим все *.md файлы
mds=()
while IFS=  read -r -d $'\0'; do
    mds+=("$REPLY")
done < <(find . -name '*.md' -print0)
#Выполняем скрипт в ~tmp.sh параллельно для каждого файла
pids=""
for f in "${mds[@]}"; do
   sh ~tmp.sh $f &
   pids="$pids $!"
done
wait $pids
#Удаляем временные файлы
rm ~README ~tmp.sh
