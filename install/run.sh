#!/bin/bash -xe

# Drone plugin for sparkleformation create/update
#
# Parameters/environment variables:
#  - PLUGIN_STACK_NAME cloudformation stack name
#  - PLUGIN_TEMPLATE   sparkleformation template name
#  - PLUGIN_EXTRA_ARGS sparkleformation extra arguments

# ensure we have mandatory parameters
: ${PLUGIN_STACK_NAME:?}
: ${PLUGIN_TEMPLATE:?}

workingdir=$(pwd)
pushd /root

if ! bundle exec sfn describe ${PLUGIN_STACK_NAME}; then
  bundle exec sfn create ${PLUGIN_STACK_NAME} -d -y -b ${workingdir} -f ${PLUGIN_TEMPLATE} ${PLUGIN_EXTRA_ARGS}
else
  bundle exec sfn update ${PLUGIN_STACK_NAME} -d -y -b ${workingdir} -f ${PLUGIN_TEMPLATE} ${PLUGIN_EXTRA_ARGS}
fi

popd