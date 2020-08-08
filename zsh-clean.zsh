#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

#
# Defines install clean for osx or linux.
#
# Authors:
#   Luis Mayta <slovacus@gmail.com>
#

ZSH_CLEAN_PATH=$(dirname "${0}")

# shellcheck source=/dev/null
source "${ZSH_CLEAN_PATH}"/config/main.zsh

# shellcheck source=/dev/null
source "${ZSH_CLEAN_PATH}"/internal/main.zsh

# shellcheck source=/dev/null
source "${ZSH_CLEAN_PATH}"/pkg/main.zsh
