local neotest = require("neotest")
neotest.setup({
  adapters = {
    require("neotest-go")({
      args = { "-count=1", "-timeout=60s" }
    }),
    require("neotest-rust") {
      args = { "--no-capture" },
    },
  },
  benchmark = {
    enabled = true
  },
  default_strategy = "integrated",
  diagnostic = {
    enabled = true,
    severity = 1
  },
  floating = {
    border = "rounded",
    max_height = 0.6,
    max_width = 0.6,
    options = {}
  },
  icons = {
    child_indent = "│",
    child_prefix = "├",
    collapsed = "─",
    expanded = "╮",
    failed = "🥀",
    final_child_indent = " ",
    final_child_prefix = "╰",
    non_collapsible = "─",
    passed = "🌲",
    running = "⏳",
    running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
    skipped = "⏩",
    unknown = "❔",
    watching = "👀"
  },
  log_level = 3,
  jump = {
    enabled = true
  },
  output = {
    enabled = true,
    open_on_run = "short"
  },
  output_panel = {
    enabled = false,
    open = "botright split | resize 15"
  },
  quickfix = {
    enabled = true,
    open = true,
  },
  run = {
    enabled = true
  },
  running = {
    concurrent = true
  },
  state = {
    enabled = true
  },
  status = {
    enabled = true,
    signs = true,
    virtual_text = false
  },
  strategies = {
    integrated = {
      height = 40,
      width = 120
    }
  },
  summary = {
    animated = true,
    enabled = true,
    expand_errors = true,
    follow = true,
    mappings = {
      attach = "a",
      clear_marked = "M",
      clear_target = "T",
      debug = "d",
      debug_marked = "D",
      expand = { "<CR>", "<2-LeftMouse>" },
      expand_all = "e",
      jumpto = "i",
      mark = "m",
      next_failed = "J",
      output = "o",
      prev_failed = "K",
      run = "r",
      run_marked = "R",
      short = "O",
      stop = "u",
      target = "t",
      watch = "w"
    },
    open = "botright vsplit | vertical resize 50"
  },
  watch = {
    enabled = true,
  }
})


local tools = require('user.tools')
tools.nmap("<leader>tt", function()
  neotest.run.run()
end, { desc = 'Test: run current' })

tools.nmap("<leader>t<leader>", function()
  neotest.run.run_last()
end, { desc = 'Test: run last' })

tools.nmap("<leader>ts", function()
  neotest.summary.open({ enter = true })
end, { desc = 'Test: open summary' })

tools.nmap("<leader>to", function()
  neotest.output.open({ enter = true })
end, { desc = 'Test: open popup' })
