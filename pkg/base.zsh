#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

function cleanup::pip {
    message_info "Cleanup pip cache..."
    local pip_cache="${HOME}/Library/Caches/pip"
    [ -e "${pip_cache}" ] && rm -rfv "${pip_cache}" > /dev/null 2>&1
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
    if [ -n "${PYENV_VIRTUALENV_CACHE_PATH}" ]; then
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
         -name 'vendor' -type d -print -exec rm -rf {} + -o \
         -name 'coverage' -type d -print -exec rm -rf {} + -o \
         -name '.external_modules' -type d -print -exec rm -rf {} +
    message_success "Clean files unnecesary"
}

# clean files and path
function cleanup::terraform {
    message_info "Clean files generated"
    find . \
         -name '.terraform' -type d -print -exec rm -rf {} +

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
         -name '.nuxt' -type d -print -exec rm -rf {} + -o \
         -name '.cache' -type d -print -exec rm -rf {} + -o \
         -name '.grunt' -type d -print -exec rm -rf {} + -o \
         -name '.vuepress/dist' -type d -print -exec rm -rf {} + -o \
         -name '.fusebox' -type d -print -exec rm -rf {} + -o \
         -name '.dynamodb' -type d -print -exec rm -rf {} + -o \
         -name 'bower_components' -type d -print -exec rm -rf {} + -o \
         -name 'coverage' -type d -print -exec rm -rf {} +

    message_success "Clean files generated"

    cleanup::unnecesary
}

# clean files and path
function cleanup::projects {
    if [ -z "${PROJECTS}" ]; then
        message_warning "The path PROJECTS is not defined as an environment variable."
        return
    fi
    message_info "Clean files of ${PROJECTS}"
    cd "${ROJECTS}" || return && cleanup || cd - || return

    message_success "Clean files unnecesary"
}
