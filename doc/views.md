# Views

Every view of the administration, as the adminui design serves it. "Admin UI template" means the template comes from
Netgen Admin UI (copied, or merged with Exponential's later changes: see [merging.md](merging.md)); "admin4" means
adminui has no template of its own there, so admin4l/admin4 serve it inside the Admin UI frame and colours. The full
list of templates with their origin is [templates.md](templates.md). Status per view: [PROGRESS.md](PROGRESS.md).

## The frame (every page)

| Part | Template | From |
|---|---|---|
| Page frame | `pagelayout.tpl` | ported from `pagelayout.html.twig` |
| Head: favicons, menu sizes | `adminui/page_head.tpl` | ported from `page_head.html.twig` |
| Stylesheets | `page_head_style.tpl` | ported from `page_head_style.html.twig` |
| Scripts | `page_head_script.tpl` | ported from `page_head_script.html.twig` |
| Header search | `adminui/parts/search_box.tpl`, `adminui/page_search.tpl` | ported |
| Side bar menu | `adminui/menu/aside.tpl`, `menu/plugins/legacy/aside.tpl` | ported from the menu plugins |
| Side bar Cache dropdown | `setup/clear_cache.tpl` | Admin UI template, merged |
| Side bar Bookmarks dropdown | `toolbar/full/admin_bookmarks.tpl` | Admin UI template, merged (bookmark folders) |
| User menu | `adminui/page_aside_user.tpl` (avatar: `page_aside_user.tpl`) | ported |
| Left column | `adminui/page_leftmenu.tpl` + `parts/<section>/menu.tpl`, `parts/ini_menu.tpl` | ported; menus merged |
| Content tree | `contentstructuremenu/content_structure_menu_dynamic.tpl` | Admin UI template, merged |
| Path | `adminui/page_toppath.tpl` | ported from `page_toppath.html.twig` |
| Footer | `adminui/page_footer.tpl` | ported |
| Login page | `loginpagelayout.tpl`, `user/login.tpl` | ported from `pagelayout_login.html.twig`, `user/login.html.twig` |

## Content

| View | Path | Template | From |
|---|---|---|---|
| Dashboard | `/content/dashboard` | `content/dashboard.tpl` | admin4's dashboard in the Admin UI look |
| Node view and tabs | `/content/view/full/<node>` | `node/view/full.tpl`, `window_controls.tpl`, `windows.tpl`, `locations.tpl`, `translations.tpl`, `relations.tpl` | Admin UI templates, merged |
| Sub-items | node view tab | `children.tpl` (Admin UI) + `children_detailed.tpl` (admin4, Exponential UI table) | restyled by `adminui.css` |
| Preview tab | node view tab | `node/view/admin_preview.tpl`, `window_preview_toolbar.tpl` | Admin UI templates |
| Edit | `/content/edit/<object>` | `content/edit.tpl`, `content/edit_attribute.tpl`, `content/datatype/edit/*` | Admin UI templates, merged; date fields and uploads: admin4 |
| Online editor | edit | `content/datatype/edit/ezxmltext_ezoe.tpl` | Exponential's template with the Admin UI dialog skin |
| Version preview, history | `/content/versionview/...`, `/content/history/<id>` | `content/view/versionview.tpl`, `content/history.tpl` | merged |
| Trash | `/content/trash` | `content/trash.tpl` | Exponential's trash in the Admin UI frame |
| Bookmarks, drafts, pending | `/content/bookmark`, `/content/draft`, `/content/pendinglist` | `content/bookmark.tpl`, `content/draft.tpl` | merged / copy |
| Search | `/content/search` | `content/search.tpl`, `content/advancedsearch.tpl` | Admin UI templates |
| Browse (choose a node) | `/content/browse` | `content/browse*.tpl` | merged |
| Languages | `/content/translations` | `content/translations.tpl`, `translationnew.tpl`, `translationview.tpl` | Exponential's rewrite in the Admin UI frame |
| URL translator, wildcards | `/content/urltranslator`, `/content/urlwildcards` | `content/urlalias_*.tpl` | merged / copy |
| Remove | `/content/removeobject` | `node/removeobject.tpl` | merged |

## Setup

| View | Path | Template | From |
|---|---|---|---|
| Cache management | `/setup/cache` | `setup/cache.tpl` | merged (query and HTTP cache, OPcache) |
| System information | `/setup/info` | `setup/info.tpl` | Exponential's rewrite in the Admin UI frame |
| Extensions | `/setup/extensions` | `setup/extensions.tpl` | Exponential's rewrite (activation, loading order) |
| RAD | `/setup/rad` | `setup/rad.tpl` | Exponential's rewrite |
| Upgrade check | `/setup/systemupgrade` | `setup/systemupgrade.tpl` | Admin UI template |
| Cronjobs, maintenance, sessions, preload | `/setup/cronjobs` ... | admin4 | Admin UI frame and blue accent |
| Classes | `/class/grouplist`, `/class/classlist/<g>`, `/class/view/<id>`, `/class/edit/<id>` | `class/*` | merged (pager, Top/Bottom moves) |
| Sections | `/section/list` | `section/list.tpl` | Exponential's rewrite in the Admin UI frame |
| States | `/state/groups`, `/state/group/<id>` | `state/*` | Exponential's rewrite in the Admin UI frame |
| Roles and policies | `/role/list`, `/role/view/<id>`, `/role/edit/<id>` | `role/*` | merged (sorting, paging, order buttons) |
| Workflows, processes, triggers | `/workflow/grouplist`, `/workflow/processlist`, `/trigger/list` | `workflow/*`, `trigger/list.tpl` | merged; processes: Exponential's rewrite |
| Packages | `/package/list`, `/package/view/full/<name>`, wizards | `package/*` | merged |
| RSS, search statistics, ini settings, PDF export | `/rss/list`, `/search/stats`, `/settings/view`, `/pdf/list` | `rss/list.tpl`, `search/stats.tpl`, `settings/view.tpl`, `pdf/*` | merged |
| Links | `/url/list`, `/url/view/<id>` | `url/*` | Admin UI templates |
| Collected information | `/infocollector/overview` | `infocollector/*` | merged |

## My account and users

| View | Path | Template | From |
|---|---|---|---|
| Change password | `/user/password` | `user/password.tpl` | merged (strength meter, generator) |
| Notification settings | `/notification/settings` | `notification/settings.tpl`, `notification/handler/*` | Exponential's rewrite in the Admin UI frame |
| Collaboration | `/collaboration/view/summary` | `collaboration/view/summary.tpl` | Exponential's inbox in the Admin UI frame |
| User accounts | `/content/view/full/5` | node view | |
| Unactivated users | `/user/unactivated` | admin4 | |

## Extension modules

| Module | Start page | Template | Notes |
|---|---|---|---|
| Exponential Layouts | `/explayouts_ui/rule_list` | the module's own; left menu `parts/explayouts_ui/menu.tpl` (adminui) | `adminui-modules.css` puts its pages in the Admin UI frame |
| Tags | `/tags/dashboard` | `tags/dashboard.tpl`, `tags/tabs/*` | Admin UI templates, merged |
| Audit, git manager, export (xrowextract), newsletter, CIE, syndication, update, DSE, e-mail preferences, oAuth, shop dashboard | their own | the modules' own (admin designs) | Admin UI frame, blue accent, readability rules in `adminui-modules.css` |
