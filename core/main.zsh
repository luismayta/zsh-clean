#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

function plugin-template::core::main::factory {
    # shellcheck source=/dev/null
    source "${ZSH_CLEAN_PATH}"/core/base.zsh
    case "${OSTYPE}" in
    darwin*)
        # shellcheck source=/dev/null
        source "${ZSH_CLEAN_PATH}"/core/osx.zsh
        ;;
    linux*)
        # shellcheck source=/dev/null
        source "${ZSH_CLEAN_PATH}"/core/linux.zsh
      ;;
    esac
}

plugin-template::core::main::factory