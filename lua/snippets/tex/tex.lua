local ls = require("luasnip")
ls.config.setup({ enable_autosnippets = true })
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local get_visual = function(_, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else -- If LS_SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1))
	end
end

ls.add_snippets("tex", {
  s({
    trig = "input",
    name = "input",
    snippetType = "snippet",
  }, {
    t("\\input{"),
    i(1, "fil"),
    t("}"),
  }),
	s({
		trig = "lec",
		name = "lecture",
	}, {
		t("\\lecture{"),
		i(1, "nr"),
		t("}{"),
		i(2, "dato"),
		t("}{"),
		i(3, "Forelæsningsemne"),
		t("}"),
	}),
  s({
    trig = "exer",
    name = "exercise",
  }, {
    t("\\exercise{"),
    i(1, "nr."),
    t("}"),
  }),
  s({
    trig = "opg",
    name = "opgave",
  }, {
    t("\\opgave{"),
    i(1, "nr."),
    t("}"),
  }),
	s({
		trig = "beg",
		name = "begin{} end{}",
		snippetType = "snippet",
	}, {
		t({ "\\begin{" }),
		i(1, "environment"),
		t( "}" ),
    t({ "", "  " }),
    d(2, get_visual),
		t({ "", "\\end{" }),
		f(function(args)
			return args[1][1]
		end, { 1 }),
		t("}"),
	}),

	s({
		trig = "pro",
		name = "begin{problem} end{problem}",
		snippetType = "snippet",
	}, {
		t({ "\\begin{problem}{" }),
    i(1, "problem number"),
    t({ "}", "  " }),
    d(2, get_visual),
		t({ "", "\\end{problem}" }),
	}),
	s({
		trig = "prim",
		name = "begin{problemwithimage} end{problemwithimage}",
		snippetType = "snippet",
	}, {
		t({ "\\begin{problemwithimage}{" }),
		i(1, "filename"),
		t( "}{" ),
    i(2, "problem number"),
    t( "}", "" ),
    t({ "", "  " }),
    d(3, get_visual),
		t({ "", "\\end{problemwithimage}" }),
	}),
	s({
		trig = "ass",
		name = "begin{assumptions} end{assumptions}",
		snippetType = "snippet",
	}, {
		t({ "\\begin{assumptions}" }),
    t({ "", "  \\item " }),
    d(1, get_visual),
		t({ "", "\\end{assumptions}" }),
	}),
	s({
		trig = "givens",
		name = "begin{givens} end{givens}",
		snippetType = "snippet",
	}, {
		t({ "\\begin{givens}" }),
    t({ "", "  "}),
    i(1, "symbol"),
    t({ " & " }),
    i(2, "explanation"),
		t({ "", "\\end{givens}" }),
	}),
	s({
		trig = "der",
		name = "begin{derivation} end{derivation}",
		snippetType = "snippet",
	}, {
		t({ "\\begin{derivation}" }),
    t({ "", "  " }),
    d(1, get_visual),
		t({ "", "\\end{derivation}" }),
	}),
	s({
		trig = "res",
		name = "finalresult",
		snippetType = "snippet",
	}, {
		t({ "\\finalresult{" }),
    d(1, get_visual),
    t({ "}" }),
	}),
	s({
		trig = "bb",
		name = "bigbreak",
		snippetType = "autosnippet",
	}, {
		t({ "\\bigbreak", "" }),
	}),
	s({
		trig = "ui",
		name = "unit",
		snippetType = "autosnippet",
	}, {
		t({ "\\unit{\\" }),
		d(1, get_visual),
		t({ "}" }),
	}),
	s({
		trig = "qt",
		name = "quantity",
		snippetType = "autosnippet",
	}, {
		t({ "\\qty{" }),
		i(1),
		t({ "}{\\" }),
		i(2),
		t({ "} " }),
	}),
	s({
		trig = "nm",
		name = "number",
		snippetType = "autosnippet",
	}, {
		t({ "\\num{" }),
		d(1, get_visual),
		t({ "} " }),
	}),
	s({
		trig = "az",
		name = "angle",
		snippetType = "autosnippet",
	}, {
		t({ "\\ang{" }),
		d(1, get_visual),
		t({ "} " }),
	}),
	s({
		trig = "...",
		name = "ldots",
		snippetType = "autosnippet",
	}, {
		t({ "\\ldots " }),
	}),
	s({
		trig = "table",
		name = "Table environment",
		snippetType = "snippet",
	}, {
		t({ "\\begin{table}[" }),
		i(1, "htpb"),
		t({ "]", "\\centering", "\\caption{" }),
		i(2, "caption"),
		t({ "}", "\\label{tab:" }),
		i(3, "label"),
		t({ "}", "\\begin{tabular}{" }),
		i(4, "c"),
		t({ "}", "" }),
		d(5, function(args)
			local col_spec = args[1][1] or ""
			local columns = {}
			for c in col_spec:gmatch(".") do
				table.insert(columns, c)
			end
			return sn(nil, { t(table.concat(columns, " & ")) })
		end, { 4 }),
		t({ "", "\\end{tabular}", "\\end{table}" }),
	}),
	s({
		trig = "fig",
		name = "fiure environment",
		snippetType = "snippet",
	}, {
		t("\\begin{figure}["),
		i(1, "htpb"),
		t({ "]", "\t\\centering", "\t\\incfig[" }),
		i(4, "1"),
		t("]{"),
		i(2, "Navn"),
		t("}"),
		t({ "", "\t\\caption{" }),
    i(3, "Caption"),
		t("}"),
		t({ "", "\t\\label{fig:" }),
		f(function(args)
			return (args[1][1] or ""):gsub("%W+", "-")
		end, { 2 }),
		t("}"),
		t({ "", "\\end{figure}" }),
	}),
	s({
		trig = "ifig",
		name = "insert figure",
		snippetType = "snippet",
	}, {
		t("\\begin{figure} ["),
		i(1, "htpb"),
		t({ "]", "\t\\centering", "\t\\includegraphics[width=" }),
		i(4, "0.5"), -- Width of the image
		t("\\linewidth]{./figures/"),
		i(2, "filename"), -- File name without extension
		t({".png}", "\t\\caption{" }),
    i(3, "Caption"),
		t({ "}", "\t\\label{fig:" }),
		f(function(args)
			return args[1][1] or "label"
		end, { 2 }),
		t("}"),
		t({ "", "\\end{figure}" }),
	}),
	s({
		trig = "box",
		name = "latex-box",
		snippetType = "autosnippet",
	}, {
		-- Top border
		f(function(args)
			local content = args[1][1] or ""
			return "┌" .. string.rep("─", #content + 2) .. "┐"
		end, { 1 }),

		-- Box content with padding
		t({ "", "│ " }),
		d(1, get_visual), -- Placeholder for user text
		t(" │"),

		-- Bottom border
		t({ "", "" }),
		f(function(args)
			local content = args[1][1] or ""
			return "└" .. string.rep("─", #content + 2) .. "┘"
		end, { 1 }),

		i(0), -- Final stop
	}),
	s({
		trig = "enum",
		name = "enumerate",
		snippetType = "autosnippet",
	}, {
		t("\\begin{enumerate}"),
		t({ "", "\t\\item " }),
		d(1, get_visual),
		t({ "", "\\end{enumerate}" }),
	}),
	s({
		trig = "item",
		name = "itemize",
		snippetType = "snippet",
	}, {
		t("\\begin{itemize}"),
		t({ "", "\t\\item " }),
		d(1, get_visual),
		t({ "", "\\end{itemize}" }),
	}),
	s({
		trig = "desc",
		name = "description",
		snippetType = "snippet",
	}, {
		t("\\begin{description}"),
		t({ "", "\t\\item[" }),
		i(1),
		t({ "] " }),
		i(0),
		t({ "", "\\end{description}" }),
	}),
	s({
		trig = "ceil",
		name = "ceiling",
		snippetType = "autosnippet",
		wordTrig = false,
		condition = function()
			return vim.fn["vimtex#syntax#in_mathzone"]() == 1
		end,
	}, {
		t({ "\\left\\lceil " }),
		d(1, get_visual),
		t({ " \\right\\rceil " }),
	}),
	s({
		trig = "floor",
		name = "floor",
		snippetType = "autosnippet",
		condition = function()
			return vim.fn["vimtex#syntax#in_mathzone"]() == 1
		end,
	}, {
		t({ "\\left\\lfloor " }),
		d(1, get_visual),
		t({ " \\right\\rfloor " }),
	}),
	s({
		trig = "sum",
		name = "sum",
		snippetType = "snippet",
	}, {
		t({ "\\sum_{n=" }),
		i(1, "1"),
		t({ "}^{" }),
		i(2, "\\infty"),
		t("} "),
		i(3, "a_n z^n"),
	}),
	s({
		trig = "int",
		name = "integral",
		snippetType = "autosnippet",
		condition = function()
			return vim.fn["vimtex#syntax#in_mathzone"]() == 1
		end,
	}, {
		t("\\int "),
	}),
	s({
		trig = "pd",
		name = "partial derivative",
		snippetType = "autosnippet",
	}, {
		t("\\frac{\\partial "),
		i(1, "V"),
		t("}{\\partial "),
		i(2, "x"),
		t("} "),
	}),
  s({
    trig = "bn",
    name = "binomial",
    snippetType = "autosnippet",
  }, {
    t("\\binom{"),
    i(1),
    t("}{"),
    i(2),
    t("}"),
  }),
	s({
		trig = "ift",
		name = "infinity",
		snippetType = "autosnippet",
		wordTrig = false,
		condition = function()
			return vim.fn["vimtex#syntax#in_mathzone"]() == 1
		end,
	}, {
		t("\\infty "),
	}),
	s({
		trig = "ex",
		name = "e^x",
		snippetType = "autosnippet",
		wordTrig = false,
    condition = function()
       return vim.fn["vimtex#syntax#in_mathzone"]() == 1
    end,
	}, {
		t("e^{x}"),
	}),
	s({
			trig = "ee",
			name = "e^{}",
			snippetType = "autosnippet",
			wordTrig = false,
			regTrig = true,
      condition = function()
			  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
		  end,
		},
		fmta("e^{<>}", {
			d(1, get_visual),
		})
	),
	s({
		trig = "xnn",
		name = "x_n",
		snippetType = "autosnippet",
		wordTrig = false,
		condition = function()
			return vim.fn["vimtex#syntax#in_mathzone"]() == 1
		end,
	}, {
		t("x_{n} "),
	}),
	s({
		trig = "ynn",
		name = "y_n",
		snippetType = "autosnippet",
		wordTrig = false,
		condition = function()
			return vim.fn["vimtex#syntax#in_mathzone"]() == 1
		end,
	}, {
		t("y_{n} "),
	}),
	s({
		trig = "xii",
		name = "x_i",
		snippetType = "autosnippet",
		wordTrig = false,
		condition = function()
			return vim.fn["vimtex#syntax#in_mathzone"]() == 1
		end,
	}, {
		t("x_{i} "),
	}),
	s({
		trig = "yii",
		name = "y_i",
		snippetType = "autosnippet",
		wordTrig = false,
		condition = function()
			return vim.fn["vimtex#syntax#in_mathzone"]() == 1
		end,
	}, {
		t("y_{i} "),
	}),
	s({
		trig = "xjj",
		name = "x_j",
		snippetType = "autosnippet",
		wordTrig = false,
		condition = function()
			return vim.fn["vimtex#syntax#in_mathzone"]() == 1
		end,
	}, {
		t("x_{j} "),
	}),
	s({
		trig = "yjj",
		name = "y_j",
		snippetType = "autosnippet",
		wordTrig = false,
		condition = function()
			return vim.fn["vimtex#syntax#in_mathzone"]() == 1
		end,
	}, {
		t("y_{j} "),
	}),
	s({
		trig = "xpl1",
		name = "x_{n+1}",
		snippetType = "autosnippet",
		wordTrig = false,
		condition = function()
			return vim.fn["vimtex#syntax#in_mathzone"]() == 1
		end,
	}, {
		t("x_{n+1} "),
	}),
	s({
		trig = "nbl",
		name = "nabla",
		snippetType = "autosnippet",
		wordTrig = false,
		condition = function()
			return vim.fn["vimtex#syntax#in_mathzone"]() == 1
		end,
	}, {
		t("\\nabla "),
	}),
	s({
		trig = "dint",
		name = "definite integral",
		snippetType = "autosnippet",
		condition = function()
			return vim.fn["vimtex#syntax#in_mathzone"]() == 1
		end,
	}, {
		t("\\int_{"),
		i(1, "-\\infty"),
		t("}^{"),
		i(2, "\\infty"),
		t("} "),
	}),
	s({
		trig = "ddt",
		name = "derivative with respect to time",
		snippetType = "autosnippet",
    condition = function()
       return vim.fn["vimtex#syntax#in_mathzone"]() == 1
    end,
	}, {
		t("\\frac{\\mathrm{d}"),
		i(1),
		t("}{\\mathrm{d}t} "),
	}),
	s({
		trig = "ddx",
		name = "derivative with respect to x",
		snippetType = "autosnippet",
    condition = function()
       return vim.fn["vimtex#syntax#in_mathzone"]() == 1
    end,
	}, {
		t("\\frac{\\mathrm{d}"),
		i(1),
		t("}{\\mathrm{d}x} "),
	}),
	s({
		trig = "ddy",
		name = "derivative with respect to y",
		snippetType = "autosnippet",
    condition = function()
       return vim.fn["vimtex#syntax#in_mathzone"]() == 1
    end,
	}, {
		t("\\frac{\\mathrm{d}"),
		i(1),
		t("}{\\mathrm{d}y} "),
	}),
	s({
		trig = "dt",
		name = "dt",
		snippetType = "autosnippet",
    condition = function()
       return vim.fn["vimtex#syntax#in_mathzone"]() == 1
    end,
	}, {
		t("\\, \\mathrm{d}t "),
	}),
	s({
		trig = "dx",
		name = "dx",
		snippetType = "autosnippet",
    condition = function()
       return vim.fn["vimtex#syntax#in_mathzone"]() == 1
    end,
	}, {
		t("\\, \\mathrm{d}x "),
	}),
	s({
		trig = "dy",
		name = "dy",
		snippetType = "autosnippet",
    condition = function()
       return vim.fn["vimtex#syntax#in_mathzone"]() == 1
    end,
	}, {
		t("\\, \\mathrm{d}y "),
	}),
	s({
		trig = "s1",
		name = "thin space",
		snippetType = "autosnippet",
	}, {
		t("\\, "),
	}),
	s({
		trig = "s2",
		name = "med space",
		snippetType = "autosnippet",
	}, {
		t("\\: "),
	}),
	s({
		trig = "s3",
		name = "thick space",
		snippetType = "autosnippet",
	}, {
		t("\\; "),
	}),
	s({
		trig = "q",
		name = "quad",
		snippetType = "snippet",
		wordTrig = false,
	}, {
		t("\\quad"),
	}),
  s({
    trig = "\\quadq",
    name = "qquad",
    snippetType = "autosnippet",
    wordTrig = true,
  }, {
    t("\\qquad "),
  }),
	s({
		trig = "''",
		name = "single quotes",
		snippetType = "autosnippet",
		wordTrig = false,
		condition = function()
			-- Check that `vimtex` is loaded and we are not in a math zone
			return vim.api.nvim_call_function("vimtex#syntax#in_mathzone", {}) == 0
		end,
	}, {
		t("`"),
		d(1, get_visual),
		t("' "),
	}),
	s({
		trig = '""',
		name = "double quotes",
		snippetType = "autosnippet",
		wordTrig = false,
	}, {
		t("``"),
		d(1, get_visual),
		t("''"),
	}),
  s({
    trig = "var",
    name = "Variance",
    snippetType = "snippet",
    condition = function()
       return vim.fn["vimtex#syntax#in_mathzone"]() == 1
    end,
  }, {
    t("\\mathrm{Var}("),
    i(1, "X"),
    t(")"),
  }),
})

