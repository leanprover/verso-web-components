/-
Copyright (c) 2025 Lean FRO LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Author: Sofia Rodrigues
-/
import VersoBlog

import LeanUI.Theme.Archive
import LeanUI.Theme.Category
import LeanUI.Theme.Primary
import LeanUI.Theme.Post
import LeanUI.Theme.Page
import LeanUI.Theme.Css

namespace LeanUI

open Verso Genre Blog
open LeanUI Components

/--
The main theme of the lean-lang.org website.
-/
def theme (config : LeanUI.Theme.SiteConfig) (layoutConfig : LeanUI.Theme.LayoutConfig) (navBar : TemplateM NavBarConfig) (footer : TemplateM FooterConfig) : Theme where
  primaryTemplate := LeanUI.Theme.primaryTemplate config .empty navBar footer
  pageTemplate := LeanUI.Theme.pageTemplate layoutConfig
  postTemplate := LeanUI.Theme.postTemplate layoutConfig.postConfig
  archiveEntryTemplate := LeanUI.Theme.archiveEntry
  categoryTemplate := LeanUI.Theme.categoryTemplate

end LeanUI
