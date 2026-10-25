-- Layout/session binds (mirrors sway's keybinds/layout).
local vars = require("variables")
local mod  = vars.mod

-- Exit hyprland. sway used swaynag for confirmation; hyprshutdown closes
-- apps gracefully instead. Falls back to a hard exit if unavailable.
hl.bind(mod .. " + SHIFT + E",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- sway: splith / splitv — dwindle has no manual split direction (it splits
-- automatically based on window geometry). pseudo/togglesplit are the
-- closest tools:
hl.bind(mod .. " + B", hl.dsp.window.pseudo())       -- sway: splith
hl.bind(mod .. " + V", hl.dsp.layout("togglesplit")) -- sway: splitv (dwindle only)

-- sway: layout tabbed — hyprland's window groups are like i3/sway's tabbed
-- containers. Cycle grouped windows with hl.dsp.group.next()/prev().
hl.bind(mod .. " + W", hl.dsp.group.toggle())

-- sway: layout stacking — approximated by hyprland's monocle layout.
-- NOTE: general:layout is global, not per-workspace like sway layouts.
local monocle = false
hl.bind(mod .. " + S", function()
    monocle = not monocle
    hl.exec_cmd("hyprctl keyword general:layout " .. (monocle and "monocle" or "dwindle"))
end)

hl.bind(mod .. " + E", hl.dsp.layout("togglesplit")) -- sway: layout toggle split (dwindle only)

-- Make the current focus fullscreen
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())

-- Toggle the current focus between tiling and floating mode
hl.bind(mod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))

-- sway: focus mode_toggle — no hyprland equivalent (no tiled/floating focus
-- modes). Closest is cycling floating windows:
-- hl.bind(mod .. " + space", hl.dsp.window.cycle_next({ floating = true }))

-- sway: focus parent — no hyprland equivalent (hyprland has no container tree).

-- Move the currently focused window to the scratchpad (unnamed special workspace)
hl.bind(mod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "special" }))

-- Show the scratchpad / hide it again
hl.bind(mod .. " + minus", hl.dsp.workspace.toggle_special(""))
