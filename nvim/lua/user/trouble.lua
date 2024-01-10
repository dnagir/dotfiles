local trouble = require("trouble")
local tools = require("user.tools")

tools.nmap("<leader>xx", function() trouble.toggle() end, { desc = "Trouble: toggle" })
