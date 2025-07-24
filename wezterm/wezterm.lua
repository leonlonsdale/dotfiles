local wezterm = require('wezterm')

local config = wezterm.config_builder()

local act = wezterm.action

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)

-- leader

config.leader = {
  key = 'Space',
  mods = 'ALT',
  timeout_milliseconds = 1000,
}


-- fonts

config.font = wezterm.font("Jetbrains Mono")
config.font_size = 17
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
  left = 5,
  right = 5,
  top = 5,
  bottom = 5
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

  { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
  
  -- LEADER + right to create new pane to the right
  {
    key = "RightArrow",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
  },

  -- LEADER + down to create new pane below
  {
    key = "DownArrow",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
  },

  -- LEADER + x to close current pane
  {
    key = "x",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },

  -- LEADER + z to zoom pane
  {
    key = "z",
    mods = "CTRL|SHIFT",
    action = wezterm.action.TogglePaneZoomState,
  },

  -- Rotate panes clockwise
  {
    mods = "CTRL|SHIFT",
    key = "Space",
    action = wezterm.action.RotatePanes("Clockwise"),
  },

  -- Swap current with selected pane
  {
    mods = "CTRL|SHIFT",
    key = "s",
    action = wezterm.action.PaneSelect {
      mode = "SwapWithActive",
    },
  },

  -- Switch to workspace or create if does not exist
  -- Prompt for name
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            act.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },
   -- Show the launcher in fuzzy selection mode and have it list all workspaces
  -- and allow activating one.
  {
    key = 's',
    mods = 'CTRL|SHIFT',
    action = act.ShowLauncherArgs {
      flags = 'FUZZY|WORKSPACES',
    },
  },
  -- {
  --     key = 'y',
  --     mods = 'CTRL|SHIFT',
  --     action = wezterm.action_callback(function(window, pane)
  --       local workspace_names = wezterm.mux.get_workspace_names()
  --       table.sort(workspace_names, function(a, b)
  --         -- case-insensitive sort
  --         return a:lower() < b:lower()
  --       end)
  --       local launcher_items = {}

  --       for _, name in ipairs(workspace_names) do
  --         table.insert(launcher_items, {
  --           label = '💼 ' .. name,
  --           id = 'switch:' .. name,
  --         })
  --       end
  --       -- table.sort(launcher_items)

  --       -- Add the create new workspace option
  --       table.insert(launcher_items, {
  --         label = '✏️ Create New Workspace...',
  --         id = 'create_new',
  --       })

  --       window:perform_action(
  --         act.InputSelector {
  --           title = 'Workspace Switcher',
  --           choices = launcher_items,
  --           action = wezterm.action_callback(function(inner_window, inner_pane, id)
  --             if not id then return end
  --             if id == 'create_new' then
  --               inner_window:perform_action(
  --                 act.PromptInputLine {
  --                   -- description = 'Enter name for new workspace',
  --                    description = wezterm.format {
  --                     { Attribute = { Intensity = 'Bold' } },
  --                     { Foreground = { AnsiColor = 'Fuchsia' } },
  --                     { Text = 'Enter name for new workspace' },
  --                   },

  --                   action = wezterm.action_callback(function(w, p, line)
  --                     if line and line ~= '' then
  --                       w:perform_action(act.SwitchToWorkspace { name = line }, p)
  --                     end
  --                   end),
  --                 },
  --                 inner_pane
  --               )
  --             else
  --               -- strip "switch:" prefix and switch to workspace
  --               local name = id:gsub("^switch:", "")
  --               inner_window:perform_action(act.SwitchToWorkspace { name = name }, inner_pane)
  --             end
  --           end),
  --         },
  --         pane
  --       )
  --     end),
  --   },
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
