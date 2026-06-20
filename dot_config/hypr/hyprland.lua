-- Hyprland Lua configuration, ported from the existing Sway setup.
-- Reference: https://wiki.hypr.land/Configuring/Start/
--
-- IMPORTANT: Hyprland detects the config type (Lua vs legacy .conf) only at
-- startup.  If you previously had a hyprland.conf, you MUST log out and log
-- back in (or kill and restart Hyprland) for this Lua file to be picked up.
-- `hyprctl reload` alone is NOT sufficient.

-- -----------------------------------------------------------------------------
-- Variables
-- -----------------------------------------------------------------------------
local mainMod   = "SUPER"
local term      = "wezterm"
local launcher  = "qs -c noctalia-shell ipc call launcher toggle"
local gap       = 5

-- -----------------------------------------------------------------------------
-- Monitors
-- -----------------------------------------------------------------------------
-- DP-3 = BenQ GW2480 (max 60 Hz)
hl.monitor({
    output   = "DP-3",
    mode     = "1920x1080@60",
    position = "0x0",
    scale    = 1,
})

-- DP-2 = ZOWIE XL (144 Hz capable)
hl.monitor({
    output   = "DP-2",
    mode     = "1920x1080@144",
    position = "1920x0",
    scale    = 1,
})

-- -----------------------------------------------------------------------------
-- Input
-- -----------------------------------------------------------------------------
hl.config({
    input = {
        kb_layout      = "us",
        follow_mouse   = 1,
        accel_profile  = "flat",
        sensitivity    = 0.5,
    },
})

-- -----------------------------------------------------------------------------
-- General / Layout
-- -----------------------------------------------------------------------------
hl.config({
    general = {
        gaps_in     = gap,
        gaps_out    = -gap,
        border_size = 0,
        layout      = "dwindle",
    },
})

hl.config({
    dwindle = {
        preserve_split = true,
    },
})

-- -----------------------------------------------------------------------------
-- XWayland
-- -----------------------------------------------------------------------------
hl.config({
    xwayland = {
        enabled = true,
    },
})

-- -----------------------------------------------------------------------------
-- Startup applications
-- -----------------------------------------------------------------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("qs -c noctalia-shell")
    hl.exec_cmd("keyd-application-mapper -d")
    hl.exec_cmd("sh -c 'sleep 3 && easyeffects'")
    hl.exec_cmd("vesktop")
end)

-- -----------------------------------------------------------------------------
-- Workspace rules
-- -----------------------------------------------------------------------------
hl.workspace_rule({ workspace = "1",  monitor = "DP-3", persistent = true })
hl.workspace_rule({ workspace = "2",  monitor = "DP-2", persistent = true })
hl.workspace_rule({ workspace = "3",  monitor = "DP-3", persistent = true })
hl.workspace_rule({ workspace = "4",  monitor = "DP-2", persistent = true })
hl.workspace_rule({ workspace = "5",  monitor = "DP-3", persistent = true })
hl.workspace_rule({ workspace = "6",  monitor = "DP-2", persistent = true })
hl.workspace_rule({ workspace = "7",  monitor = "DP-3", persistent = true })
hl.workspace_rule({ workspace = "8",  monitor = "DP-2", persistent = true })
hl.workspace_rule({ workspace = "9",  monitor = "DP-3", persistent = true })
hl.workspace_rule({ workspace = "10", monitor = "DP-2", persistent = true })

-- -----------------------------------------------------------------------------
-- Key bindings
-- -----------------------------------------------------------------------------

-- --- Applications ---
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(term))
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + Tab",    hl.dsp.exec_cmd(launcher))
hl.bind("F12",                   hl.dsp.exec_cmd("grimblast copy area"))

-- --- Focus ---
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- --- Move ---
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- --- Workspaces ---
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- --- Audio ---
hl.bind(mainMod .. " + grave", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call volume muteInput"))

-- --- Fullscreen / Floating ---
hl.bind(mainMod .. " + F",        hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))

-- --- Layout ---
hl.bind(mainMod .. " + W", hl.dsp.layout("togglegroup"))

-- --- Session ---
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprctl reload"))

-- --- PD2 / Game specific ---
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.focus({ window = "title:^PD2Trader$" }))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.focus({ window = "title:Diablo II" }))
hl.bind("CTRL + ALT + D", hl.dsp.exec_cmd("/home/trevor/.local/bin/pathoftrading"))

-- Exiled Exchange 2: pass through keybinds so the overlay can use them.
hl.bind("CTRL + d",       hl.dsp.pass({ window = "class:exiled-exchange-2" }))
hl.bind("ALT + e",        hl.dsp.pass({ window = "class:exiled-exchange-2" }))
hl.bind("SHIFT + Space",  hl.dsp.pass({ window = "class:exiled-exchange-2" }))



-- --- Mouse binds ---
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- --- Autoclick binds ---
hl.bind("mouse:275", hl.dsp.exec_cmd("/home/trevor/.config/hypr/scripts/autoclick"), { mouse = true })
hl.bind("mouse:275", hl.dsp.exec_cmd("/home/trevor/.config/hypr/scripts/stop_autoclick"), { mouse = true, release = true })

-- -----------------------------------------------------------------------------
-- Window rules
-- -----------------------------------------------------------------------------

-- Path of Exile 2
hl.window_rule({
    name  = "poe2-tile",
    match = { class = "^(pathofexile2steam\\.exe|steam_app_2694490)$" },
    float = false,
})

-- Diablo II (Project Diablo 2)
hl.window_rule({
    name  = "d2-pd2-maximize",
    match = { title = "^Diablo II$" },
    fullscreen = 1,
})

-- Exiled Exchange 2 (POE2 trade overlay)
-- Match by class; force floating, opaque, focused, and on top.
-- Locked to workspace 8 alongside Steam apps.
hl.window_rule({
    name  = "exiled-exchange-2",
    match = { class = "exiled-exchange-2" },
    workspace = "8",
    float = true,
    border_size = 0,
    no_blur = true,
    no_shadow = true,
    opaque = true,
    focus_on_activate = true,
})

-- Steam apps: lock to workspace 8
hl.window_rule({
    name  = "steam-apps",
    match = { class = "^(steam_app_.*)$" },
    workspace = "8",
})
