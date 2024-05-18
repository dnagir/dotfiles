local trouble = require("trouble")
local tools = require("user.tools")

tools.nmap("<leader>xx", function() trouble.toggle() end, { desc = "Trouble: toggle" })


tools.nmap("<leader>xk", function()
  trouble.open()
  trouble.previous({ skip_groups = true, jump = true });
end, { desc = "Trouble: next item" })

tools.nmap("<leader>xj", function()
  trouble.open()
  trouble.next({ skip_groups = true, jump = true });
end, { desc = "Trouble: next item" })
