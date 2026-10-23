# Architecture

## What the reference is

Netgen Admin UI runs on eZ Platform (Symfony) with the legacy bridge. Its pages come in two layers:

- **The frame** (head, header, side bar, left column, path, footer, login page) is Twig, in the bundle's
  `Resources/views/` (`pagelayout.html.twig` and the `page_*.html.twig` partials, plus a menu plugin system in PHP).
- **The views** (content view, edit, setup pages, roles, classes ...) are legacy eZ templates in the legacy design
  `ngadminui` (`bundle/ezpublish_legacy/ngadminui/design/ngadminui/templates/`). Symfony renders the legacy module
  and puts its result into the Twig frame.

Its legacy siteaccess used the design chain `ngadminui -> admin3 -> admin2 -> admin`.

## What the port is

Exponential 6 renders everything with its own template engine, so:

- **The frame** is ported from Twig to Exponential templates (`design/adminui/templates/pagelayout.tpl`,
  `templates/adminui/*`, `loginpagelayout.tpl`, `user/login.tpl`). The markup is the reference's, element for
  element, so the reference stylesheet draws it the same way. See [twig-to-tpl.md](twig-to-tpl.md).
- **The views** are the reference's legacy templates. Exponential has changed many admin templates since Netgen
  copied them, so most of them are three-way merges. Five templates needed YUI and use admin4's (Exponential UI)
  version instead. See [merging.md](merging.md) and [views.md](views.md).
- **The look** is the reference's stylesheets, copied unchanged: `style.css` (the Admin UI), `icomoon.css`,
  `font-awesome.css`, and the legacy `core.css`, `pagelayout.css`, `content.css`, `ng2admin.css` and
  `theme/*.css`. `adminui.css` comes last and adds rules for markup the reference never had, mainly the Exponential UI
  widgets, plus the Exponential logo.

## The design chain

```
adminui   (this extension: frame, Admin UI views, stylesheets, fonts, images, scripts)
admin4l   (Exponential: the admin page assembled from admin layout zones; its pagelayout is not used here)
admin4    (Exponential: the complete admin design, Exponential UI widgets, no jQuery)
admin3, admin2, admin   (older admin designs, for templates extensions bring in their own admin folders)
```

A template that is not in `adminui` is served by admin4l or admin4, so every admin view works, including the ones
the reference never had (audit, newsletter, git manager, layouts ...). They get the Admin UI frame and stylesheet.

## How a page is assembled

`pagelayout.tpl`:

1. **Head** (`adminui/page_head.tpl`): favicons, the base path meta tag, the old admin's left/right menu size
   styles. `page_head_style.tpl` loads the legacy stylesheets and the extensions' `BackendCSSFileList` through
   ezjscore, then links `font-awesome.css`, `icomoon.css`, `style.css` and `adminui.css` as plain files, as the
   reference does. `page_head_script.tpl` loads jQuery 4 and the admin scripts: `BackendJavaScriptList` and
   `ClassicBackendJavaScriptList` (`design.ini [JavaScriptSettings]`). admin4 loads no jQuery and reads only the
   first; the second names what the older admin designs still load on every page with jQuery, Exponential UI's
   modules and eztags' jQuery plugins among them; on a kernel without that setting the head loads the first alone. Then the Admin UI scripts: jQuery UI resizable, Bootstrap 3 (side bar dropdowns), Ace, `app.js` and `exp_adminui_aside_dropdown_keys.js`
   (Escape closes a side bar dropdown; the arrow keys in the Interface dropdown, which Bootstrap 3 cancelled), and
   `exp_adminui_actions.js`.

   **No inline JavaScript.** The templates carry no `<script>` with code, no `on...=` attribute and no `javascript:`
   link, so the design runs under a Content Security Policy without `'unsafe-inline'` in `script-src` (only the
   TinyMCE 3 edit template, `ezxmltext_ezoe.tpl`, keeps its inline start script: the editor needs it). The small
   actions are `data-expui-*` attributes handled by one listener per event in `javascript/exp_adminui_actions.js`
   (its header lists them: invert a selection, confirm, discard, submit or navigate on change, mark a button, focus a
   field ...). Page scripts are `javascript/exp_adminui_<page>.js`, printed with `{ezscript( array( ... ) )}` where the
   inline script stood; the values they need are `data-*` attributes (JSON for structured ones). The content tree and
   the tags tree are drawn from the data of a hidden element by `exp_adminui_content_tree.js` and
   `exp_adminui_tags_tree.js`, the sub-items table by `exp_adminui_children_detailed.js`. The class menu of the content
   view opens through `data-menu-open` (the design's own `popupmenu/ezpopupmenu.js`). None of it needs a newer kernel.
   `tests/expadminuiadmininlinescripttest.php` keeps it that way.
2. **Header**: the logo (`.logo-type-<LogoType>`) and the search box. A view can add its own top bar through the
   persistent variable `top_menu`, as the content view and the version preview do (node/view/full.tpl, content/view/versionview.tpl).
3. **Side bar** (`#aside`): the user menu (`adminui/page_aside_user.tpl`), then `adminui/menu/aside.tpl`. That
   template replaces the reference's PHP menu plugins: the admin top menu (`menu.ini [TopAdminMenu]`, drawn by
   `menu/plugins/legacy/aside.tpl`), then Layouts, Tags and Collected information, then the Cache, Bookmarks and Interface
   dropdowns (Interface: the UI switch of the kernel, the display language and the administration design;
   uiswitch/choices.tpl and grouped.tpl, drawn in adminui.css like the Cache dropdown and the side bar entries).
   `exp_adminui.ini [MenuPlugins]` switches each block on or off.
4. **Left column** (`adminui/page_leftmenu.tpl`): the view's own left menu (`$module_result.left_menu`), otherwise
   `parts/<navigation part>/menu.tpl` (content tree, setup links, my account ...). It is drawn only when it has content.
5. **Main column**: the path (`adminui/page_toppath.tpl`), the module result and the footer.
6. Outside the page: the context (popup) menu, the overlay mask, the upload spinner and the "window too small"
   notice, which `style.css` shows below 640px wide, as in the reference.

The login page is `loginpagelayout.tpl` with `user/login.tpl`. As in the reference, it loads only the Admin UI
stylesheets.

## Settings placement

The extension is an *access extension*: the siteaccess switches it on with `ActiveAccessExtensions[]=exp_adminui`,
so it does nothing anywhere else. Its siteaccess-specific settings are in
`settings/siteaccess/adminui/` inside the extension. Exponential reads access-extension settings before the
siteaccess's own and before every globally active extension. A value that another extension also sets (e.g.
cjw_newsletter's class icons) therefore has to be handled another way. See [settings.md](settings.md).

## Nothing in PHP

The reference needs PHP for its menu plugins, its path helper, `ngadmin_ezpreference` and a `has_tags_bundle`
operator. Everything they did is plain template code here (`ezpreference`, `$module_result.path`, `topmenu()`,
`fetch( 'user', 'has_access_to', ... )`). That keeps the extension a design: no autoloads, no Velocity restart.
