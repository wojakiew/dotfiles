#!/bin/bash

VALUE=$1
for display in $(ddcutil detect | grep "Display" | awk '{print $2}'); do
  ddcutil setvcp 10 $VALUE --display $display
done

