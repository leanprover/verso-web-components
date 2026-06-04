/-
Copyright (c) 2025 Lean FRO LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sofia Rodrigues
-/
import VersoBlog
import VersoWeb.Util.Svg

open Verso Genre Blog ArgParse Doc Elab
open Verso.Genre Blog Theme Template
open Verso.Output Html
open Verso.Web.Util

namespace Verso.Web.Components

block_component +directive readingTime (time : String) where
  cssFiles := #[("reading-time.css", include_str "../../static/style/reading-time.css")]

  toHtml _ _ _ _ _ := do
    return {{
      <span class="reading-time">
        {{ svg("../../static/svg/clock.svg") }}
        {{ time }}
      </span>
    }}

end Verso.Web.Components
