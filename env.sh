#!/bin/bash
## get environment variable for ros

envir=$(env -i bash -c 'source /opt/ros/noetic/setup.sh; env')

new_env=""

for line in ${envir}; do
    new_env=$new_env$line';'
done

#
echo $new_env
