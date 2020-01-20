#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

#
# Defines install clean for osx or linux.
#
# Authors:
#   Luis Mayta <slovacus@gmail.com>
#
CLEAN_PATH_ROOT=$(dirname "${0}":A)

# shellcheck source=/dev/null
source "${CLEAN_PATH_ROOT}"/src/helpers/messages.zsh

# shellcheck source=/dev/null
source "${CLEAN_PATH_ROOT}"/src/helpers/tools.zsh


function cleanup::system::trash {
    message_info "Empty the Trash on all mounted volumes and the main HDD..."
    local volume_trashs="/Volumes/*/.Trashes/*"
    local trashs="${HOME}/.Trash/*"
    [[ -e "${volume_trashs}" ]] && rm -rfv "${volume_trashs}" > /dev/null 2>&1
    [[ -e "${trashs}" ]] && rm -rfv "${trashs}" > /dev/null 2>&1
    message_success "Empty the Trash on all mounted volumes and the main HDD..."
}

function cleanup::system::logs {
    message_info "Clear System Log Files..."
    local mail_logs="${HOME}/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/"
    local core_simulator="${HOME}/Library/Logs/CoreSimulator/*"
    [[ -e "${mail_logs}" ]] && rm -rfv "${mail_logs}" > /dev/null 2>&1
    [[ -e "${core_simulator}" ]] && rm -rfv "${core_simulator}" > /dev/null 2>&1
    message_success "Clear System Log Files..."
}

function cleanup::adobe_cache {
    message_info "Clear Adobe Cache Files..."
    local adobe_cache="${HOME}/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/*"
    [[ -e "${adobe_cache}" ]] && rm -rfv "${adobe_cache}" > /dev/null 2>&1
    message_success "Clear Adobe Cache Files..."
}

function cleanup::ios_application {
    message_info "Cleanup iOS Applications..."
    local itunes_applications="${HOME}/Music/iTunes/iTunes\ Media/Mobile\ Applications/*"
    [[ -e "${itunes_applications}" ]] && rm -rfv "${itunes_applications}" > /dev/null 2>&1
    message_success "Cleanup iOS Applications..."
}

function cleanup::ios_device_backup {
    message_info "Remove iOS Device Backups..."
    local mobile_backup="${HOME}/Library/Application\ Support/MobileSync/Backup/*"
    [[ -e "${mobile_backup}" ]] && rm -rfv "${mobile_backup}" > /dev/null 2>&1
    message_success "Remove iOS Device Backups..."
}

function cleanup::xcode {
    message_info "Cleanup XCode Derived Data and Archives..."
    local xcode_data="${HOME}/Library/Developer/Xcode/DerivedData/*"
    local xcode_archive="${HOME}/Library/Developer/Xcode/Archives/*"
    [[ -e "${xcode_data}" ]] && rm -rfv "${xcode_data}" > /dev/null 2>&1
    [[ -e "${xcode_archive}" ]] && rm -rfv "${xcode_archive}" > /dev/null 2>&1
    message_success "Cleanup XCode Derived Data and Archives..."
}

function cleanup::pip {
    message_info "Cleanup pip cache..."
    local pip_cache="${HOME}/Library/Caches/pip"
    [[ -e "${pip_cache}" ]] && rm -rfv "${pip_cache}" > /dev/null 2>&1
    message_success "Cleanup pip cache..."
}

function cleanup::gem {
    if type gem > /dev/null; then
        message_info "Cleanup any old versions of gems..."
        gem cleanup > /dev/null 2>&1
        message_success "Cleanup any old versions of gems..."
    fi
}

function cleanup::docker {
    if type docker > /dev/null; then
        message_info "Cleanup Docker..."
        docker system prune -af
        message_success "Cleanup Docker..."
    fi
}

function cleanup::pre_commit {
    [ -e "${HOME}/.cache/pre-commit" ] && export PRE_COMMIT_PATH="${HOME}/.cache/pre-commit"
    if [ -n "${PRE_COMMIT_PATH}" ]; then
        message_info "Removing pre_commit ..."
        rm -rfv "${PRE_COMMIT_PATH}" > /dev/null 2>&1
        message_success "Removing pre_commit..."
    fi
}

function cleanup::pyenv {
    if [ "${PYENV_VIRTUALENV_CACHE_PATH}" ]; then
        message_info "Removing Pyenv-VirtualEnv Cache..."
        [ -e "${PYENV_VIRTUALENV_CACHE_PATH}" ] && rm -rfv "${PYENV_VIRTUALENV_CACHE_PATH}" > /dev/null 2>&1
        message_success "Removing Pyenv-VirtualEnv Cache..."
    fi
}

function cleanup::pyenv::virtualenvs {
    [ -e "${HOME}/.local/share/virtualenvs" ] && export PYENV_VIRTUALENV_PATH="${HOME}/.local/share/virtualenvs"
    if [ -n "${PYENV_VIRTUALENV_PATH}" ]; then
        message_info "Removing pyenv virtualenvs..."
        rm -rfv "${PYENV_VIRTUALENV_PATH}" > /dev/null 2>&1
        message_success "Removing Pyenv-VirtualEnv..."
    fi
}

function cleanup::npm {
    if type npm > /dev/null; then
        message_info "Cleanup npm cache..."
        npm cache clean --force
        message_success "Cleanup npm cache..."
    fi
}

function cleanup::yarn {
    if type yarn > /dev/null; then
        message_info "Cleanup Yarn Cache..."
        yarn cache clean --force
        message_success "Cleanup Yarn Cache..."
    fi
}

function cleanup::brew {
    if type brew > /dev/null; then
        message_info "Homebrew Cache..."
        brew cleanup -s > /dev/null 2>&1
        rm -rfv "$(brew --cache)" > /dev/null 2>&1
        brew tap --repair > /dev/null 2>&1
        message_success "Homebrew Cache..."
    fi
}

function cleanup::unnecesary {
    message_info "Clean files unnecesary"
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
    message_success "Clean files unnecesary"
}

function cleanup {
    message_info "Clean files generated"
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
         -name '.next' -type d -print -exec rm -rf {} + -o \
         -name '.cache' -type d -print -exec rm -rf {} + -o \
         -name 'coverage' -type d -print -exec rm -rf {} +

    message_success "Clean files generated"

    cleanup::unnecesary
}

function cleanup::all {
    message_info "Clean all files"
    cleanup::unnecesary
    cleanup::system::trash
    cleanup::system::logs
    cleanup::adobe_cache
    cleanup::ios_application
    cleanup::ios_device_backup
    cleanup::xcode
    cleanup::pip
    cleanup::gem
    cleanup::docker
    cleanup::pre_commit
    cleanup::pyenv
    cleanup::pyenv::virtualenvs
    cleanup::npm
    cleanup::yarn
    cleanup::brew
    message_success "Finish all files"
}
