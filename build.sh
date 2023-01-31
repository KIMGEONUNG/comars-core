#!/bin/bash

pushd ./configs >/dev/null
bash ./build.sh
popd >/dev/null

pushd ./scripts >/dev/null
bash ./build.sh
popd >/dev/null

pushd ./vimconfig >/dev/null
bash ./build.sh
popd >/dev/null

pushd ./lazygitconfig >/dev/null
bash ./build.sh
popd >/dev/null

pushd ./docs/ >/dev/null
bash ./build.sh
popd >/dev/null
