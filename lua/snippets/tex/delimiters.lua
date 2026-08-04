-- [
-- snip_env + autosnippets
-- ]
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

--[
-- personal imports
--]
local tex = require("snippets.tex.utils.conditions")
local scaffolding = require("snippets.tex.utils.scaffolding")

-- brackets
local brackets = {
    ["("] = { "(", ")" },              -- parentheses
    ["["] = { "[", "]" },              -- square brackets
    ["{"] = { "\\{", "\\}" },          -- curly braces (escaped for LaTeX)
    ["<"] = { "\\langle", "\\rangle" },-- angle brackets
    ["|"] = { "|", "|" }               -- absolute value or norm bars
}

M = {
    autosnippet(
        { trig = "lr([%(%)%{%}%<%|%[])",
          name = "left right delimiters",
          dscr = "left right delimiters",
          regTrig = true,
          hidden = true },
        fmta(
            [[
            \left<> <> \right<><>
            ]],
            {
                f(function(_, snip)
                    local cap = snip.captures[1] or "("  -- default to parentheses
                    return brackets[cap][1]
                end),
                d(1, scaffolding.get_visual),
                f(function(_, snip)
                    local cap = snip.captures[1] or "("
                    return brackets[cap][2]
                end),
                i(0)
            }
        ),
        { condition = tex.in_math, show_condition = tex.in_math }
    ),
    autosnippet(
      { trig = "%(%)",
        name = "left right ()",
        dscr = "left right ()",
        regTrig = true,
        hidden = true },
      fmta(
        [[
        \left( <> \right) <>
        ]],
        {
          d(1, scaffolding.get_visual),
          i(0)
        }
      ),
      { condition = tex.in_math, show_condition = tex.in_math }
  ),
}

return M
