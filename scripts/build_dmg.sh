#!/bin/bash

CONFIG=config.json
OUTPUT=nahpu.dmg
cd installer/
if [ -f $OUTPUT ]; then
    rm $OUTPUT
fi

appdmg $CONFIG $OUTPUT