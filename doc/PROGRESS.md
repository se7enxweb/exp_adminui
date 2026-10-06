# Exponential Admin UI: port progress

Reference: Netgen Admin UI on the Nexus v2 site, `https://site.v2.nexus.alpha.se7enx.com/ngadminui<path>`.
Port: `https://alpha.se7enx.com/adminui<path>` (Apache) and `https://alpha.se7enx.com:8080/adminui<path>` (Velocity).

Status: **live** (served by the adminui design), **merged** (the Admin UI template carries Exponential's later
changes, see merging.md), **checked** (the readability probe passes: no text under 4.5:1 contrast outside the
reference's own footer colours, nothing past the window, no overlapping text, no JS errors; at 1440 and 960 at
scale 2, light and dark, Apache and Velocity), **gap** (see gaps.md).

## Frame and shared parts

| Part | Status | Notes |
|---|---|---|
| Header, search, side bar, user menu, left column, path, footer | live | pagelayout.tpl, templates/adminui/* |
| Exponential branding (logo, favicon, names) | live | no Netgen marks in the interface |
| Root font size | live | adminui-rem.css: 16px root for rem-sized module CSS; style.css's own rem rules kept in px |
| Login page | live | loginpagelayout.tpl, user/login.tpl |
| Side bar Cache and Bookmarks dropdowns | live, merged | bookmark folder tree |
| Left menus (ini_menu) | live, merged | Exponential's access checks; full Setup menu |

## Views

| View | Path | Status | Notes |
|---|---|---|---|
| Dashboard | /content/dashboard | live | the reference's block grid; admin4's redesigned dashboard not ported (decision pending) |
| Node view, tabs, sub-items | /content/view/full/2 | live, merged | sub-items: expui table in the reference look (adminui.css) |
| Media library, User accounts | /content/view/full/43, /5 | live, merged | |
| Content edit | /content/edit/<id> | live, merged | no YUI; editor keeps Exponential's TinyMCE 8/3 choice |
| Version preview, history | /content/versionview, /content/history | live, merged | |
| Trash | /content/trash | live, merged | Exponential's trash (who/when, filters) in the reference frame |
| Bookmarks | /content/bookmark | live, merged | bookmark folders |
| Languages | /content/translations | live, merged | Exponential's rewrite in the reference frame |
| URL translator, wildcards | /content/urltranslator, /content/urlwildcards | live | |
| Search | /content/search | live | |
| Drafts, pending items | /content/draft, /content/pendinglist | live | |
| Classes | /class/grouplist, /class/classlist/1, /class/view/1, /class/edit | live, merged | pager, attribute Top/Bottom moves |
| Sections | /section/list | live, merged | |
| Roles and policies | /role/list, /role/view/1, /role/edit | live, merged | sortable, paged |
| States | /state/groups, /state/group/<id> | live, merged | |
| Workflows, processes, triggers | /workflow/grouplist, /workflow/processlist, /trigger/list | live, merged | |
| Setup: cache, info, extensions, RAD, upgrade check | /setup/* | live, merged | |
| Packages | /package/list, /package/view/full/<name> | live, merged | package view only partly styled (pvf-* rules are admin4's) |
| RSS, search statistics, ini settings, PDF export | /rss/list, /search/stats, /settings/view, /pdf/list | live, merged | |
| Notifications, collaboration | /notification/settings, /collaboration/view/summary | live, merged | keep Exponential's orange accents |
| Collected information | /infocollector/overview | live, merged | side bar entry (reference: Symfony bundle) |
| Change password | /user/password | live, merged | strength meter, generator |
| Tags | /tags/dashboard | live, merged | side bar entry "Tags" |
| Webshop | /shop/orderlist | live | |
| Translations (Symfony message editor) | /translations/ | gap | |
| Lists by class | /classlists/list | gap | ezclasslists not installed on alpha |

## Exponential Layouts (explayouts_ui), 2026-10-06

Before: text and spacing at 62.5% (the root font size), content pulled 15px past both column edges (Bootstrap
.row), the mappings list drawn over its own header, the components table wider than the column at 200% zoom,
header cells broken inside words, pale greys (2.85 to 4.48:1). After: all of the following pass the readability
probe on Apache and Velocity, 1440 and 960 at scale 2, light and dark (screenshots: var/tmp/exp_adminui/
layouts-final-8080/ and layouts-final-443/ on alpha; before: layouts-sweep1/).

| View | Path | Before | After |
|---|---|---|---|
| Layout mappings | /explayouts_ui/rule_list | list over the header, 62.5% text, 7 contrast | checked; reference left menu, no path bar |
| Layouts | /explayouts_ui/layout_list | 74 contrast | checked |
| Shared layouts | /explayouts_ui/shared_layouts_list | 8 contrast | checked |
| Import | /explayouts_ui/transfer_import | 3 contrast | checked |
| Components | /explayouts_ui/components | 9px text, 212 elements past the window at 200%, 85 contrast | checked; card layout below 1040px |
| Dashboard | /explayouts_ui/dashboard | 12 contrast | checked |
| Setup | /explayouts_ui/setup | 62.5% text | checked |
| New layout | /explayouts_ui/layout_create | 62.5% text | checked |
| Mapping edit | /explayouts_ui/rule_edit/<id> | 41 elements past the window at 200% | checked; form tables scroll inside the page |
| Layout edit | /explayouts_ui/layout_edit/<id> | 62.5% text | checked |
| Template editor | /explayouts_ui/template_editor | standalone page, 2 JS errors | gap: the module's own full-window page (no admin frame), same JS errors in admin4l |

## Other module pages

See the module sweep below (filled in as each page is checked).
