local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta
ls.config.setup({ enable_autosnippets = true })
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local get_visual = function(args, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else -- If LS_SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1))
	end
end

ls.add_snippets("tex", {
	s({
		trig = "template",
		name = "latex-template",
		snippetType = "autosnippet",
	}, {
		t({
			"\\documentclass[12pt]{article}",
			"\\usepackage[danish]{babel}",
			"\\usepackage{amsfonts, amssymb, mathtools, amsthm, amsmath}",
			"\\usepackage{graphicx, pgfplots}",
			"\\usepackage{url}",
			"\\usepackage[dvipsnames]{xcolor}",
			"\\usepackage{sagetex}",
      "\\usepackage{lastpage}",
			"",
			"%loaded last",
			"\\usepackage[hidelinks]{hyperref}",
			"",
			"\\usepackage{siunitx}",
			"  \\sisetup{exponent-product = \\cdot,",
			"    output-decimal-marker = {,}}",
			"",
			"%Giles Castelles incfig",
			"\\usepackage{import}",
			"\\usepackage{xifthen}",
			"\\usepackage{pdfpages}",
			"\\usepackage{transparent}",
			"",
			"\\newcommand{\\incfig}[2][1]{%",
			"  \\def\\svgwidth{#1\\columnwidth}",
			"  \\import{./figures/}{#2.pdf_tex}",
			"}",
			"",
			"\\setlength{\\parindent}{0in}",
			"\\setlength{\\oddsidemargin}{0in}",
			"\\setlength{\\textwidth}{6.5in}",
			"\\setlength{\\textheight}{8.8in}",
			"\\setlength{\\topmargin}{0in}",
			"\\setlength{\\headheight}{18pt}",
			"",
			"\\usepackage{fancyhdr}",
			"\\pagestyle{fancy}",
			"",
			"\\fancyhead{}",
			"\\fancyfoot{}",
			"\\fancyfoot[R]{\\thepage}",
			"\\fancyhead[C]{\\leftmark}",
			"",
			"\\pgfplotsset{compat=newest}",
			"",
			"\\pgfplotsset{every axis/.append style={",
			"  axis x line=middle,    % put the x axis in the middle",
			"  axis y line=middle,    % put the y axis in the middle",
			"  axis line style={<->,color=black}, % arrows on the axis",
			"}}",
			"",
			"\\usepackage{thmtools}",
			"\\usepackage{tcolorbox}",
			"  \\tcbuselibrary{skins, breakable}",
			"  \\tcbset{",
			"    space to upper=1em,",
			"    space to lower=1em,",
			"  }",
			"",
			"\\theoremstyle{definition}",
			"",
			"\\newtcolorbox[auto counter]{definition}[1][]{%",
			"  breakable,",
			"  colframe=ForestGreen,  %frame color",
			"  colback=ForestGreen!5, %background color",
			"  colbacktitle=ForestGreen!25, %background color for title",
			"  coltitle=ForestGreen!70!black,  %title color",
			"  fonttitle=\\bfseries\\sffamily, %title font",
			"  left=1em,              %space on left side in box,",
			"  enhanced,              %more options",
			"  frame hidden,          %hide frame",
			"  borderline west={2pt}{0pt}{ForestGreen},  %display left line",
			"  title=Definition \\thetcbcounter: #1,",
			"}",
			"",
			"\\newtcolorbox{greenline}{%",
			"  breakable,",
			"  colframe=ForestGreen,  %frame color",
			"  colback=white,          %remove background color",
			"  left=1em,              %space on left side in box",
			"  enhanced,              %more options",
			"  frame hidden,          %hide frame",
			"  borderline west={2pt}{0pt}{ForestGreen},  %display left line",
			"}",
			"",
			"\\newtcolorbox[auto counter, number within=section]{eks}[1][]{%",
			"  brekable,",
			"  colframe=NavyBlue,  %frame color",
			"  colback=NavyBlue!5, %background color",
			"  colbacktitle=NavyBlue!25,    %background color for title",
			"  coltitle=NavyBlue!70!black,  %title color",
			"  fonttitle=\\bfseries\\sffamily, %title font",
			"  left=1em,            %space on left side in box,",
			"  enhanced,            %more options",
			"  frame hidden,        %hide frame",
			"  borderline west={2pt}{0pt}{NavyBlue},  %display left line",
			"  title=Eksempel \\thetcbcounter: #1",
			"}",
			"",
			"\\newtcolorbox{blueline}{%",
			"  breakable,",
			"  colframe=NavyBlue,     %frame color",
			"  colback=white,         %remove background",
			"  left=1em,              %space on left side in box,",
			"  enhanced,              %more options",
			"  frame hidden,          %hide frame",
			"  borderline west={2pt}{0pt}{NavyBlue},  %display left line",
			"}",
			"",
			"\\newtcolorbox{teo}[1][]{%",
			"  breakable,",
			"  colframe=RawSienna,  %frame color",
			"  colback=RawSienna!5, %background color",
			"  colbacktitle=RawSienna!25,    %background color for title",
			"  coltitle=RawSienna!70!black,  %title color",
			"  fonttitle=\\bfseries\\sffamily, %title font",
			"  left=1em,              %space on left side in box,",
			"  enhanced,              %more options",
			"  frame hidden,          %hide frame",
			"  borderline west={2pt}{0pt}{RawSienna},  %display left line",
			"  title=Teori: #1,",
			"}",
			"",
			"\\newtcolorbox[auto counter, number within=section]{sæt}[1][]{%",
			"  breakable,",
			"  colframe=RawSienna,  %frame color",
			"  colback=RawSienna!5, %background color",
			"  colbacktitle=RawSienna!25,    %background color for title",
			"  coltitle=RawSienna!70!black,  %title color",
			"  fonttitle=\\bfseries\\sffamily, %title font",
			"  left=1em,              %space on left side in box,",
			"  enhanced,              %more options",
			"  frame hidden,          %hide frame",
			"  borderline west={2pt}{0pt}{RawSienna},  %display left line",
			"  title=Sætning \\thetcbcounter: #1,",
			"  before lower={\\textbf{Bevis:}\\par\\vspace{0.5em}},",
			"  colbacklower=RawSienna!25,",
			"}",
			"",
			"\\newtcolorbox{redline}{%",
			"  breakable,",
			"  colframe=RawSienna,  %frame color",
			"  colback=white,       %Remove background color",
			"  left=1em,            %space on left side in box,",
			"  enhanced,            %more options",
			"  frame hidden,        %hide frame",
			"  borderline west={2pt}{0pt}{RawSienna},  %display left line",
			"}",
			"",
			"\\newtcolorbox{for}[1][]{%",
			"  breakable,",
			"  colframe=NavyBlue,  %frame color",
			"  colback=NavyBlue!5, %background color",
			"  colbacktitle=NavyBlue!25,    %background color for title",
			"  coltitle=NavyBlue!70!black,  %title color",
			"  fonttitle=\\bfseries\\sffamily, %title font",
			"  left=1em,              %space on left side in box,",
			"  enhanced,              %more options",
			"  frame hidden,          %hide frame",
			"  borderline west={2pt}{0pt}{NavyBlue},  %display left line",
			"  title=Forklaring #1,",
			"}",
			"",
			"\\newtcolorbox{bem}{%",
			"  breakable,",
			"  colframe=NavyBlue,  %frame color",
			"  colback=NavyBlue!5, %background color",
			"  colbacktitle=NavyBlue!25,    %background color for title",
			"  coltitle=NavyBlue!70!black,  %title color",
			"  fonttitle=\\bfseries\\sffamily, %title font",
			"  left=1em,              %space on left side in box,",
			"  enhanced,              %more options",
			"  frame hidden,          %hide frame",
			"  borderline west={2pt}{0pt}{NavyBlue},  %display left line",
			"  title=Bemærkning:,",
			"}",
			"",
			"\\makeatother",
			"\\def\\@lecture{}%",
			"\\newcommand{\\lecture}[3]{",
			"  \\ifthenelse{\\isempty{#3}}{%",
			"    \\def\\@lecture{Lecture #1}%",
			"  }{%",
			"    \\def\\@lecture{Lecture #1: #3}%",
			"  }%",
			"  \\subsection*{\\makebox[\\textwidth][l]{\\@lecture \\hfill \\normalfont\\small\\textsf{#2}}}",
			"}",
			"",
			"\\makeatletter",
			"",
			"\\newcommand{\\opgave}[1]{%",
			" \\def\\@opgave{#1}%",
			" \\subsection*{Opgave #1}",
			"}",
			"",
			"\\makeatother",
			"",
			"%Format lim the same way in intext and in display",
			"\\let\\svlim\\lim\\def\\lim{\\svlim\\limits}",
			"",
			"% horizontal rule",
			"\\newcommand\\hr{",
			"\\noindent\\rule[0.5ex]{\\linewidth}{0.5pt}",
			"}",
			"",
			"\\title{",
		}),
		i(1, "Title"),
		t("}"),
		t({ "", "\\author{Noah Rahbek Bigum Hansen}", "\\date{" }),
		i(2, "Date"),
		t({ "}", "", "\\begin{document}", "", "\\maketitle", "", "" }),
		i(0),
		t({ "", "", "\\end{document}" }),
	}),
  s({
    trig = "input",
    name = "input",
    snippetType = "autosnippet",
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
		t( "}[" ),
    i(2, "navn (kun tcolorbox)" ),
    t({ "]", "  " }),
    d(3, get_visual),
		t({ "", "\\end{" }),
		f(function(args)
			return args[1][1]
		end, { 1 }),
		t("}"),
	}),
	s({
		trig = "bb",
		name = "bigbreak",
		snippetType = "autosnippet",
	}, {
		t({ "\\bigbreak", "" }),
	}),
	s({
		trig = ",.",
		name = "sage-symbolic",
		snippetType = "autosnippet",
	}, {
		t({ "\\sage{" }),
		d(1, get_visual),
		t({ "} " }),
	}),
	s({
		trig = ".,",
		name = "sage-calc",
		snippetType = "autosnippet",
	}, {
		t({ "\\sage{round(" }),
		i(1),
		t({ ").n(), " }),
		i(2, "2"),
		t({ ") \\unit{" }),
		i(3),
		t({ "} " }),
	}),
	s({
		trig = "ui",
		name = "unit",
		snippetType = "autosnippet",
	}, {
		t({ "\\unit{" }),
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
		t({ "}{" }),
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
		trig = "sympy",
		name = "sympyblock",
		snippetType = "snippet",
	}, {
		t({ "sympy " }),
		d(1, get_visual),
		t({ " sympy" }),
	}),
	s({
		trig = "sympy(.*)sympy",
		name = "sympy",
		snippetType = "snippet",
		priority = 100000,
		regTrig = true,
		wordTrig = false,
	}, {
		f(function(_, snip)
			-- Capture the expression inside "sympy ... sympy"
			local expression = snip.captures[1]

			-- Prepare the sympy expression in Python code
			local python_code = string.format(
				[=[
from sympy import *
x, y, z, t = symbols('x y z t')
k, m, n = symbols('k m n', integer=True)
f, g, h = symbols('f g h', cls=Function)
init_printing()
try:
    result = latex(eval('%s'))
    print(result)
except Exception as e:
    print("Error:", e)
]=],
				expression:gsub("\\", ""):gsub("%^", "**"):gsub("{", "("):gsub("}", ")")
			)

			-- Execute the Python code
			local handle = io.popen('python3 -c "' .. python_code:gsub('"', '\\"') .. '"')
			local result = handle:read("*a") -- Capture the output
			handle:close()

			-- Trim any leading/trailing whitespace
			result = result:gsub("^%s*(.-)%s*$", "%1")

			return result ~= "" and result or "Error: No output from sympy"
		end, {}),
		i(0), -- Final cursor position
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
		trig = "taylor",
		name = "taylor",
		snippetType = "snippet",
	}, {
		t("\\sum_{"),
		i(1, "k"),
		t(" = "),
		i(2, "0"),
		t("}^{"),
		i(3, "\\infty"),
		t("} "),
		i(4, "c_"),
		rep(1),
		t(" (x-a)^"),
		rep(1),
		t(" "),
	}),
	s({
		trig = "taylors",
		name = "taylor variation",
		snippetType = "snippet",
	}, {
		t("\\sum_{"),
		i(1, "k"),
		t(" = "),
		i(2, "0"),
		t("}^{"),
		i(3, "\\infty"),
		t("} \\frac{"),
		i(4, "f^{("),
		rep(1),
		t(")}(x_0)}{"),
		rep(1),
		t("!} (x-x_0)^"),
		rep(1),
		t(" "),
	}),
	s({
		trig = "ekin",
		name = "kinetic energy",
		snippetType = "autosnippet",
	}, {
		t("\\frac{1}{2} \\cdot "),
		i(1, "m"),
		t(" \\cdot \\left( "),
		i(2, "v"),
		t(" \\right)^2 "),
	}),
	s({
		trig = "1dif",
		name = "solution to inhomogenous 1. order diffferential equation",
		snippetType = "snippet",
	}, {
		t({ "%dy/dx + P(x)y = Q(x) \\ v(x) = e^{\\int P(x) \\, dx}", "y = e^{-\\int " }),
		i(1, "P(x)"),
		t(" \\, \\mathrm{d}x} \\left( \\int e^{\\int "),
		rep(1),
		t(" \\, \\mathrm{d}x} "),
		i(2, "Q(x)"),
		t(" \\, \\mathrm{d}x + "),
		i(3, "C"),
		t(" \\right) "),
	}),
	s({
		trig = "2dif",
		name = "2. order homogenous differential equation",
		snippetType = "snippet",
	}, {
		t({ "P(x)y'' + Q(x)y' + R(x)y = 0" }),
	}),
	s({
		trig = "2difi",
		name = "2. order inhomogenous differential equation",
		snippetType = "snippet",
	}, {
		t({ "P(x)y'' + Q(x)y' + R(x)y = " }),
		i(1, "G(x)"),
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
		trig = "tsp",
		name = "thin space",
		snippetType = "autosnippet",
	}, {
		t("\\. "),
	}),
	s({
		trig = "hsp",
		name = "half space",
		snippetType = "autosnippet",
	}, {
		t("\\, "),
	}),
	s({
		trig = "qq",
		name = "qquad",
		snippetType = "autosnippet",
		wordTrig = false,
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
		trig = "ekons",
		name = "energikonservation",
		snippetType = "autosnippet",
		condition = function()
			return vim.fn["vimtex#syntax#in_mathzone"]() == 1
		end,
	}, {
		t("k_{0} + U_{0} = k_{1} + U_{1}"),
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
  s({
    trig = "()",
    name = "parenthesis jump",
    snippetType = "autosnippet",
  }, {
    t("("),
    i(1),
    t(")"),
  }),
})

