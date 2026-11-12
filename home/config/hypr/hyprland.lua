-- Hyprland Lua config — translated from the sway config in ../sway.
-- Requires Hyprland 0.55+ (hyprlang was deprecated in favor of Lua).
-- Docs: https://wiki.hypr.land/Configuring/
--
-- File layout mirrors the sway config's `include` structure:
--   variables.lua  -> sway/variables
--   input.lua      -> sway/input
--   output.lua     -> sway/output
--   workspaces.lua -> sway/workspaces
--   windowrules.lua-> sway/windowrules
--   keybinds/*.lua -> sway/keybinds/*

local vars = require("variables")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in     = vars.gap,    -- sway: gaps inner $gap
        gaps_out    = -vars.gap,   -- sway: gaps outer -$gap
        border_size = 0,           -- sway: default_border none

        layout = "dwindle",
    },

    -- Plain look to match sway: no animations, blur, shadow, or rounding.
    decoration = {
        rounding = 0,
        blur     = { enabled = false },
        shadow   = { enabled = false },
    },

    animations = {
        enabled = false,
    },

    -- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
    dwindle = {
        preserve_split = true,
    },

    misc = {
        force_default_wallpaper = 0, -- no anime mascot wallpaper
        disable_hyprland_logo   = true,
    },
})

require("input")
require("output")
require("workspaces")
require("windowrules")
require("keybinds.basics")
require("keybinds.apps")
require("keybinds.layout")

-------------------
---- AUTOSTART ----
-------------------

-- Fires once on compositor start (not on config reload).
hl.on("hyprland.start", function()
    -- noctalia provides the bar (sway: bar { mode invisible } + exec noctalia-shell)
    hl.exec_cmd("noctalia")
    hl.exec_cmd("keyd-application-mapper -d")
    hl.exec_cmd("discord")
    -- NOTE: no wl-paste/xclip bridge here — Hyprland syncs the XWayland
    -- clipboard natively in both directions. The old one-way bridge formed a
    -- feedback loop (Wayland -> xclip -> mirrored back -> repeat) that raced
    -- real copies and left the clipboard empty (broke copying out of Proton
    -- games). If clipboard persistence is ever needed, use wl-clip-persist
    -- or cliphist instead.

    -- systemd integration: export Wayland and X11 env vars so systemd user
    -- services (like clipboard-sync) know which displays to use and can
    -- authenticate. Same intent as the sway config's exec lines.
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DISPLAY XAUTHORITY")
    hl.exec_cmd("systemctl --user set-environment XAUTHORITY=/home/trevor/.Xauthority")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DISPLAY")
end)

-- sway: include /etc/sway/config.d/* — NixOS sway-module drop-ins;
-- not applicable to Hyprland (the NixOS hyprland module wires up the session).
