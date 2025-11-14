/-
Copyright (c) 2025 Lean FRO, LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sofia Rodrigues
-/
import VersoBlog

open Verso Genre Blog Lean Output Html Template

namespace Verso.Web.Components

structure Member where
  url : String
  name : String
  role : String

def team (teamMembemr : Member) : HtmlM Page Html := do
  saveCss (include_str "../../static/style/team.css")

  return {{
    <div class="team-card" onclick="toggleCard(this)">
        <div class="image-container">
            <img src={{teamMembemr.url}}/>
        </div>
        <div class="content-area">
            <div class="member-details">
                <h3 class="member-name">{{teamMembemr.name}}</h3>
                <p class="member-role">{{teamMembemr.role}}</p>
            </div>
        </div>
    </div>
  }}

end Verso.Web.Components
