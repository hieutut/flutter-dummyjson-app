#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f $0))

dart $SCRIPT_DIR/gen_localizations.dart "$SCRIPT_DIR/gen_localizations.config.json"