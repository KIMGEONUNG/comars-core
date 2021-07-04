pushd ./configs >/dev/null
bash ./build.sh
popd >/dev/null

pushd ./scripts >/dev/null
bash ./build.sh
popd >/dev/null
