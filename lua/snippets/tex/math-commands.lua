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

-- [
-- personal imports
-- ]
local tex = require("snippets.tex.utils.conditions")
local auto_backslash_snippet = require("snippets.tex.utils.scaffolding").auto_backslash_snippet
local symbol_snippet = require("snippets.tex.utils.scaffolding").symbol_snippet
local single_command_snippet = require("snippets.tex.utils.scaffolding").single_command_snippet
local postfix_snippet = require("snippets.tex.utils.scaffolding").postfix_snippet

-- fractions (parentheses case)
local generate_fraction = function (_, snip)
    local stripped = snip.captures[1]
    local depth = 0
    local j = #stripped
    while true do
        local c = stripped:sub(j, j)
        if c == "(" then
            depth = depth + 1
        elseif c == ")" then
            depth = depth - 1
        end
        if depth == 0 then
            break
        end
        j = j - 1
    end
    return sn(nil,
        fmta([[
        <>\frac{<>}{<>}
        ]],
        { t(stripped:sub(1, j-1)), t(stripped:sub(j)), i(1)}))
end

M = {
    -- superscripts
    autosnippet({ trig = "sr", wordTrig = false },
    { t("^2") },
    { condition = tex.in_math, show_condition = tex.in_math }),
	autosnippet({ trig = "cb", wordTrig = false },
    { t("^3") },
    { condition = tex.in_math, show_condition = tex.in_math }),
	autosnippet({ trig = "inv", wordTrig = false },
    { t("^{-1}") },
    { condition = tex.in_math, show_condition = tex.in_math }),
  autosnippet({ trig = "ps", wordTrig = false },
    { t("s^{-1}") },
    { condition = tex.in_math, show_condition = tex.in_math }),

    autosnippet({ trig = "tit", name = "text italics" },
    fmta([[
    \textit{<>}<>
    ]],
    { i(1), i(0) })),

    autosnippet({ trig = "tbf", name = "bold text" },
    fmta([[
    \textbf{<>}<>
    ]],
    { i(1), i(0) })),

    -- fractions
    autosnippet({ trig='//', name='fraction', dscr="fraction (general)"},
    fmta([[
    \frac{<>}{<>}<>
    ]],
    { i(1), i(2), i(0) }),
    { condition = tex.in_math, show_condition = tex.in_math }),

    autosnippet({
    trig = "(\\d+|[A-Za-z]+|\\\\[A-Za-z]+)/", name = 'fraction', dscr = 'auto fraction 1', trigEngine = "ecma"},
    fmta([[
      \frac{<>}{<>}<>
    ]],
    {
      f(function(_, snip)
          return snip.captures[1] or ""
      end),
      i(1),
      i(0),
    }),
    { condition = tex.in_math, show_condition = tex.in_math }),

    autosnippet({ trig='(^.*\\))/', name='fraction', dscr='auto fraction 2', trigEngine="ecma" },
    { d(1, generate_fraction) },
    { condition=tex.in_math, show_condition=tex.in_math }),

	autosnippet({ trig = "lim", name = "lim(sup|inf)", dscr = "lim(sup|inf)" },
    fmta([[ 
    \lim<><><>
    ]],
	{c(1, { t(""), t("sup"), t("inf") }),
	c(2, { t(""), fmta([[_{<> \to <>}]], { i(1, "n"), i(2, "\\infty") }) }),
	i(0)}),
	{ condition = tex.in_math, show_condition = tex.in_math }),

	autosnippet({ trig = "dsum", name = "summation", dscr = "summation" },
	fmta([[
    \sum<> <>
    ]],
    { c(1, {fmta([[_{<>}^{<>}]], {i(1, "i = 0"), i(2, "\\infty")}), t("")}), i(0) }),
    { condition = tex.in_math, show_condition = tex.in_math }),

	autosnippet({ trig = "prod", name = "product", dscr = "product" },
    fmta([[
    \prod<> <>
    ]],
	{ c(1, {fmta([[_{<>}^{<>}]], {i(1, "i = 0"), i(2, "\\infty")}), t("")}), i(0) }),
	{ condition = tex.in_math, show_condition = tex.in_math }),

  autosnippet({ trig='part', name='partial', dscr='partial derivative'},
  fmta([[
  \frac{\partial <>}{\partial <>}<>
  ]],
  { i(1), i(2), i(0) }),
  { condition = tex.in_math, show_condition = tex.in_math }),

  autosnippet({ trig = "([A-Za-z])bar", name = "bar", dscr = "letterbar", regTrig = true},
  fmta([[\overline{<>}]], {
    f(function(_, snip)
      return snip.captures[1]
    end)
  }),
  { condition = tex.in_math, show_condition = tex.in_math }),
}

