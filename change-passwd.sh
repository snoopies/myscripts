#!/bin/bash

if [[ -z "$USER_PASS" ]]; then
  echo "Please set 'USER_PASS' for user: $USER"
  exit 3
fi
echo "### Update user: $USER password ###"
echo $USER_PASS
echo $USER
echo -e "$USER_PASS\n$USER_PASS" | sudo passwd "$USER"
