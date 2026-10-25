-- App launcher binds (mirrors sway's keybinds/apps).
local vars = require("variables")
local mod  = vars.mod

hl.bind(mod .. " + Return", hl.dsp.exec_cmd(vars.term))
hl.bind(mod .. " + Q",      hl.dsp.window.close())
hl.bind(mod .. " + Tab",    hl.dsp.exec_cmd(vars.launcher))

-- Screenshot region -> swappy (exec_cmd runs via sh -c, so pipes work)
hl.bind("F12", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | swappy -f -]]))

hl.bind(mod .. " + Z", hl.dsp.exec_cmd("sway-ahk -config ~/.config/sway-ahk/default.yaml"))
