#!/bin/sh

loadfile="prova.mos"


echo "loadModel(Modelica);" > ${loadfile}
echo "getErrorString();" >> ${loadfile}
echo " " >> ${loadfile}

for file in *.mo; do
    echo "loadFile(\"${file}\");" >> ${loadfile}
    echo "getErrorString();" >> ${loadfile}
    echo " " >> ${loadfile} 
done


