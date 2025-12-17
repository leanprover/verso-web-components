namespace Verso.Web.Theme.Static

def dark.js := include_str "../../static/js/dark.js"

def reset.css := include_str "../../static/css/reset.css"

def layout.css := include_str "../../static/css/layout.css"

def navbar.css := include_str "../../static/css/navbar.css"

def footer.css := include_str "../../static/css/footer.css"

def theme.css := include_str "../../static/css/theme.css"

def article.css := include_str "../../static/css/article.css"

def card.css := include_str "../../static/style/card.css"

def allCSS := #[
  ("reset.css", reset.css),
  ("layout.css", layout.css),
  ("navbar.css", navbar.css),
  ("footer.css", footer.css),
  ("theme.css", theme.css),
  ("article.css", article.css),
  ("card.css", card.css)
]