-- Auto backslashes
local auto_backslash_specs = {
	"arcsin",
	"sin",
	"arccos",
	"cos",
	"arctan",
	"tan",
	"cot",
	"csc",
	"sec",
	"log",
	"ln",
	"exp",
  "sum",
}

local auto_backslash_snippets = {}
for _, v in ipairs(auto_backslash_specs) do
    table.insert(auto_backslash_snippets, auto_backslash_snippet({ trig = v }, { condition = tex.in_math }))
end
vim.list_extend(M, auto_backslash_snippets)

-- Symbols/Commands
local greek_specs = {
	alpha = { context = { name = "α" }, command = [[\alpha]], trig = ";a" },
	beta = { context = { name = "β" }, command = [[\beta]], trig = ";b" },
	gam = { context = { name = "γ" }, command = [[\gamma]], trig = ";g"},
	Gam = { context = { name = "Γ" }, command = [[\Gamma]], trig = ";G" },
	delta = { context = { name = "δ" }, command = [[\delta]], trig = ";d"},
	DD = { context = { name = "Δ" }, command = [[\Delta]], trig = ";D"},
	eps = { context = { name = "ε" }, command = [[\epsilon]], trig = ";ep" },
  veps = { context = { name = "ε" }, command = [[\varepsilon]], trig = ";vep" },
  zeta = { context = { name = "ζ" }, command = [[\zeta]], trig = ";z"},
	eta = { context = { name = "η" }, command = [[\eta]], trig = ";et"},
	theta = { context = { name = "θ" }, command = [[\theta]], trig = ";th"},
	Theta = { context = { name = "Θ" }, command = [[\Theta]], trig = ";Th"},
	iota = { context = { name = "ι" }, command = [[\iota]], trig = ";i"},
	kappa = { context = { name = "κ" }, command = [[\kappa]], trig = ";k"},
	lmbd = { context = { name = "λ" }, command = [[\lambda]], trig = ";l"},
	Lmbd = { context = { name = "Λ" }, command = [[\Lambda]], trig = ";L"},
	mu = { context = { name = "μ" }, command = [[\mu]], trig = ";m"},
	nu = { context = { name = "ν" }, command = [[\nu]], trig = ";n"},
  xi = { context = { name = "ξ" }, command = [[\xi]], trig = ";xi"},
	pi = { context = { name = "π" }, command = [[\pi]], trig = ";pi"},
	rho = { context = { name = "ρ" }, command = [[\rho]], trig = ";r"},
	sig = { context = { name = "σ" }, command = [[\sigma]], trig = ";s"},
	Sig = { context = { name = "Σ" }, command = [[\Sigma]], trig = ";S"},
  tau = { context = { name = "τ" }, command = [[\tau]], trig = ";ta"},
	ups = { context = { name = "υ" }, command = [[\upsilon]], trig = ";u"},
  phi = { context = { name = "φ" }, command = [[\phi]], trig = ";ph"},
  vphi = { context = { name = "φ" }, command = [[\varphi]], trig = ";vf"},
  chi = { context = { name = "χ" }, command = [[\chi]], trig = ";c"},
	psi = { context = { name = "Ψ" }, command = [[\psi]], trig = ";ps"},
	omega = { context = { name = "ω" }, command = [[\omega]], trig = ";o"},
	Omega = { context = { name = "Ω" }, command = [[\Omega]], trig = ";O"},
}

