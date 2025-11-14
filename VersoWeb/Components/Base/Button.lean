/-
Copyright (c) 2025 Lean FRO, LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sofia Rodrigues
-/
import VersoWeb.Components.Icon

namespace Verso.Web.Components

open Lean Verso Output Html Genre Blog Template

inductive Button.Style
  | primary
  | secondary
deriving ToJson, FromJson

instance : ToString Button.Style where
  toString
    | .primary => "primary"
    | .secondary => "secondary"

def button [MonadStateOf Component.State m] [Monad m] (style : Button.Style) (href : String) (content : Html) (inverted : Bool := false) : m Html := do
    saveCss (include_str "../../static/style/button.css")

    let invertedClass :=  if inverted then " inverted" else ""

    return {{
      <a class={{s!"button {toString style}{invertedClass}"}} href={{href}}>
        {{ content }}
      </a>
    }}

end Verso.Web.Components
