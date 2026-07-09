local wezterm = require "wezterm"
local config = wezterm.config_builder()
local action = wezterm.action
 
config.font = wezterm.font {
  family = 'JetBrains Mono',
  weight = 'Medium',
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, -- disable ligatures
}
config.font_size = 10.5
config.line_height = 1.0

local function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Catppuccin Macchiato"
  else
    return "Catppuccin Latte"
  end
end
 
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

config.window_padding = { left = '0.5cell', right = '0.5cell', top = '0.5cell', bottom = '0.5cell' }

config.window_decorations = 'RESIZE|INTEGRATED_BUTTONS'
config.window_background_opacity = 0.96
config.macos_window_background_blur = 20

config.window_close_confirmation = 'NeverPrompt'

config.keys = {
  {
    key = 'c',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ''
      if has_selection then
        window:perform_action(action.CopyTo 'ClipboardAndPrimarySelection', pane)
        window:perform_action(action.ClearSelection, pane)
      else
        window:perform_action(action.SendKey { key = 'c', mods = 'CTRL' }, pane)
      end
    end),
  },
}
 
return config
