-- Basic focus/move/workspace binds (mirrors sway's keybinds/basics).
local vars = require("variables")
local mod  = vars.mod

-- Change focus / move focused window (vim keys + arrow keys)
local dirs = {
    { keys = { vars.left,  "Left"  }, direction = "left"  },
    { keys = { vars.down,  "Down"  }, direction = "down"  },
    { keys = { vars.up,    "Up"    }, direction = "up"    },
    { keys = { vars.right, "Right" }, direction = "right" },
}

for _, d in ipairs(dirs) do
    for _, key in ipairs(d.keys) do
        hl.bind(mod .. " + " .. key,        hl.dsp.focus({ direction = d.direction }))
        hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = d.direction }))
    end
end

-- Workspaces: mod+N to switch, mod+Shift+N to move container
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mod .. " + " .. key,        hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- audio
hl.bind(mod .. " + grave", hl.dsp.exec_cmd("noctalia msg mic-mute"))

-- Autoclick on the mouse back button (sway: bindsym --whole-window button8).
-- X11 button8 = evdev BTN_SIDE = mouse:275. non_consuming passes the click
-- through to the window, like sway's --whole-window does.
hl.bind("mouse:275", hl.dsp.exec_cmd("~/.config/hypr/scripts/autoclick"),      { non_consuming = true })
hl.bind("mouse:275", hl.dsp.exec_cmd("~/.config/hypr/scripts/stop_autoclick"), { non_consuming = true, release = true })

-- ============================================================================
-- PD2 Trader overlay focus / scratchpad
-- ============================================================================

-- Toggle focus to the PD2 Trader overlay
hl.bind(mod .. " + SHIFT + O", hl.dsp.focus({ window = [[title:^PD2Trader$]] }))

-- Return focus to Diablo II (Wine window)
hl.bind(mod .. " + SHIFT + D", hl.dsp.focus({ window = [[class:^game\.exe$]] }))

-- Quick-hide/show overlay via the "pd2overlay" special workspace
-- (hyprland's scratchpad equivalent of sway's `[con_mark=...] scratchpad show`)
hl.bind(mod .. " + SHIFT + P", function()
    hl.dispatch(hl.dsp.window.float({ window = [[title:^PD2Trader$]], action = "enable" }))
    hl.dispatch(hl.dsp.window.move({ window = [[title:^PD2Trader$]], workspace = "special:pd2overlay" }))
    hl.dispatch(hl.dsp.workspace.toggle_special("pd2overlay"))
end)

hl.bind(mod .. " + SHIFT + V", hl.dsp.exec_cmd("wl-paste"))
