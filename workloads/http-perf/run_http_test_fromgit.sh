#!/usr/bin/env bash


source common.sh

for rt in ${ROUTE_TYPES}; do
  create_apps ${rt}
done
