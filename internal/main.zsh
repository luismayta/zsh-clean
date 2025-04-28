#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

function clean::internal::main::factory {
    # shellcheck source=/dev/null
    source "${ZSH_CLEAN_PATH}"/internal/base.zsh
    case "${OSTYPE}" in
    darwin*)
        # shellcheck source=/dev/null
        source "${ZSH_CLEAN_PATH}"/internal/osx.zsh
        ;;
    linux*)
        # shellcheck source=/dev/null
        source "${ZSH_CLEAN_PATH}"/internal/linux.zsh
      ;;
    esac
    # shellcheck source=/dev/null
    source "${ZSH_CLEAN_PATH}"/internal/helper.zsh
}

clean::internal::main::factory
