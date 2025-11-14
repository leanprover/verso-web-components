/-
Copyright (c) 2025 Lean FRO, LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sofia Rodrigues
-/
import VersoWeb.Components.Icon

namespace Verso.Web.Components

open Lean Verso Output Html Genre Blog Template

block_component +directive notFound where
  toHtml _ _ _ _ _ := do
    saveCss (include_str "../../static/style/not-found.css")

    return {{
      <section class="404-container container active">
        <div class="error-container">
          <div>
            <div class="image-section">
              <img src="/static/png/hexapus-not.png" />
            </div>
          </div>
          <div class="text-section">
            <h1 class="error-title">"Oops! Page not found"</h1>
            <p class="error-description">
                "Looks like this page swam off into the digital ocean. Don’t worry, our hexapus has your back!"
            </p>
            <div class="action-buttons">
                <a href="/" class="button primary">
                  "Go Home"
                </a>
            </div>
          </div>
        </div>
      </section>
    }}

end Verso.Web.Components
