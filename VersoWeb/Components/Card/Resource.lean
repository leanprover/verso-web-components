/-
Copyright (c) 2025 Lean FRO, LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sofia Rodrigues
-/
import Verso.Doc.Html
import VersoBlog
import VersoWeb.Components.Icon
import Lean

namespace Verso.Web.Components

open Verso.Output Html
open Verso Genre Lean Blog Template

-- ── Card (icon + title + desc, no image) ─────────────────────────

inductive ButtonType
  | book
  | game
  | website
deriving FromJson, ToJson, Repr

structure Card where
  icon : Icon
  title : String
  desc : String
  url : String
  tags : Array String := #[]
  type : ButtonType
deriving Repr

def learnCard [MonadStateOf Component.State m] [Monad m] (card : Card) : m Html := do
  saveCss (include_str "../../../static/style/learn-card.css")
  return {{
    <article class="learn-card-article">
      <a href={{ card.url }} class="card-href card main-learn-card">
        <header class="card-icon-col">
          {{ card.icon }}
        </header>
        <div class="card-content-col">
          <p class="card-title">{{ card.title }}</p>
          <p class="card-description">{{ card.desc }}</p>
          <footer>
            {{
              if card.tags.isEmpty then .empty else
                {{ <div class="tags">
                  {{ card.tags.map fun tag =>
                      {{ <span class="item-tag">{{ .text true tag }}</span> }} }}
                </div> }}
            }}
            <div class="read-more">
              {{
                match card.type with
                | .book => "Read now"
                | .game => "Play now"
                | .website => "Open"
              }}
              {{ Icon.arrowForward (width := "17px") (fill := "var(--color-primary)") }}
            </div>
          </footer>
        </div>
      </a>
    </article>
  }}

def cardGrid [MonadStateOf Component.State m] [Monad m] (cards : Array Card) : m Html := do
  return {{
    <div class="card-grid custom-content">
      {{ ← cards.mapM (learnCard ·) }}
    </div>
  }}

-- ── ResourceCard (image + tags + title + desc) ───────────────────

structure ResourceCard where
  title : String
  desc : String
  url : String
  image : Option String := none
  alt : String := ""
  tags : Array String := #[]
deriving Repr

def resourceCard
    [MonadStateOf Component.State m]
    [Monad m]
    (card : ResourceCard) : m Html := do
  saveCss (include_str "../../../static/style/resource-card.css")
  return {{
    <article class="resource-card-article">
      <a href={{ card.url }} class="resource-card">
        {{
          match card.image with
          | some src => {{
              <div class="resource-card-image">
                <img src={{ src }} alt={{ card.alt }} />
              </div>
            }}
          | none => .empty
        }}
        <div class="resource-card-body">
          <div class="resource-card-content">
            {{
              if card.tags.isEmpty then .empty else
                {{ <div class="resource-card-tags">
                  {{ card.tags.map fun tag =>
                      {{ <span class="resource-card-tag">{{ .text true tag }}</span> }} }}
                </div> }}
            }}
            <p class="resource-card-title">{{ card.title }}</p>
            <p class="resource-card-description">{{ card.desc }}</p>
          </div>
          <div class="read-more">
            "Read more"
            {{ Icon.arrowForward (width := "17px") (fill := "var(--color-primary)") }}
          </div>
        </div>
      </a>
    </article>
  }}

def resourceCardGrid
    [MonadStateOf Component.State m]
    [Monad m]
    (cards : Array ResourceCard) : m Html := do
  return {{
    <div class="resource-card-grid custom-content">
      {{ ← cards.mapM (resourceCard ·) }}
    </div>
  }}

end Verso.Web.Components
