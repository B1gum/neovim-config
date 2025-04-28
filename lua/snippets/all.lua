local ls = require("luasnip")
ls.config.setup({ enable_autosnippets = true })
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node

-- Define an autosnippet for the current date
ls.add_snippets("all", {
	s({
		trig = "today", -- Trigger keyword
		name = "Date",
		snippetType = "autosnippet", -- Enables automatic expansion
	}, {
		f(function()
			local handle = io.popen("LC_TIME=da_DK.UTF-8 date +'%e. %B %Y' | sed 's/^ //'")
			local result = handle:read("*a")
			handle:close()
			return result:gsub("\n", "")
		end),
	}),
	s({
		trig = "snip",
		name = "snippet-template",
	}, {
		t("s({"),
		t({ "", '  trig = "' }),
		i(1, "trigger"),
		t('",'),
		t({ "", '  name = "' }),
		i(2, "name"),
		t('",'),
		t({ "", '  snippetType = "' }),
		i(3, "snippet"),
		t('",'),
		t({ "", "}, {", "  " }),
		i(4, ""),
		t({ "", "})," }),
	}),
	s({
		trig = "cnd",
		name = "conditional expansion only in math mode",
		snippetType = "autosnippet",
	}, {
		t({ "condition = function()", "" }),
		t({ '\t return vim.fn["vimtex#syntax#in_mathzone"]() == 1', "" }),
		t({ "end," }),
	}),
	s({
		trig = "usep",
		name = "usepackage",
		snippetType = "autosnippet",
	}, {
		t({ "\\usepackage[" }),
		i(1, "options"),
		t({ "]{" }),
		i(2, "package"),
		t({ "} " }),
	}),
	s({
		trig = "cbox",
		name = "add colorbox",
		snippetType = "autosnippet",
	}, {
		t({
			'"\\\\newtcolorbox[auto counter, number within=section]{definition}[1][]{%",',
      '"  breakable,"',
			'"  colframe=ForestGreen,  %frame color",',
			'"  colback=ForestGreen!5, %background color",',
			'"  coltitle=ForestGreen!70!black,  %title color",',
      '"  colbacktitle=ForestGreen!25,    %Background color for title",',
			'"  fonttitle=\\\\bfseries\\\\sffamily, %title font",',
			'"  left=1em,              %space on left side in box,",',
			'"  enhanced,              %more options",',
			'"  frame hidden,          %hide frame",',
			'"  borderline west={2pt}{0pt}{ForestGreen},  %display left line",',
			'"  title=Definition \\\\thetcbcounter: #1,",',
			'"}",',
		}),
	}),
})
