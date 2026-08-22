
return {
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local indentscope = require("mini.indentscope")
      indentscope.setup({
        symbol = "┃",
        draw = {
          -- Safe: use built-in animation generator
          animation = indentscope.gen_animation.none(), -- <- no animation if cubic fails
          delay = 0,
        },
      })
    end,
  },
}

