-- Workspace -> monitor assignments (mirrors sway's `workspaces` file).
-- Odd workspaces on the BenQ, even ones on the ZOWIE.
-- persistent = true keeps workspaces alive like sway's always are.

local BENQ  = "desc:BNQ BenQ GW2480 Y8K0070301Q"
local ZOWIE = "desc:BNQ ZOWIE XL LCD T6L00798SL0"

for _, ws in ipairs({ 1, 3, 5, 7, 9 }) do
    hl.workspace_rule({
        workspace  = tostring(ws),
        monitor    = BENQ,
        persistent = true,
        default    = ws == 1,
    })
end

for _, ws in ipairs({ 2, 4, 6, 8, 10 }) do
    hl.workspace_rule({
        workspace  = tostring(ws),
        monitor    = ZOWIE,
        persistent = true,
        default    = ws == 2,
    })
end
