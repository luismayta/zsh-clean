#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

function rsync::install {
    if ! type -p brew > /dev/null; then
        message_warning "${CLEAN_MESSAGE_BREW}"
        return
    fi
    message_info "Installing rsync for ${CLEAN_PACKAGE_NAME}"
    brew install rsync
    message_success "Installed rsync ${CLEAN_PACKAGE_NAME}"
}
