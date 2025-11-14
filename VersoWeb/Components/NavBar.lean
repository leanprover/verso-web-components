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

/-!
# Navigation Bar Component

This component renders the navigation bar for the website, including both desktop and mobile views.
-/

/--
Structure representing a single navigation item
-/
structure NavBarItem where
  /--
  Item title
  -/
  title : Html

  /--
  Optional URL for the item
  -/
  url : Option String := none

  /--
  Whether this item is currently active
  -/
  active : Bool := false

  /--
  Optional alt text for accessibility
  -/
  alt : Option String := none

  /--
  Optional CSS classes
  -/
  classes : Option String := none

  /--
  Whether to open link in new tab
  -/
  blank := false
deriving Repr

/--
Configuration for the sub-navigation bar
-/
structure SubNavBarConfig where
  /--
  Menu items for the sub-navigation
  -/
  menuItems : Array NavBarItem
deriving Inhabited

/--
Configuration for the navigation bar
-/
structure NavBarConfig where
  /--
  Left-side navigation items
  -/
  leftItems : Array NavBarItem

  /--
  Right-side navigation items
  -/
  rightItems : Array NavBarItem

  /--
  Mobile menu items
  -/
  menuItems : Array NavBarItem

  /--
  External links
  -/
  externalLinks : Array NavBarItem

  /--
  Sub navbar
  -/
  subNavBar : Option SubNavBarConfig
deriving Inhabited

namespace NavBar

/--
Render the Lean logo
-/
private def renderLogo : Html :=
  {{ <a class="nav-logo" href="/"> {{ Icon.leanLogo "#386EE0" (some 70) (some 20) (strokeWidth := 10) }} </a> }}

/--
Render the FRO logo
-/
private def renderFroLogo : Html :=
  {{ <a class="nav-logo" href="/fro"> {{ Icon.froLogo "#386EE0" (some 70) (some 20) (strokeWidth := 10) }}  </a> }}

/--
Render a single navigation item
-/
private def renderItem (item : NavBarItem) : Html :=
  let classes := item.classes.map (s!" {·}") |>.getD ""

  {{
    <li class=s!"nav-item{ if item.active then " active" else ""}">
      {{
        if let some url := item.url then
          {{ <a href={{url}} class=s!"nav-link{classes}" aria-label={{item.alt.getD ""}} target={{if item.blank then "_blank" else "_self"}}>{{item.title}}</a>}} else
          {{ <button class=s!"nav-link{classes}" aria-label={{item.alt.getD ""}}> {{ item.title }} </button> }}
      }}
    </li>
  }}

/--
Render the sub-navigation bar
-/
def renderSub [MonadStateOf Component.State m] [Monad m] (config : SubNavBarConfig) : m Html := do
  return {{
    <nav class="sub-navbar">
      <div class="navbar-container container">
        {{ renderFroLogo }}

        <ul class="nav-list">
          {{ config.menuItems.map renderItem }}
        </ul>
      </div>
    </nav>
  }}

/--
Render the complete navigation bar
-/
def render [MonadStateOf Component.State m] [Monad m] (config : NavBarConfig) : m Html := do
  return {{
    <nav class="navbar" role="navigation" aria-label="Primary navigation">
      <div class="navbar-container container">
        {{ renderLogo }}

        -- The mobile toggle button.
        <div class="nav-toggle">
            <input type="checkbox" id="nav-toggle" class="nav-toggle-checkbox" />
            <label for="nav-toggle" class="nav-toggle-label" aria-label="Toggle navigation menu">"☰"</label>
        </div>

        -- The desktop navigation menu.
        <menu class="desktop-menu">
          <ul class="desktop-menu-part">
            {{ config.leftItems.map renderItem }}
            <li><span class="divider" /></li>
            {{ config.externalLinks.map renderItem }}
          </ul>
          <ul class="desktop-menu-part">
            {{ config.rightItems.map renderItem }}
          </ul>
        </menu>
      </div>

      -- The mobile navigation menu.
      <menu class="mobile-nav">
        <ul class="nav-list">
          {{ (config.leftItems.pop).map renderItem }}
          {{ (config.externalLinks.pop).map renderItem }}
          <li class="nav-item has-submenu">
            <input type="checkbox" id="fro-toggle" class="fro-toggle-checkbox" hidden="true" />
            <label for="fro-toggle" class="nav-link" aria-label="Toggle navigation menu">"FRO"</label>
            <ul class="submenu">
              {{ config.menuItems.map renderItem }}
            </ul>
          </li>
        </ul>
      </menu>
    </nav>

    {{ ← if let some res := config.subNavBar then renderSub res else pure .empty }}
  }}

end Verso.Web.Components.NavBar