local greek_snippets = {}
for k, v in pairs(greek_specs) do
    -- Use the specified trigger in `trig` or fall back to a dynamic first-letter trigger if not defined.
    local trig = v.trig or (";" .. k:sub(1, 1))
	table.insert(
		greek_snippets,
		symbol_snippet(vim.tbl_deep_extend("keep", { trig = trig }, v.context), v.command, { backslash = true, wordTrig = false })
	)
end
vim.list_extend(M, greek_snippets)

local symbol_specs = {
	-- operators
	["!="] = { context = { name = "!=" }, command = [[\neq ]] },
  ["fc"] = { context = { name = "!" }, command = [[!]] },
	["<="] = { context = { name = "≤" }, command = [[\leq ]] },
	[">="] = { context = { name = "≥" }, command = [[\geq ]] },
	["<<"] = { context = { name = "<<" }, command = [[\ll ]] },
	[">>"] = { context = { name = ">>" }, command = [[\gg ]] },
	["~~"] = { context = { name = "~" }, command = [[\sim]] },
	["~="] = { context = { name = "≈" }, command = [[\approx]] },
	[":="] = { context = { name = "≔" }, command = [[\definedas]] },
	["**"] = { context = { name = "·", priority = 100 }, command = [[\cdot ]] },
	xx = { context = { name = "×" }, command = [[\times]] },
	NN = { context = { name = "ℕ" }, command = [[\mathbb{N}]] },
	ZZ = { context = { name = "ℤ" }, command = [[\mathbb{Z}]] },
	QQ = { context = { name = "ℚ" }, command = [[\mathbb{Q}]] },
	RR = { context = { name = "ℝ" }, command = [[\mathbb{R}]] },
	CC = { context = { name = "ℂ" }, command = [[\mathbb{C}]] },
  ll = { context = { name = "ell"}, command = [[\ell]] },
	["::"] = { context = { name = ":" }, command = [[\colon]] },
	-- quantifiers and logic stuffs
	AA = { context = { name = "∀" }, command = [[\forall]] },
	EE = { context = { name = "∃" }, command = [[\exists]] },
	inn = { context = { name = "∈" }, command = [[\in]] },
	notin = { context = { name = "∉" }, command = [[\not\in]] },
	["!-"] = { context = { name = "¬" }, command = [[\lnot]] },
	VV = { context = { name = "∨" }, command = [[\lor]] },
	WW = { context = { name = "∧" }, command = [[\land]] },
    ["!W"] = { context = { name = "∧" }, command = [[\bigwedge]] },
	["=>"] = { context = { name = "⇒" }, command = [[\implies]] },
	["=<"] = { context = { name = "⇐" }, command = [[\impliedby]] },
	iff = { context = { name = "⟺" }, command = [[\iff]] },
	["->"] = { context = { name = "→", priority = 250 }, command = [[\to]] },
	["!>"] = { context = { name = "↦" }, command = [[\mapsto]] },
	["<-"] = { context = { name = "↦", priority = 250}, command = [[\gets]] },
    -- differentials 
	dp = { context = { name = "⇐" }, command = [[\partial]] },
	-- arrows
	["-->"] = { context = { name = "⟶", priority = 500 }, command = [[\longrightarrow]] },
	["<->"] = { context = { name = "↔", priority = 500 }, command = [[\leftrightarrow]] },
	["2>"] = { context = { name = "⇉", priority = 400 }, command = [[\rightrightarrows]] },
	upar = { context = { name = "↑" }, command = [[\uparrow]] },
	dnar = { context = { name = "↓" }, command = [[\downarrow]] },
	-- etc
	ooo = { context = { name = "∞" }, command = [[\infty]] },
	["+-"] = { context = { name = "†" }, command = [[\pm]] },
	["-+"] = { context = { name = "†" }, command = [[\mp]] },
  ["Ã"] = { context = { name = "tilde A" }, command = [[\tilde{A}]]},
}

