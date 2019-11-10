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

function cleanup::system_trash {
    echo -e "${CLEAR}${LIGHT_GREEN}Empty the Trash on all mounted volumes and the main HDD...${CLEAR}"
    local volume_trashs="/Volumes/*/.Trashes/*"
    local trashs="${HOME}/.Trash/*"
    [[ -e "${volume_trashs}" ]] && rm -rfv "${volume_trashs}" > /dev/null 2>&1
    [[ -e "${trashs}" ]] && rm -rfv "${trashs}" > /dev/null 2>&1
}

function cleanup::system_logs {
    echo -e "${CLEAR}${LIGHT_GREEN}Clear System Log Files...${CLEAR}"
    local mail_logs="${HOME}/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/"
    local core_simulator="${HOME}/Library/Logs/CoreSimulator/*"
    [[ -e "${mail_logs}" ]] && rm -rfv "${mail_logs}" > /dev/null 2>&1
    [[ -e "${core_simulator}" ]] && rm -rfv "${core_simulator}" > /dev/null 2>&1
}

function cleanup::adobe_cache {
    echo -e "${CLEAR}${LIGHT_GREEN}Clear Adobe Cache Files...${CLEAR}"
    local adobe_cache="${HOME}/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/*"
    [[ -e "${adobe_cache}" ]] && rm -rfv "${adobe_cache}" > /dev/null 2>&1
}

function cleanup::ios_application {
    echo -e "${CLEAR}${LIGHT_GREEN}Cleanup iOS Applications...${CLEAR}"
    local itunes_applications="${HOME}/Music/iTunes/iTunes\ Media/Mobile\ Applications/*"
    [[ -e "${itunes_applications}" ]] && rm -rfv "${itunes_applications}" > /dev/null 2>&1
}

function cleanup::ios_device_backup {
    echo -e "${CLEAR}${LIGHT_GREEN}Remove iOS Device Backups...${CLEAR}"
    local mobile_backup="${HOME}/Library/Application\ Support/MobileSync/Backup/*"
    [[ -e "${mobile_backup}" ]] && rm -rfv "${mobile_backup}" > /dev/null 2>&1
}

function cleanup::xcode {
    echo -e "${CLEAR}${LIGHT_GREEN}Cleanup XCode Derived Data and Archives...${CLEAR}"
    local xcode_data="${HOME}/Library/Developer/Xcode/DerivedData/*"
    local xcode_archive="${HOME}/Library/Developer/Xcode/Archives/*"
    [[ -e "${xcode_data}" ]] && rm -rfv "${xcode_data}" > /dev/null 2>&1
    [[ -e "${xcode_archive}" ]] && rm -rfv "${xcode_archive}" > /dev/null 2>&1
}

function cleanup::pip {
    echo -e "${CLEAR}${LIGHT_GREEN}Cleanup pip cache...${CLEAR}"
    local pip_cache="${HOME}/Library/Caches/pip"
    [[ -e "${pip_cache}" ]] && rm -rfv "${pip_cache}" > /dev/null 2>&1
}

function cleanup::gem {
    if type "gem" &> /dev/null; then
        echo -e "${CLEAR}${LIGHT_GREEN}Cleanup any old versions of gems...${CLEAR}"
        gem cleanup > /dev/null 2>&1
    fi
}

function cleanup::docker {
    if type "docker" &> /dev/null; then
        echo -e "${CLEAR}${LIGHT_GREEN}Cleanup Docker...${CLEAR}"
        docker system prune -af
    fi
}

function cleanup::pyenv {
    if [ "$PYENV_VIRTUALENV_CACHE_PATH" ]; then
        echo -e "${CLEAR}${LIGHT_GREEN}Removing Pyenv-VirtualEnv Cache...${CLEAR}"
        [[ -e "${PYENV_VIRTUALENV_CACHE_PATH}" ]] && rm -rfv "${PYENV_VIRTUALENV_CACHE_PATH}" > /dev/null 2>&1
    fi
}

function cleanup::npm {
    if type "npm" &> /dev/null; then
        echo -e "${CLEAR}${LIGHT_GREEN}Cleanup npm cache...${CLEAR}"
        npm cache clean --force
    fi
}

