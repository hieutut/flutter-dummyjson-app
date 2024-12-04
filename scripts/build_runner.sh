#!/bin/bash

BASE_DIR="$PWD"
MODULES_DIR="$BASE_DIR/modules"

function module_pub_get() {
    module_dir_path="$1"
    MODULES=($(find ${module_dir_path} -maxdepth 1 -type d))
    echo "module_dir_path: ${module_dir_path}"
    echo "module_dir_path MODULES: ${MODULES}"
    for module in "${MODULES[@]}"
    do
        if [ ${module} != ${module_dir_path} ]
        then
            echo "[START] Run build_runner for module: $(basename $module)"
            cd ${module} && dart run build_runner build --delete-conflicting-outputs
            echo "[DONE] Run build_runner for module: $(basename $module)"
            echo ""
        fi
    done
    cd "$BASE_DIR"
}

module_pub_get ${MODULES_DIR}

echo "[START] Run build_runner for: $(basename $BASE_DIR)"
dart run build_runner build --delete-conflicting-outputs
echo "[DONE] Run build_runner for: $(basename $BASE_DIR)"
echo ""

echo "Build Runner Done !!!"