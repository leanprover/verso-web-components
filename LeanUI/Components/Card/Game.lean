/-
Copyright (c) 2025 Lean FRO, LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sofia Rodrigues
-/
import Verso.Doc.Html
import VersoBlog
import LeanUI.Components.Icon
import Lean

namespace LeanUI.Components

open Verso.Output Html
open Verso Genre Lean Blog Template

def gameCard [MonadStateOf Component.State m] [Monad m]  (card : Card) : m Html := do
  saveCss (include_str "../../../static/style/game-card.css")

  return {{
    <div class="card game-info card-item white-blue-gradient">
      <div class="game-container">
        <h4>"Natural Number Game"</h4>
        <p>"Learn Lean theorem proving with a fun, interactive, game-like experience that makes formalization accessible."</p>
        <a href="https://adam.math.hhu.de/#/g/leanprover-community/nng4" class="read-more">
          "Play now"
          {{ Icon.arrowForward (width := "17px") (fill := "var(--color-primary)") }}
        </a>
      </div>
      <img src="/static/png/nng.png" />
    </div>
  }}

end LeanUI.Components
