#!/usr/bin/env bash

if [ $# = 0 ]; then
    echo "no arguments!"
    echo "Usage: exe.sh plan | apply | destroy"
fi

case "$1" in
  "plan")
      terraform plan
    ;;
  "apply")
      cd source
      go build main.go
      cd -
      terraform apply
    ;;
  "destroy")
      terraform destroy
    ;;
esac
