return {
    "nvim-mini/mini.animate",
    version = "*",
    event = "BufEnter",
    config = function()
        local animate = require("mini.animate")

        animate.setup({
            cursor = {
                enable = false,
            },

            scroll = {
                enable = true,
                timing = animate.gen_timing.exponential({
                    easing = "out",
                    duration = 300,
                    unit = "total",
                    easing_power = 2.0,
                }),
                subscroll = animate.gen_subscroll.equal({ max_output_steps = 60 }),
            },

            resize = {
                enable = true,
                timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
            },

            open = {
                enable = true,
                timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
            },

            close = {
                enable = true,
                timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
            },
        })
    end
}
