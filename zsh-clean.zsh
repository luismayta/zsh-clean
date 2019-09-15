#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

#
# Defines install clean for osx or linux.
#
# Authors:
#   Luis Mayta <slovacus@gmail.com>
#

LIGHT_GREEN='\033[1;32m'
CLEAR='\033[0m'

function cleanup::all {
    echo -e "${CLEAR}${LIGHT_GREEN}Clean files${CLEAR}"
    find . -name '__pycache__' -delete -print -o \
         -name '.DS_Store' -delete -print -o \
         -name '*.pyc' -delete -print -o \
         -name '*.orig' -delete -print -o \
         -name '*.retry' -delete -print -o \
         -name '*.tmp' -delete -print -o \
         -name 'node_modules' -type d -print -exec rm -rf {} + -o \
         -name 'jspm_packages' -type d -print -exec rm -rf {} + -o \
         -name 'typings' -type d -print -exec rm -rf {} + -o \
         -name '.npm' -type d -print -exec rm -rf {} + -o \
         -name '.vagrant' -type d -print -exec rm -rf {} + -o \
         -name '.wercker' -type d -print -exec rm -rf {} + -o \
         -name '.eggs' -type d -print -exec rm -rf {} + -o \
         -name 'eggs' -type d -print -exec rm -rf {} + -o \
         -name 'htmlcov' -type d -print -exec rm -rf {} + -o \
         -name '.mypy_cache' -type d -print -exec rm -rf {} + -o \
         -name '.hypothesis' -type d -print -exec rm -rf {} + -o \
         -name '.lib-cov' -type d -print -exec rm -rf {} + -o \
         -name 'bower_components' -type d -print -exec rm -rf {} + -o \
         -name '__pycache__' -type d -print -exec rm -rf {} + -o \
         -name '.venv' -type d -print -exec rm -rf {} + -o \
         -name 'env.back' -type d -print -exec rm -rf {} + -o \
         -name 'venv.back' -type d -print -exec rm -rf {} + -o \
         -name '.terraform' -type d -print -exec rm -rf {} + -o \
         -name 'coverage' -type d -print -exec rm -rf {} +
}
