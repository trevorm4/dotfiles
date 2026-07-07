local platform = require('utils.platform')

local wsl_distro = os.getenv('WSL_DISTRO_NAME') or 'archlinux'
local wsl_domain_name = 'WSL:' .. wsl_distro

local options = {
   default_prog = {},
   launch_menu = {},
   default_domain = nil,
}

if platform.is_win then
   options.default_domain = wsl_domain_name
   options.launch_menu = {
      { label = 'WSL Ubuntu', domain = { DomainName = wsl_domain_name } },
      { label = 'PowerShell Core', args = { 'pwsh', '-NoLogo' } },
      { label = 'PowerShell Desktop', args = { 'powershell' } },
      { label = 'Command Prompt', args = { 'cmd' } },
      { label = 'Nushell', args = { 'nu' } },
      { label = 'Msys2', args = { 'ucrt64.cmd' } },
      {
         label = 'Git Bash',
         args = { 'C:\\Users\\kevin\\scoop\\apps\\git\\current\\bin\\bash.exe' },
      },
   }
elseif platform.is_wsl then
   options.default_prog = { 'fish', '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Fish', args = { 'fish', '-l' } },
      { label = 'Zsh', args = { 'zsh', '-l' } },
      { label = 'Nushell', args = { 'nu', '-l' } },
   }
elseif platform.is_linux then
   options.default_prog = { 'fish', '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Fish', args = { 'fish', '-l' } },
      { label = 'Zsh', args = { 'zsh', '-l' } },
   }
end

return options
