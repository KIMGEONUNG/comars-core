#!/bin/bash


scripts=`find . -type f | grep -v build.sh`

targetPath="${HOME}/bin"
system=`uname`

if [[ -z $(echo $PATH | grep -o ${targetPath}:) ]]; then
    PATH=$PATH:${targetPath}:
fi

if [ $system == "Linux" ]  
then
    chmod +x ./*
fi

if [[ ! -d "$targetPath" ]]
then
    mkdir ~/bin -v 
fi

echo \# Build script programs 
for script in $scripts
do
    build_loc=${targetPath}/${script#*/}
    ln -s $(pwd)/${script#*/} ${build_loc} -f -v
done
