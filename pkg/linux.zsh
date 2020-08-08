#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

function cleanup::system::trash {
    message_warning "${CLEAN_MESSAGE_NOT_IMPLEMENTED}"
}

function cleanup::system::logs {
    message_warning "${CLEAN_MESSAGE_NOT_IMPLEMENTED}"
}

function cleanup::all {
    message_info "Clean all files"
    cleanup::unnecesary
    cleanup::yarn
    cleanup::brew
    cleanup::system::trash
    cleanup::system::logs
    cleanup::pip
    cleanup::gem
    cleanup::docker
    cleanup::pre_commit
    cleanup::pyenv
    cleanup::pyenv::virtualenvs
    cleanup::npm
    cleanup::terraform
    cleanup::projects
    message_success "Finish all files"
}
