"""
Lean 4 ile Modern Mantık — kitaba özel Pygments sözcük çözümleyicisi.

Pygments'in yerleşik Lean 4 çözümleyicisi taktikleri ve hipotez adlarını
ayırt etmez. Bu çözümleyici, kitabın renk dilini desteklemek için
şu ayrımları yapar:

    Keyword          anahtar kelimeler       (mor)
    Name.Builtin     taktikler               (pembe)
    Keyword.Type     Prop, Type, Nat ...     (camgöbeği)
    Name.Variable    hipotez adları (h, hp…) (turuncu)
    Name.Decorator   #check, #eval ...       (koyu mor)
    Operator         → ∧ ∨ ¬ ⊢ ...           (mavi)
    Name.Tag         ⟨ ⟩                     (mor)
    Comment          yorumlar                (yeşil, italik)

minted ile kullanım:  \\begin{minted}{stil/leankitap.py:LeanKitapLexer -x}
"""

import re
from pygments.lexer import RegexLexer, words, include
from pygments.token import (Comment, Keyword, Name, Number, Operator,
                            Punctuation, String, Text, Whitespace)

__all__ = ["LeanKitapLexer"]

KEYWORDS = (
    "theorem", "lemma", "def", "example", "fun", "by", "have", "show", "from",
    "let", "in", "match", "with", "structure", "inductive", "where",
    "namespace", "end", "section", "variable", "open", "import", "if", "then",
    "else", "do", "calc", "at", "deriving", "instance", "class", "axiom",
    "noncomputable", "universe", "abbrev", "private", "protected", "mutual",
)

TACTICS = (
    "intro", "intros", "apply", "exact", "rfl", "constructor", "cases",
    "induction", "simp", "rw", "assumption", "refine", "left", "right",
    "obtain", "rcases", "rintro", "exfalso", "contradiction", "trivial",
    "by_contra", "by_cases", "unfold", "decide", "omega", "sorry", "exists",
    "use", "ext", "funext", "specialize", "revert", "clear", "subst",
    "repeat", "first", "try", "all_goals", "any_goals", "aesop",
    "And.intro", "And.left", "And.right", "Or.inl", "Or.inr", "Or.elim",
    "absurd", "Classical.em", "Iff.intro", "Iff.mp", "Iff.mpr",
    "False.elim", "Exists.intro",
    "ring", "linarith", "norm_num", "positivity", "tauto", "ext",
    "exact?", "apply?", "nlinarith", "simp_all", "field_simp",
)

TYPES = ("Prop", "Type", "Sort", "Nat", "Bool", "True", "False", "String",
         "And", "Or", "Not", "Iff", "Int", "List", "Eq", "Exists",
         "Set", "Finset", "Real", "ℕ", "ℤ", "ℝ", "Equivalence")

COMMANDS = ("#check", "#eval", "#print", "#reduce", "#print axioms")

# Hipotez adları: h, h1, h₁, hp, hpq, hnp ... ve kitaptaki tek harfli p
HYPOTHESIS = r"(?:h[a-z]{0,4}[0-9₀-₉']*|p)(?![\w'.])"

IDENT_START = r"[^\W\d]"
IDENT_REST = r"[\w'.!?₀-₉]*"

SYMBOLS = "→←↔↦⊢∘∧∨¬∀∃×≠≤≥∣⁻¹•·▸∈∉⊆⊂∪∩ᶜ∅∑∏√λΠΣ∼!"

# Kod yazı tipinde (DejaVu Sans Mono) bulunmayan semboller: ayrı bir
# token sınıfıyla işaretlenir; LaTeX tarafı bunları başka bir yazı tipiyle basar.
OZEL_SEMBOLLER = "⋀⋁⟹⊨"


class LeanKitapLexer(RegexLexer):
    name = "LeanKitap"
    aliases = ["leankitap"]
    filenames = []
    flags = re.MULTILINE | re.UNICODE

    tokens = {
        "root": [
            (r"\s+", Whitespace),
            (r"/-", Comment.Multiline, "yorum"),
            (r"--.*?$", Comment.Single),
            (r'"(\\\\|\\"|[^"])*"', String.Double),
            (words(COMMANDS, suffix=r"\b"), Name.Decorator),
            (words(KEYWORDS, prefix=r"(?<![\w'.])", suffix=r"(?![\w'.])"), Keyword),
            (words(TACTICS, prefix=r"(?<![\w'.])", suffix=r"(?![\w'])"), Name.Builtin),
            (words(TYPES, prefix=r"(?<![\w'.])", suffix=r"(?![\w'.])"), Keyword.Type),
            (r"(?<![\w'.])" + HYPOTHESIS, Name.Variable),
            ("[" + OZEL_SEMBOLLER + "]", Name.Other),
            (r"[⟨⟩]", Name.Tag),
            (r":=|=>|<;>|\||&&|\|\|", Operator),
            ("[" + SYMBOLS + "]", Operator),
            (r"\d+", Number.Integer),
            (IDENT_START + IDENT_REST, Name),
            (r"[()\[\]{},:;]", Punctuation),
            (r"[+\-*/=<>%^&@$~`]", Operator),
            (r".", Text),
        ],
        "yorum": [
            (r"[^/-]+", Comment.Multiline),
            (r"/-", Comment.Multiline, "#push"),
            (r"-/", Comment.Multiline, "#pop"),
            (r"[/-]", Comment.Multiline),
        ],
    }


_OZEL_RE = re.compile("([" + OZEL_SEMBOLLER + "])")


def _bol(lexer_cls):
    """Yorum ve dizgilerin içindeki özel sembolleri de ayrı token yapar."""
    asil = lexer_cls.get_tokens_unprocessed

    def get_tokens_unprocessed(self, text, *args, **kwargs):
        for index, token, value in asil(self, text, *args, **kwargs):
            if token is not Name.Other and _OZEL_RE.search(value):
                konum = index
                for parca in _OZEL_RE.split(value):
                    if not parca:
                        continue
                    yield konum, (Name.Other if _OZEL_RE.fullmatch(parca) else token), parca
                    konum += len(parca)
            else:
                yield index, token, value

    lexer_cls.get_tokens_unprocessed = get_tokens_unprocessed
    return lexer_cls


_bol(LeanKitapLexer)
