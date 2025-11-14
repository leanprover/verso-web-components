/-
Copyright (c) 2025 Lean FRO, LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sofia Rodrigues
-/
import Lean
import Verso.Doc.Html

namespace Verso.Web.Util

open Verso.Output Html
open Lean Elab Term IO Meta PrettyPrinter Delaborator SubExpr

syntax "svg(" str ")" : term

elab "svg(" filePath: str ")" : term => do
  let content ← FS.readFile filePath.getString
  let env ← getEnv

  let .ok stx := Parser.runParserCategory env `html content
    | throwError "Failed to parse SVG file: {filePath.getString}"

  let stx := ⟨stx⟩

  elabTerm (← `({{ $stx }})) none

end Verso.Web.Util
