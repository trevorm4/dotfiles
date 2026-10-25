-- Pointer input (mirrors sway's `input "type:pointer"` block).
-- Hyprland's `input` section applies to all pointer devices; touchpads can be
-- overridden separately via `input.touchpad` or hl.device().
hl.config({
    input = {
        accel_profile = "flat",
        sensitivity   = 0.5, -- sway: pointer_accel 0.5
        follow_mouse  = 1,
    },
})
