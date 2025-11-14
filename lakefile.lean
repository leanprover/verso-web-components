import Lake
open Lake DSL

require verso from git "https://github.com/leanprover/verso" @ "main"
require subverso from git "https://github.com/leanprover/subverso" @ "main"

package versowebcomponents where
  moreLeancArgs := #["-O0"]
  moreLinkArgs :=
    if System.Platform.isOSX then
      #["-Wl,-ignore_optimization_hints"]
    else #[]

@[default_target]
lean_lib VersoWeb where
