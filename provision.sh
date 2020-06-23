#!/bin/bash
#
# Provision KSP Modding - using pish.
#
# TODO: Use /usr/local/bin, dependency or $PISH_ROOT environment variable. Default is what?
PISH_ROOT=$HOME/Projects/pish
# PISH_ROOT=/usr/local
PISH_LIB=$PISH_ROOT/lib/pish
PISH=$PISH_ROOT/bin/pish

. $PISH
. $PISH_LIB/basic
. $PISH_LIB/1pass
. $PISH_LIB/sudo
. $PISH_LIB/homebrew

SUDO_ROOT_ITEM="MacBookPro Harvey"

STEAMAPPS="$HOME/Library/Application Support/Steam/steamapps/common"
KSP="$STEAMAPPS/Kerbal Space Program"
MONO_PATHS=/etc/paths.d/mono-commands

# ================================================================================
# Main
#

function converge_defaults()
{
    requirement 1pass_logged_in

    requirement brew_cask_install steam

    # TODO: Use steamcmd or steam.exe to install? Automation only goes so far...
    requirement directory_exists "$KSP"

    requirement brew_install mono
    requirement brew_install ckan
    requirement brew_cask_install ckan

    if [[ -f $MONO_PATHS ]]; then
	export PATH=$PATH:$(cat $MONO_PATHS)
    fi
}

converge "$@"