function cleanup::yarn {
    if type "yarn" &> /dev/null; then
        echo -e "${CLEAR}${LIGHT_GREEN}Cleanup Yarn Cache...${CLEAR}"
        yarn cache clean --force
    fi
}

function cleanup::brew {
    if type "brew" &>/dev/null; then
        echo -e "${CLEAR}${LIGHT_GREEN}Homebrew Cache...${CLEAR}"
        brew cleanup -s > /dev/null 2>&1
        rm -rfv "$(brew --cache)" > /dev/null 2>&1
        brew tap --repair > /dev/null 2>&1
    fi
}

function cleanup::unnecesary {
    echo -e "${CLEAR}${LIGHT_GREEN}Clean files unnecesary${CLEAR}"
    find . \
         -name '.DS_Store' -delete -print -o \
         -name '*.pyc' -delete -print -o \
         -name '*.orig' -delete -print -o \
         -name '*.retry' -delete -print -o \
         -name '*.tmp' -delete -print -o \
         -name '*.egg' -delete -print -o \
         -name '.eggs' -type d -print -exec rm -rf {} + -o \
         -name '*.egg-info' -type d -print -exec rm -rf {} + -o \
         -name '.pytest_cache' -type d -print -exec rm -rf {} + -o \
         -name '.hypothesis' -type d -print -exec rm -rf {} + -o \
         -name '.mypy_cache' -type d -print -exec rm -rf {} + -o \
         -name '.hypothesis' -type d -print -exec rm -rf {} + -o \
         -name '.lib-cov' -type d -print -exec rm -rf {} + -o \
         -name '__pycache__' -type d -print -exec rm -rf {} + -o \
         -name 'env.back' -type d -print -exec rm -rf {} + -o \
         -name 'venv.back' -type d -print -exec rm -rf {} + -o \
         -name 'coverage' -type d -print -exec rm -rf {} +
}

function cleanup {
    echo -e "${CLEAR}${LIGHT_GREEN}Clean files generated${CLEAR}"
    find . \
         -name 'node_modules' -type d -print -exec rm -rf {} + -o \
         -name 'jspm_packages' -type d -print -exec rm -rf {} + -o \
         -name 'typings' -type d -print -exec rm -rf {} + -o \
         -name '.npm' -type d -print -exec rm -rf {} + -o \
         -name '.vagrant' -type d -print -exec rm -rf {} + -o \
         -name '.wercker' -type d -print -exec rm -rf {} + -o \
         -name '.eggs' -type d -print -exec rm -rf {} + -o \
         -name 'eggs' -type d -print -exec rm -rf {} + -o \
         -name '*.egg-info' -type d -print -exec rm -rf {} + -o \
         -name '.pytest_cache' -type d -print -exec rm -rf {} + -o \
         -name '.hypothesis' -type d -print -exec rm -rf {} + -o \
         -name 'docs/_build/' -type d -print -exec rm -rf {} + -o \
         -name 'htmlcov' -type d -print -exec rm -rf {} + -o \
         -name '.mypy_cache' -type d -print -exec rm -rf {} + -o \
         -name '.hypothesis' -type d -print -exec rm -rf {} + -o \
         -name 'wheels' -type d -print -exec rm -rf {} + -o \
         -name '.lib-cov' -type d -print -exec rm -rf {} + -o \
         -name 'bower_components' -type d -print -exec rm -rf {} + -o \
         -name '.venv' -type d -print -exec rm -rf {} + -o \
         -name 'env.back' -type d -print -exec rm -rf {} + -o \
         -name 'venv.back' -type d -print -exec rm -rf {} + -o \
         -name '.terraform' -type d -print -exec rm -rf {} + -o \
         -name 'coverage' -type d -print -exec rm -rf {} +

    cleanup::unnecesary
}

function cleanup::all {
    echo -e "${CLEAR}${LIGHT_GREEN}Clean all files${CLEAR}"
    cleanup::unnecesary
    cleanup::system_trash
    cleanup::system_logs
    cleanup::adobe_cache
    cleanup::ios_application
    cleanup::ios_device_backup
    cleanup::xcode
    cleanup::pip
    cleanup::gem
    cleanup::docker
    cleanup::pyenv
    cleanup::npm
    cleanup::yarn
    cleanup::brew
    echo -e "${CLEAR}${LIGHT_GREEN}Finish all files${CLEAR}"
}
