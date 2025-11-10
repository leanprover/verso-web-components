/-
Copyright (c) 2025 Lean FRO LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sofia Rodrigues
-/
import Verso.Doc.Html
import VersoBlog
import LeanUI.Components.ArchiveEntry

open Verso Genre Blog Template Output Html
open LeanUI.Components

namespace LeanUI.Theme

/--
Generic archive entry template.
-/
def archiveEntry : Template := do
  let post : BlogPost ← param "post"
  let summary : Html ← param "summary"

  let target ← if let some p := (← param? "path") then
      pure <| p ++ "/" ++ (← post.postName')
    else post.postName'

  let archiveEntry ← Components.archiveEntry target post.contents.metadata post.contents.titleString summary none
  return #[archiveEntry]

end LeanUI.Theme