local symbol_snippets = {}
for k, v in pairs(symbol_specs) do
	table.insert(
		symbol_snippets,
		symbol_snippet(vim.tbl_deep_extend("keep", { trig = k }, v.context), v.command, { condition = tex.in_math })
	)
end
vim.list_extend(M, symbol_snippets)

local single_command_math_specs = {
	tt = {
		context = {
			name = "text (math)",
			dscr = "text in math mode",
		},
		command = [[\text]],
	},
	mit = {
		context = {
			name = "mathit",
			dscr = "italic math text",
		},
		command = [[\mathit]],
	},
	mud = {
		context = {
			name = "underline (math)",
			dscr = "underlined text in math mode",
		},
		command = [[\underline]],
	},
	conj = {
		context = {
			name = "conjugate",
			dscr = "conjugate (overline)",
		},
		command = [[\overline]],
	},
	["__"] = {
		context = {
			name = "subscript",
			dscr = "auto subscript 3",
			wordTrig = false,
		},
		command = [[_]],
	},
	td = {
		context = {
			name = "superscript",
			dscr = "auto superscript alt",
			wordTrig = false,
		},
		command = [[^]],
	},
	sbt = {
		context = {
			name = "substack",
			dscr = "substack for sums/products",
		},
		command = [[\substack]],
	},
	sq = {
		context = {
			name = "sqrt",
			dscr = "sqrt",
		},
		command = [[\sqrt]],
		ext = { choice = true },
	},
}

local single_command_math_snippets = {}
for k, v in pairs(single_command_math_specs) do
	table.insert(
		single_command_math_snippets,
		single_command_snippet(
			vim.tbl_deep_extend("keep", { trig = k, snippetType = "autosnippet" }, v.context),
			v.command,
			{ condition = tex.in_math },
			v.ext or {}
		)
	)
end
vim.list_extend(M, single_command_math_snippets)

local postfix_math_specs = {
    mbb = {
        context = {
            name = "mathbb",
            dscr =  "math blackboard bold",
        },
        command = {
            pre = [[\mathbb{]],
            post = [[}]],
        }
    },
    mcal = {
        context = {
            name = "mathcal",
            dscr =  "math calligraphic",
        },
        command = {
            pre = [[\mathcal{]],
            post = [[}]],
        }
    },
    mrm = {
      context = {
            name = "mathrm",
            dscr = "math roman style",
        },
        command = {
            pre = [[\mathrm{]],
            post = [[}]],
        }
    },
    mscr = {
        context = {
            name = "mathscr",
            dscr =  "math script",
        },
        command = {
            pre = [[\mathscr{]],
            post = [[}]],
        },
    },
    mfr = {
        context = {
            name = "mathfrak",
            dscr =  "mathfrak",
        },
        command = {
            pre = [[\mathfrak{]],
            post = [[}]],
        },
    },
    hat = {
		context = {
			name = "hat",
			dscr = "hat",
		},
		command = {
            pre = [[\hat{]],
            post = [[}]],
        }
    },
    vec = {
      context = {
        name = "vec",
        dscr = "vec",
      },
      command = {
          pre = [[\Vec{]],
          post = [[}]]
        }
    },
    tld = {
      context = {
        name = "tilde",
              priority = 500,
        dscr = "tilde",
      },
      command = {
              pre = [[\tilde{]],
              post = [[}]]
          }
    },
    dot = {
      context = {
        name = "dot",
        dscr = "dot",
    },
    command = {
            pre = [[\dot{]],
            post = [[}]],
          }
    },
    det = {
      context = {
        name = "determinant",
        dscr = "upright determinant operator",
    },
    command = {
            pre = [[\mathrm{det}(]],
            post = [[)]],
          }
    },
}

local postfix_math_snippets = {}
for k, v in pairs(postfix_math_specs) do
table.insert(
    postfix_math_snippets,
    postfix_snippet(
        vim.tbl_deep_extend("keep", { trig = k, snippetType = "autosnippet" }, v.context),
        v.command,
        { condition = tex.in_math }
    )
)
end
vim.list_extend(M, postfix_math_snippets)

return M
