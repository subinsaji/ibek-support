#!/bin/bash
##########################################################################
##### install script for busy support module  ############################
##########################################################################

# ARGUMENTS:
#  $1 VERSION to install (must match repo tag)
VERSION=${1}
NAME=busy
FOLDER=$(dirname $(readlink -f $0))

# log output and abort on failure
set -xe

# get the source and fix up the configure/RELEASE files
ibek support git-clone ${NAME} ${VERSION}
ibek support register ${NAME}

# stop compilation of tests which require autosave
# (unless autosave is already installed)
ibek support add-release-macro AUTOSAVE --no-replace

# declare the libs and DBDs that are required in ioc/iocApp/src/Makefile
ibek support add-libs busy
ibek support add-dbds busySupport.dbd

# compile the support module
ibek support compile ${NAME}
# prepare *.bob, *.pvi, *.ibek.support.yaml for access outside the container.
ibek support generate-links ${FOLDER}



