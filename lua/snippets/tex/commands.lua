-- [
-- snip_env + autosnippets
-- ]
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

--[
-- personal imports
--]
local tex = require("snippets.tex.utils.conditions")
local single_command_snippet = require("snippets.tex.utils.scaffolding").single_command_snippet
local reference_snippet_table = {
  a = "auto",
  c = "c",
  C = "C",
  e = "eq",
  r = "",
}

M = {
  autosnippet(
    { trig = "alab", name = "label", dscr = "add a label" },
    fmta(
      [[
    \label{<>:<>}<>
    ]],
      { i(1), i(2), i(0) }
    )
  ),

  autosnippet(
    {
      trig = "([acCer])ref",
      name = "(acC|eq)?ref",
      dscr = "add a reference (with autoref, cref, eqref)",
      trigEngine = "pattern",
      hidden = true,
    },
    fmta(
      [[
    \<>ref{<>:<>}<>
    ]],
      { f(function(_, snip)
        return reference_snippet_table[snip.captures[1]]
      end), i(1), i(2), i(0) }
    ),
    { condition = function() return true end}
  ),
}

local single_command_specs = {
  sec = {
    context = {
      name = "section",
      dscr = "section",
      priority = 250,
    },
    command = [[\section]],
    ext = { label = true, short = "sec" },
  },
  ssec = {
    context = {
      name = "subsection",
      dscr = "subsection",
      priority = 500,
    },
    command = [[\subsection]],
    ext = { label = true, short = "subsec" },
  },
  sssec = {
    context = {
      name = "subsubsection",
      dscr = "subsubsection",
    },
    command = [[\subsubsection]],
    ext = { label = true, short = "sssec" },
  },
  sek = {
    context = {
      name = "section*",
      dscr = "section*",
      priority = 250,
    },
    command = [[\section*]],
    ext = { label = true, short = "sec" },
  },
  ssek = {
    context = {
      name = "subsection*",
      dscr = "subsection*",
      priority = 500,
    },
    command = [[\subsection*]],
    ext = { label = true, short = "subsec" },
  },
  sssek = {
    context = {
      name = "subsubsection*",
      dscr = "subsubsection*",
    },
    command = [[\subsubsection*]],
    ext = { label = true, short = "sssec" },
  },
  par = {
    context = {
      name = "paragraph",
      dscr = "paragraph",
    },
    command = [[\paragraph]],
    ext = { label = true, short = "par" },
  },
  tbf = {
    context = {
      name = "textbf",
      dscr = "bold text",
      hidden = true,
    },
    command = [[\textbf]],
  },
  tit = {
    context = {
      name = "textit",
      dscr = "italic text",
      hidden = true,
    },
    command = [[\textit]],
  },
  sc = {
    context = {
      name = "textsc",
      dscr = "small caps",
      hidden = true,
    },
    command = [[\textsc]],
  },
  tu = {
    context = {
      name = "underline (text)",
      dscr = "underlined text in non-math mode",
      hidden = true,
    },
    command = [[\underline]],
  },
  to = {
    context = {
      name = "overline (text)",
      dscr = "overline text in non-math mode",
      hidden = true,
    },
    command = [[\overline]],
  },
}

local single_command_snippets = {}
for k, v in pairs(single_command_specs) do
  table.insert(
    single_command_snippets,
    single_command_snippet(
      vim.tbl_deep_extend("keep", { trig = k }, v.context),
      v.command,
      v.opt or { condition = function() return true end },
      v.ext or {}
    )
  )
end
vim.list_extend(M, single_command_snippets)

return M
