-- lua/snippets/md.lua
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node

return {
  s(
    { trig = "mk", snippetType = "autosnippet" },
    {
      t("`"),
      i(1),
      t("`"),
    }
  ),
	s({
		trig = "dm",
		name = "code block",
		snippetType = "autosnippet",
	}, {
		t({ "```" }),
    i(2, "latex"),
    t({ "", "  " }),
    i(1),
		t({ "", "```" }),
	}),

}

