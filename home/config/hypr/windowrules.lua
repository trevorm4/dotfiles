-- Window rules, translated from sway's `windowrules` file.
-- Note: in Hyprland `class` matches both the X11 class and the Wayland
-- app_id, so sway's `[app_id=...]` rules below also use `class`.
-- Rules are evaluated top to bottom; the last match wins.

-- Useful defaults from the upstream example config:

-- Ignore maximize requests from all apps.
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland.
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Path Of Exile 1 & 2
hl.window_rule({
    match = {
        class   = [[^(pathofexilesteam\.exe|steam_app_238960|steam_app_2694490)$]],
        content = "game",
    },
    tile        = true, -- sway: floating disable
    border_size = 0,    -- sway: border none
})

-- Torchlight: Infinite
hl.window_rule({
    match = { class = [[^steam_app_1974050$]] },
    tile            = true,
    border_size     = 0,
    -- Locks the mouse cursor to the window (the rule that had no sway
    -- equivalent; see the sway config's comment). Hyprland also honors
    -- client pointer-constraint requests by default, so Proton's
    -- ClipCursor() works either way.
    confine_pointer = true,
})

-- Awakened PoE Trade
hl.window_rule({
    match = { class = [[^(awakened-poe-trade|Awakened-poe-trade)$]] },
    float       = true,
    border_size = 0,
    no_blur     = true,
    no_shadow   = true,
})

-- Exiled Exchange 2
hl.window_rule({
    match = { class = [[^exiled-exchange-2$]] },
    float             = true,
    border_size       = 0,
    no_focus          = true,      -- sway: no_focus
    focus_on_activate = false,     -- sway: urgent disable
    workspace         = "8 silent", -- sway: assign workspace number 8
    no_blur           = true,
    no_shadow         = true,
    opaque            = true,
})

-- Diablo II (Project Diablo 2)
hl.window_rule({
    match      = { class = [[^game\.exe$]] },
    fullscreen = true, -- sway: floating disable, fullscreen enable
})

-- ============================================================================
-- PD2 Trader
-- ============================================================================
-- Hyprland has no marks; dynamic tags are the rough equivalent
-- (visible via `hyprctl clients`, matchable via `match.tag`).

-- PD2 Trader windows (Wayland app_id + XWayland class fallbacks)
hl.window_rule({
    match = { class = [[^com\.pd2-trader\.app$]] },
    float             = true,
    border_size       = 0,
    no_focus          = true,  -- sway: no_focus
    focus_on_activate = false, -- sway: urgent disable
    tag               = "+pd2trader",
})

hl.window_rule({
    match = { class = [[^(Pd2-trader-installer|pd2-trader-installer|pd2-trader)$]] },
    float             = true,
    border_size       = 0,
    no_focus          = true,
    focus_on_activate = false,
    tag               = "+pd2trader",
})

-- Main overlay ("PD2Trader") — the app keeps this window hidden on Linux.
-- Do NOT float, resize, or reposition it; the tag keeps it findable.
hl.window_rule({
    match    = { title = [[^PD2Trader$]] },
    no_focus = true,
    tag      = "+pd2overlay",
})

-- All other PD2Trader windows (popups, toasts, buttons, etc.) float automatically.
hl.window_rule({
    match = { title = [[^PD2Trader:.*]] },
    float       = true,
    border_size = 0,
    no_focus    = true,
    tag         = "+pd2trader",
})

-- Interactive app windows (sign-in, settings, etc.) are titled "PD2 Trader - ..."
-- (with spaces), unlike the click-through overlays ("PD2Trader..."). The class
-- rules above set no_focus, which makes these windows unclickable; since the last
-- matching rule wins, this re-enables focus for them.
hl.window_rule({
    match = {
        class = [[^Pd2-trader-installer$]],
        title = [[^PD2 Trader - ]],
    },
    no_focus          = false,
    focus_on_activate = true,
})

-- Workspace assignments (sway: assign ...). "silent" = don't switch to it.
hl.window_rule({ match = { class = [[^NoiseTorch$]] },   workspace = "9 silent" })
hl.window_rule({ match = { class = [[^vesktop$]] },      workspace = "3 silent" })
hl.window_rule({ match = { class = [[^steam$]] },        workspace = "6 silent" })
hl.window_rule({ match = { class = [[^steam_app_.*$]] }, workspace = "8 silent" })

-- sway: mouse_warping container
-- Hyprland already warps the cursor when focus changes via keybinds
-- (cursor:no_warps defaults to false); also warp on workspace switches.
hl.config({
    cursor = {
        warp_on_change_workspace = 1,
    },
})
