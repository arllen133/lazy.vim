return {
  {
    "gelguy/wilder.nvim",
    enabled = false,
    lazy = true,
    event = "CmdlineEnter",
    dependencies = { "romgrk/fzy-lua-native" },
    config = function()
      local wilder = require("wilder")
      wilder.setup({ modes = { ":", "/", "?" } })
      -- Disable Python remote plugin
      wilder.set_option("use_python_remote_plugin", 0)

      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.substitute_pipeline({
            pipeline = wilder.python_search_pipeline({
              skip_cmdtype_check = 1,
              pattern = wilder.python_fuzzy_pattern({
                start_at_boundary = 0,
              }),
            }),
          }),
          wilder.cmdline_pipeline({
            fuzzy = 2,
            fuzzy_filter = wilder.lua_fzy_filter(),
          }),
          {
            wilder.check(function(ctx, x)
              return x == ""
            end),
            wilder.history(),
          }
        ),
      })

      local highlighters = {
        wilder.pcre2_highlighter(),
        wilder.lua_fzy_highlighter(),
      }

      local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
        border = "rounded",
        empty_message = wilder.popupmenu_empty_message_with_spinner(),
        highlighter = highlighters,
        left = {
          " ",
          wilder.popupmenu_devicons(),
          wilder.popupmenu_buffer_flags({
            flags = " a + ",
            icons = { ["+"] = "", a = "", h = "" },
          }),
        },
        right = {
          " ",
          wilder.popupmenu_scrollbar(),
        },
      }))

      local wildmenu_renderer = wilder.wildmenu_renderer({
        highlighter = highlighters,
        separator = " · ",
        left = { " ", wilder.wildmenu_spinner(), " " },
        right = { " ", wilder.wildmenu_index() },
      })

      wilder.set_option(
        "renderer",
        wilder.renderer_mux({
          [":"] = popupmenu_renderer,
          ["/"] = wildmenu_renderer,
          substitute = wildmenu_renderer,
        })
      )
    end,
  },
}
