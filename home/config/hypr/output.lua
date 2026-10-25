-- Monitors (mirrors sway's `output` file).
-- Outputs are matched by description, same as the sway config.

hl.monitor({
    output = "desc:BNQ BenQ GW2480 Y8K0070301Q",
    mode   = "1920x1080@75",
    position = "auto-left"
})

hl.monitor({
    output = "desc:BNQ ZOWIE XL LCD T6L00798SL0",
    mode   = "1920x1080@144",
    position = "auto-right"
})

-- Fallback rule for any other monitor that gets plugged in.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
