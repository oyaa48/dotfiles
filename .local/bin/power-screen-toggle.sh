#!/bin/bash

if grep -q "on-line" /proc/acpi/ac_adapter/AC/state 2>/dev/null; then
  # On AC power
  xset s off
  xset -dpms
  xset s noblank
else
  # On battery
  xset s 300 300
  xset +dpms
  xset s blank
fi
