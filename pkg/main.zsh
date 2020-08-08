#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

function pkg::main::factory {
    # shellcheck source=/dev/null
    source "${ZSH_CLEAN_PATH}"/pkg/base.zsh
    case "${OSTYPE}" in
    darwin*)
        # shellcheck source=/dev/null
        source "${ZSH_CLEAN_PATH}"/pkg/osx.zsh
        ;;
    linux*)
        # shellcheck source=/dev/null
        source "${ZSH_CLEAN_PATH}"/pkg/linux.zsh
      ;;
    esac
    # shellcheck source=/dev/null
    source "${ZSH_CLEAN_PATH}"/pkg/helper.zsh
}

pkg::main::factory
