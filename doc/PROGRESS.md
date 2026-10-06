# Exponential Admin UI: port progress

Reference: Netgen Admin UI on the Nexus v2 site, `https://site.v2.nexus.alpha.se7enx.com/ngadminui<path>`.
Port: `https://alpha.se7enx.com/adminui<path>` (Apache) and `https://alpha.se7enx.com:8080/adminui<path>` (Velocity).

Status: **todo**, **in progress**, **live** (served by the adminui design), **pixel-checked** (compared with the
reference at 1440, 960@2 and 390@2; diff % is the share of differing pixels at 1440 with data areas masked).

| View | Path | Status | Diff % | Notes |
|---|---|---|---|---|
| Frame: header, search, side bar, user menu, left column, path, footer | all | live | | pagelayout.tpl and templates/adminui/* |
| Dashboard | /content/dashboard | live | | alpha's own dashboard blocks (showcase tour) differ in content |
| Content structure (node view, tabs, sub-items) | /content/view/full/2 | live | | sub-items table: admin4 exp::datatable restyled by adminui.css (reference: YUI 2 DataTable) |
| Media library | /content/view/full/43 | live | | |
| User accounts | /content/view/full/5 | live | | |
| Setup: cache | /setup/cache | live | | |
| Setup: system information | /setup/info | live | | |
| Setup: extensions | /setup/extensions | live | | |
| Classes | /class/grouplist, /class/classlist/1, /class/view/1 | live | | |
| Sections | /section/list | live | | |
| Roles and policies | /role/list, /role/view/1 | live | | |
| Trash | /content/trash | live | | admin4 template (the reference's needs YUI) |
| Search | /content/search | live | | |
| My drafts, bookmarks, pending items | /content/draft, /content/bookmark, /content/pendinglist | live | | |
| Links | /url/list | live | | |
| States | /state/groups | live | | |
| Workflows, processes, triggers | /workflow/grouplist, /workflow/processlist, /trigger/list | live | | |
| Packages | /package/list | live | | |
| RSS | /rss/list | live | | |
| Search statistics | /search/stats | live | | |
| Languages | /content/translations | live | | |
| URL translator, wildcards | /content/urltranslator, /content/urlwildcards | live | | |
| Ini settings | /settings/view | live | | |
| Collected information | /infocollector/overview | live | | side bar "Collected information" (reference: Symfony bundle) |
| Upgrade check | /setup/systemupgrade | live | | |
| Notification settings | /notification/settings | live | | |
| History | /content/history/1 | live | | |
| Tags | /tags/dashboard | live | | side bar "Netgen Tags" (reference: Symfony tags admin) |
| Layouts | /explayouts_ui/dashboard | live | | side bar "Netgen Layouts" (reference: Symfony layouts admin) |
| Change password | /user/password | live | | |
| Collaboration | /collaboration/view/summary | live | | |
| Unactivated users | /user/unactivated | live | | |
| Webshop | /shop/orderlist | live | | |
| Login page | /user/login | live | | legacy Login/Password form in the reference markup |
| Content edit | /content/edit/<id> | live | | reference template; its YUI 3 right-column collapse replaced by jQuery |
| Translations (Symfony translation editor) | /translations/ | gap | | no Exponential equivalent; left out of the side bar |
| Lists by class | /classlists/list | gap | | ezclasslists is not active on alpha |
