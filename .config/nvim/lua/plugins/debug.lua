local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = vim.fn.argc(-1) > 0 and now or later

later(function()
  add({
    source = "mfussenegger/nvim-dap",
    depends = {
      "rcarriga/nvim-dap-ui",
      "nvim-lua/plenary.nvim",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio"
    },
  })

  -- Keybindings para debugging
  local keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
    { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
  }

  -- Configuración de nvim-dap
  local function dap_config()
    local ok, mason_dap = pcall(require, "mason-nvim-dap")
    if ok then
      mason_dap.setup({
        ensure_installed = { "delve", "python" }, -- Instala automáticamente delve y debugpy
        handlers = {}, -- Usa configuraciones manuales
      })
    else
      vim.notify("mason-nvim-dap no está disponible", vim.log.levels.WARN)
    end

    -- Go: Configuración de Delve
    local dlv_path = vim.fn.exepath("dlv") or vim.fn.stdpath("data") .. "/mason/bin/dlv"
    require("dap").adapters.go = {
      type = "server",
      port = "${port}",
      executable = {
        command = dlv_path,
        args = { "dap", "-l", "127.0.0.1:${port}" },
      },
    }
    require("dap").configurations.go = {
      {
        type = "go",
        name = "Launch file",
        request = "launch",
        program = "${file}",
      },
      {
        type = "go",
        name = "Debug Package",
        request = "launch",
        program = "${workspaceFolder}",
      },
      {
        type = "go",
        name = "Debug Test",
        request = "launch",
        mode = "test",
        program = "${file}",
      },
    }

    -- Python: Configuración de debugpy
    require("dap").adapters.python = {
      type = "executable",
      command = "python",
      args = { "-m", "debugpy.adapter" },
    }
    require("dap").configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
        end,
      },
    }

    -- Resaltar línea de parada
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    -- Iconos para DAP
    local dap_icons = {
      Stopped = { "", "DapStoppedLine", "DapStoppedLine" },
      Breakpoint = { "", "DapBreakpoint", "DapBreakpoint" },
      BreakpointCondition = { "", "DapBreakpointCondition", "DapBreakpointCondition" },
      LogPoint = { "", "DapLogPoint", "DapLogPoint" },
    }
    for name, sign in pairs(dap_icons) do
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end

    -- Soporte para launch.json de VSCode
    local vscode = require("dap.ext.vscode")
    local json = require("plenary.json")
    vscode.json_decode = function(str)
      return vim.json.decode(json.json_strip_comments(str))
    end
  end

  -- Configuración de nvim-dap-ui
  local function dapui_config()
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.5 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = { "repl", "console" },
          size = 10,
          position = "bottom",
        },
      },
    })
    dap.listeners.after.event_initialized["dapui_config"] = function()
      if vim.bo.filetype == "go" or vim.bo.filetype == "python" then
        dapui.open({})
      end
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close({})
    end
  end

  -- Configuración de virtual text
  require("nvim-dap-virtual-text").setup({
    enabled = true,
    virt_text_pos = "eol",
  })
  -- Aplicar configuraciones
  dap_config()
  dapui_config()

  -- Registrar keybindings
  for _, key in ipairs(keys) do
    vim.keymap.set(key.mode or "n", key[1], key[2], { desc = key.desc })
  end
end)
