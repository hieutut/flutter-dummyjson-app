#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f $0))

dart $SCRIPT_DIR/gen_assets.dart "$SCRIPT_DIR/gen_assets.config.json"