#!/bin/bash

# SUMMARY: Locate git scripts into executable directory 

gitScripts=`find . -type f | grep \\./git-`
targetPath="${HOME}/bin/"
system=`uname`

if [ $system == "Linux" ]  
then
    chmod +x git*
fi

if [[ ! -d "~/bin" ]]
then
    mkdir ~/bin -v 
fi

echo TARGET_PATH: $targetPath
for scriptPath in $gitScripts
do
    scriptName=`echo $scriptPath | sed 's:.*\(git-[a-zA-Z]\+\)$:\1:'`
    echo SCRIPT_NAME: $scriptName
    rm ${targetPath}${scriptName} 2>/dev/null
    ln -s $(pwd)/${scriptName} ${targetPath}${scriptName}
    echo BUILD_LOCATION: ${targetPath}${scriptName}
done
