namespace Verso.Web.Theme.Static

def «motion-prefs».js := include_str "../../static/js/motion-prefs.js"

def dark.js := include_str "../../static/js/dark.js"

def theme.js := include_str "../../static/js/theme.js"

def copy.js := include_str "../../static/js/copy.js"

def motion.js := include_str "../../static/js/motion.js"

def navbar.js := include_str "../../static/js/navbar.js"

def reset.css := include_str "../../static/css/reset.css"

def navbar.css := include_str "../../static/css/navbar.css"

def theme.css := include_str "../../static/css/theme.css"

def footer.css := include_str "../../static/css/footer.css"

def layout.css := include_str "../../static/css/layout.css"

def article.css := include_str "../../static/css/article.css"

def motion.css := include_str "../../static/css/motion.css"

def card.css := include_str "../../static/style/card.css"

def «copy-button».css := include_str "../../static/style/copy-button.css"

def allCSS := #[
  ("reset.css", reset.css),
  ("layout.css", layout.css),
  ("navbar.css", navbar.css),
  ("footer.css", footer.css),
  ("theme.css", theme.css),
  ("article.css", article.css),
  ("card.css", card.css),
  ("copy-button.css", «copy-button».css),
  -- Last, so its `!important` overrides land on top of every rule above.
  ("motion.css", motion.css)
]

def allJS := #[
  -- First: it sets the `reduce-motion` / `low-power` classes on <html> that the
  -- stylesheets and every script below read, and these are blocking <head>
  -- scripts, so this runs before the first paint.
  ("motion-prefs.js", «motion-prefs».js),
  ("dark.js", dark.js),
  ("theme.js", theme.js),
  ("copy.js", copy.js),
  ("motion.js", motion.js),
  ("navbar.js", navbar.js),
]
