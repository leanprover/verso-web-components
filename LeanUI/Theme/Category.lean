/-
Copyright (c) 2025 Lean FRO LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sofia Rodrigues
-/
import Verso.Doc.Html
import VersoBlog
import LeanUI.Util

open Verso Genre Blog Template Output Html

namespace LeanUI.Theme

/--
Generic category template.
-/
def categoryTemplate : TemplateM Html := do
  return {{
    <div class=s!"main category-page" role="main">

      <section class="category-section container">
       <h1 class="category-title">
        {{ ← param "title"}}
       </h1>
        {{ (← param? "posts" : Option Html) }}
      </section>
    </div>
  }}

end LeanUI.Theme
