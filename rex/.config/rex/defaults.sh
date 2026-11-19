#!/bin/bash

rex_defaults() { defaults write com.superlogical.rex "$@"; }

rex_defaults RexAppUpdateChannel -string "snapshot"
rex_defaults SUAutomaticallyUpdate -bool true
rex_defaults SUEnableAutomaticChecks -bool true

rex_defaults rex.agents.names-sessions -bool false
rex_defaults rex.client.remoteControl -bool true
rex_defaults rex.developer-mode-enabled -bool true
rex_defaults rex.server.automatic-restart-enabled -bool true
rex_defaults rex.server.block-plugin-reload-enabled -bool false
rex_defaults rex.server.run-mode -string "bundled"

rex_defaults Workspace.appearance -string "system"
rex_defaults Workspace.appIcon -string "default"
rex_defaults Workspace.interfaceStyle -string "blendTheme"
rex_defaults Workspace.lightThemeID -string "merino-light"
rex_defaults Workspace.darkThemeID -string "merino-dark"
rex_defaults Workspace.lightUsesExtendedThemePalette -bool true
rex_defaults Workspace.shellIconTheme -string "default"

rex_defaults Workspace.terminalFontName -string "MesloLGL Nerd Font Mono"
rex_defaults Workspace.terminalFontPointSize -float 12
rex_defaults Workspace.terminalFontSmoothing -bool true
rex_defaults Workspace.terminalSmoothScrolling -bool true
rex_defaults Workspace.terminalUsesDisplayP3 -bool true
rex_defaults Workspace.terminalUseThemePalette -bool true
rex_defaults Workspace.cursorShadersEnabled -bool false

rex_defaults Workspace.paneDensity -string "compact"
rex_defaults Workspace.showsActivePaneBorder -bool false
rex_defaults Workspace.inactivePaneFadeMode -string "styling"
rex_defaults Workspace.usesPaneGlass -bool true
rex_defaults Workspace.usesStandardInactiveWindowPaneStyles -bool true

rex_defaults Workspace.tabStyle -string "horizontal"
rex_defaults Workspace.tabIconTintMode -string "off"
rex_defaults Workspace.tabsFillAvailableSpace -bool false
rex_defaults Workspace.toolbarBehavior -string "alwaysShow"

rex_defaults Workspace.activityGrouping -string "priority"
rex_defaults Workspace.activityGroupingResetToPriority -bool true
rex_defaults Workspace.floatingTaskbarCorner -string "top-left"
rex_defaults Workspace.notificationPosition -string "bottom-right"
rex_defaults Workspace.showsKeySequenceHints -bool false
rex_defaults Workspace.experiments.usesNewQuickSwitcher -bool true
