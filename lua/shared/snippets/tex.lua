
return {

  s("begin", {
    t("\\begin{"), i(1, "environment"), t("}"), t({"", "\t"}),
    i(2, "content"),
    t({"", ""}),
    t("\\end{"), rep(1), t("}"),
  }),

  s("left()", {
    t("\\left("), i(1, "content"), t("\\right"),
  }),

  s("left[]", {
    t("\\left["), i(1, "content"), t("\\right"),
  }),

  s("frac", {
    t("\\frac{"),
    i(1, "num"),
    t("}{"),
    i(2, "den"),
    t("}"),
  }),

  s("boldtext", {
    t("\\textbf{"), i(1, "text"), t("}")
  }),

  s("bold", {
    t("\\mathbf{"), i(1, "text"), t("}")
  }),

  s("boldsym", {
    t("\\boldsymbol{"), i(1, "symbol"), t("}")
  }),

  s("eq", {
    t("&="), t({"", ""}),
  }),

  s("phantom", {
    t("\\phantom{.}"),
  }),

}
