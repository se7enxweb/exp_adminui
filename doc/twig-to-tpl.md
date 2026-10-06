# The page frame: Twig to Exponential templates

Source: `se7enxweb/admin-ui-bundle` 2.9.15, `bundle/Resources/views/`. Target: `design/adminui/templates/`.

## File mapping

| Netgen Admin UI (Twig) | Exponential Admin UI (template) | Notes |
|---|---|---|
| `pagelayout.html.twig` | `pagelayout.tpl` | Same element tree: `#page > header#header, aside#aside, #content > .content-body > #columns` |
| `pagelayout_variables.html.twig` | top of `pagelayout.tpl` | `show_side_menu`, path and menu plugin variables |
| `pagelayout_legacy.html.twig`, `pagelayout_module.html.twig` | `pagelayout.tpl` | The legacy module result is the page content; versionview hides the side bar |
| `page_head.html.twig` | `adminui/page_head.tpl` | Favicons (Exponential mark), base path meta, menu size styles |
| `page_head_style.html.twig` | `page_head_style.tpl` | Legacy CSS through ezjscore, then the three Admin UI files and `adminui.css` |
| `page_head_script.html.twig` | `page_head_script.tpl` | jQuery 4 + admin scripts, then resizable, Bootstrap, Ace, `app.js`; no YUI stand-ins |
| `page_aside_user.html.twig` | `adminui/page_aside_user.tpl` | Avatar from `page_aside_user.tpl` (legacy helper), else `a0.jpg` |
| `page_leftmenu.html.twig` + `menu/plugins/legacy/left.html.twig` | `adminui/page_leftmenu.tpl` | `$module_result.left_menu` or `parts/<part>/menu.tpl` |
| `page_search.html.twig`, `parts/search_box.html.twig` | `adminui/page_search.tpl`, `adminui/parts/search_box.tpl` | |
| `page_toppath.html.twig` | `adminui/page_toppath.tpl` | Items of `$module_result.path` |
| `page_footer.html.twig` | `adminui/page_footer.tpl` | Names Exponential Admin UI |
| `menu/plugins/*/aside.html.twig` | `adminui/menu/aside.tpl` | One block per plugin, switched by `[MenuPlugins] Enabled[]` |
| `menu/plugins/legacy/top.html.twig` | `pagelayout.tpl` header | Search box + persistent variable `top_menu` |
| `pagelayout_login.html.twig` | `loginpagelayout.tpl` | |
| `user/login.html.twig` | `user/login.tpl` | Legacy fields `Login`, `Password`, `RedirectURI`, `LoginButton` |
| `tags/`, `information_collection/`, `layouts/` pagelayouts | (none) | Symfony admin pages; the side bar points at the Exponential modules instead (see gaps.md) |

## Expressions

| Twig | Exponential template |
|---|---|
| `module_result.ui_context\|default('navigation')` | `$ui_context` (set by the kernel) |
| `module_result.navigation_part\|default('ezcontentnavigationpart')` | `first_set( $module_result.navigation_part, $navigation_part.identifier, 'ezcontentnavigationpart' )` |
| `ngadmin_ezpreference( 'x' )` | `ezpreference( 'x' )` |
| `ngadmin_location_path( id )`, `ezpublish.legacy.get( 'path' )` | `$module_result.path` |
| `path( 'ez_legacy', { module_uri: '/content/search' } )` | `{'/content/search'\|ezurl}` |
| `path( ezpublish.rootLocation )` | `{'/'\|ezurl}` |
| `asset( 'bundles/netgenadminui/images/a0.jpg' )` | `{'a0.jpg'\|ezimage}` |
| `asset( 'bundles/netgenadminui/css/style.css' )` | `{'stylesheets/style.css'\|ezdesign}` |
| `'netgen_admin_ui.x'\|trans` | `'English text'\|i18n( 'design/adminui/...' )` (the bundle's English messages) |
| `is_granted( 'ez:content:read', content )` | `$content.can_read` |
| `is_granted( 'ez:setup:managecache' )` | `fetch( 'user', 'has_access_to', hash( 'module', 'setup', 'function', 'managecache' ) )` |
| `app.user.APIUser.content`, `ez_content_name()` | `$current_user.contentobject`, `.name` |
| `app.request.query.get( 'SearchText' )` | `ezhttp( 'SearchText', 'get' )` |
| `[10, 10, 25, 50][min( pref, 3 )]` | `min( ezpreference( 'admin_list_limit' ), 3 )\|choose( 10, 10, 25, 50 )` |
| `{% include x ignore missing %}` + `\|striptags\|trim is not empty` | `{set-block}` + `\|trim\|ne( '' )` |
| `'now'\|date('Y')` | `currentdate()\|datetime( 'custom', '%Y' )` |
| `path( 'logout' )` | `{'/user/logout'\|ezurl}` |
