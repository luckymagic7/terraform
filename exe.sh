#!/usr/bin/env bash

# terraform apply
#terraform plan -out=tfplan

# build go binary
cd source
go build main.go

# terraform apply
cd -
terraform apply
