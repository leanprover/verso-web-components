/-
Copyright (c) 2025 Lean FRO LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sofia Rodrigues
-/
import Verso.Doc.Html
import VersoBlog
import VersoWeb.Components.Icon

namespace Verso.Web.Components

open Verso.Output Html
open Verso.Genre.Blog Template

block_component +directive modal (id : String) where
  toHtml _ _ _ goB contents := do
    saveCss (include_str "../../../static/style/modal.css")
    saveJs (include_str "../../../static/js/modal.js")

    -- The close button carries the multiplication sign itself. A string
    -- literal in this quotation is HTML-escaped, so writing the entity
    -- `&times;` reaches the page as that text rather than as `×`.
    return {{
      <div id={{id}} class="modal-backdrop hidden" data-modal="">
        <div class="modal">
          <button class="modal-close" aria-label="Close modal">"×"</button>
          <div class="modal-content">
            {{ ← contents.mapM goB }}
          </div>
        </div>
      </div>
    }}


end Verso.Web.Components
