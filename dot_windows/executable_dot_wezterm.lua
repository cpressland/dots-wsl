local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()
config.color_scheme = "Catppuccin Mocha"
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = false
config.font = wezterm.font('CaskaydiaCove Nerd Font')
config.font_size = 14


config.keys = {
    {
	key = "k",
	mods = "CMD",
	action = act.ClearScrollback 'ScrollbackAndViewport',
    },
}

wezterm.plugin.require("https://github.com/nekowinston/wezterm-bar").apply_to_config(config, {
  position = "bottom",
  max_width = 32,
  dividers = "slant_right", -- or "slant_left", "arrows", "rounded", false
  indicator = {
    leader = {
      enabled = true,
      off = " ",
      on = " ",
    },
    mode = {
      enabled = true,
      names = {
        resize_mode = "RESIZE",
        copy_mode = "VISUAL",
        search_mode = "SEARCH",
      },
    },
  },
  tabs = {
    numerals = "arabic", -- or "roman"
    pane_count = "superscript", -- or "subscript", false
    brackets = {
      active = { "", ":" },
      inactive = { "", ":" },
    },
  },
  clock = { -- note that this overrides the whole set_right_status
    enabled = true,
    format = "%H:%M", -- use https://wezfurlong.org/wezterm/config/lua/wezterm.time/Time/format.html
  },
})


if wezterm.target_triple == 'aarch64-apple-darwin' then
  config.default_prog = {'/opt/homebrew/bin/fish', '-l'}
end

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.wsl_domains = {
    {
      name = 'WSL:FedoraLinux-42',
      distribution = 'FedoraLinux-42',
      default_cwd = "/home/cpressland",
    },
  }
  config.default_domain = 'WSL:FedoraLinux-42'
end

return config
