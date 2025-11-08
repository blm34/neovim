local runner = require("runners.python")

vim.keymap.set("n", "<leader>RR", runner.run_current_file,
    { buffer = true, desc = "Run current python file" })

vim.keymap.set("n", "<leader>RF", runner.pick_register_and_run,
    { buffer = true, desc = "Run python file from register" })

vim.keymap.set("n", "<leader>RS", runner.save_current_file_to_register,
    { buffer = true, desc = "Save current file path into a register" })
