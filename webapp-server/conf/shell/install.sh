#!/bin/bash

SERVER_ROOT=/vagrant/webapp-server
CONF_ROOT=${SERVER_ROOT}/conf
SRC_ROOT=${SERVER_ROOT}/src

LAST_INSTALLED_VERSION_FILE=~/.vagrant_provision_version
PROVISIONS_DIR=${CONF_ROOT}/shell/provision
FILES_DIR=${CONF_ROOT}/files

. ${CONF_ROOT}/shell/include/msg.sh
. ${CONF_ROOT}/shell/conf.sh


LAST_INSTALLED_VERSION=0
LAST_AVAILABLE_VERSION=`ls ${PROVISIONS_DIR}/*.sh | wc -l`


block_info "Provisioning the box..."

#
# Detect the last provision installed
#
if [ -f ${LAST_INSTALLED_VERSION_FILE} ]; then
	LAST_INSTALLED_VERSION=`cat ${LAST_INSTALLED_VERSION_FILE}`
    msg_ok "Lst version installed was $LAST_INSTALLED_VERSION"
else
	echo ${LAST_INSTALLED_VERSION} > ${LAST_INSTALLED_VERSION_FILE}
	msg_ok "First time provisions is run"
fi


#
# Execute the remaining provisions
#
CURRENT_VERSION=${LAST_INSTALLED_VERSION}

if [ "$CURRENT_VERSION" -eq "$LAST_AVAILABLE_VERSION" ]
then
	block_ok "Box already up-to-date, nothing to do. "
	exit 0
fi

while (( CURRENT_VERSION < LAST_AVAILABLE_VERSION ))
do
	(( CURRENT_VERSION++ ))


	LABEL="[Provision $CURRENT_VERSION of $LAST_AVAILABLE_VERSION]"

	CURRENT_SCRIPT=${PROVISIONS_DIR}/${CURRENT_VERSION}.sh
	if [ -f ${CURRENT_SCRIPT} ]; then
        block_info "Provision $CURRENT_VERSION / $LAST_AVAILABLE_VERSION"
		. ${CURRENT_SCRIPT}
		msg_ok "$LABEL - Version $CURRENT_VERSION installed. "
		echo ${CURRENT_VERSION} > ${LAST_INSTALLED_VERSION_FILE}
	else
		msg_fail "$LABEL - File $CURRENT_SCRIPT doesn't exists. "
		block_fail "$LABEL - Provisioning cancelled. "
		exit 1
	fi

done

block_ok "Provisioning finished."
exit 0