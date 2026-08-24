
-- Debugging for C/C++.
--
-- Uses gdb's built-in DAP server (gdb 14+; 17.2 here) rather than Mason's
-- cpptools/OpenDebugAD7. gdb is already a system package, so there is no
-- prebuilt adapter to download — which also keeps this working on NixOS,
-- where Mason's FHS binaries do not run without a wrapper.

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "stevearc/overseer.nvim",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local overseer = require("overseer")

    -- ╭──────────────────────────────────────────────╮
    -- │ gdb Adapter (native DAP)                     │
    -- ╰──────────────────────────────────────────────╯
    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
    }

    -- ╭──────────────────────────────────────────────╮
    -- │ Debug Configurations for C/C++               │
    -- ╰──────────────────────────────────────────────╯
    dap.configurations.c = {
      {
        name = "Launch file (gdb)",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = true,
      },
    }
    dap.configurations.cpp = dap.configurations.c

    -- ╭──────────────────────────────────────────────╮
    -- │ Overseer, UI, Signs, Keymaps                 │
    -- ╰──────────────────────────────────────────────╯

    -- Only register the task providers that are actually usable here. Overseer
    -- registers every builtin by default and its health check then reports one
    -- warning per provider whose tool is missing (cargo-make, composer, deno,
    -- devenv, mage, mise, rake, task, ...). cargo, just and make are kept.
    overseer.setup({
      disable_template_modules = {
        "overseer.template.cargo-make",
        "overseer.template.composer",
        "overseer.template.deno",
        "overseer.template.devenv",
        "overseer.template.mage",
        "overseer.template.mise",
        "overseer.template.mix",
        "overseer.template.npm",
        "overseer.template.rake",
        "overseer.template.task",
        "overseer.template.tox",
        "overseer.template.vscode",
      },
    })

    -- Add keymap to trigger Overseer build/run tasks
    vim.keymap.set(
      "n",
      "<leader>bb",
      ":OverseerRun<CR>",
      { noremap = true, silent = true, desc = "Run build task (Overseer)" }
    )

    dapui.setup()
    require("nvim-dap-virtual-text").setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
    vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "✖", texthl = "DiagnosticError" })

    local map = vim.keymap.set
    map("n", "<leader>dc", dap.continue, { desc = "Start/Continue Debugging" })
    map("n", "<leader>do", dap.step_over, { desc = "Step Over" })
    map("n", "<leader>di", dap.step_into, { desc = "Step Into" })
    map("n", "<leader>du", dap.step_out, { desc = "Step Out" })
    map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    map("n", "<leader>B", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Conditional Breakpoint" })
    map("n", "<leader>dr", dap.repl.open, { desc = "Open DAP REPL" })
    map("n", "<leader>dl", dap.run_last, { desc = "Run Last Debug Session" })
    map("n", "<leader>dut", dapui.toggle, { desc = "Toggle DAP UI" })
  end,
}

