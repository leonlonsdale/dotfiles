local wezterm = require('wezterm')

local config = wezterm.config_builder()

-- leader

config.leader = {
  key = 'Space',
  mods = 'ALT',
  timeout_milliseconds = 1000,
}


-- fonts

config.font = wezterm.font("Jetbrains Mono")
config.font_size = 19
config.line_height = 1.2

-- appearance

config.color_scheme = 'Tokyo Night Storm'
config.colors = {
  background = '#1b1d1e'
}

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

config.window_decorations = 'RESIZE'
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0
}
config.window_background_opacity = 0.8
config.macos_window_background_blur = 40

config.inactive_pane_hsb = {
  saturation = 0.3,
  brightness = 0.3,
  hue = 1.0,
}


-- misc

config.max_fps = 120
config.prefer_egl = true

-- keys

config.keys = {
  -- LEADER + right to create new pane to the right
  {
    key = "RightArrow",
    mods = "LEADER",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
  },

  -- LEADER + down to create new pane below
  {
    key = "DownArrow",
    mods = "LEADER",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
  },

  -- LEADER + x to close current pane
  {
    key = "x",
    mods = "LEADER",
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },

  -- LEADER + z to zoom pane
  {
    key = "z",
    mods = "LEADER",
    action = wezterm.action.TogglePaneZoomState,
  },

  -- Rotate panes clockwise
  {
    mods = "LEADER",
    key = "Space",
    action = wezterm.action.RotatePanes("Clockwise"),
  },

  -- Swap current with selected pane
  {
    mods = "LEADER",
    key = "0",
    action = wezterm.action.PaneSelect {
      mode = "SwapWithActive",
    },
  },
}

-- Shared directions table
local directions = {
  { key = "LeftArrow",  direction = "Left" },
  { key = "RightArrow", direction = "Right" },
  { key = "UpArrow",    direction = "Up" },
  { key = "DownArrow",  direction = "Down" },
}

-- ALT + Arrow to navigate between panes
for _, entry in ipairs(directions) do
  table.insert(config.keys, {
    key = entry.key,
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection(entry.direction),
  })
end

-- ALT + SHIFT + Arrow to resize panes
for _, entry in ipairs(directions) do
  table.insert(config.keys, {
    key = entry.key,
    mods = "ALT|SHIFT",
    action = wezterm.action_callback(function(win, pane)
      win:perform_action({ AdjustPaneSize = { entry.direction, 3 } }, pane)
    end),
  })
end
return config
