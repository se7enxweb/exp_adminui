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
admin4    (Exponential: the complete admin design, Exponential UI widgets, jQuery 4)
admin3, admin2, admin   (older admin designs, for templates extensions bring in their own admin folders)
```

A template that is not in `adminui` is served by admin4l or admin4, so every admin view works, including the ones
the reference never had (audit, newsletter, git manager, layouts ...). They get the Admin UI frame and stylesheet.

## How a page is assembled

`pagelayout.tpl`:

1. **Head** (`adminui/page_head.tpl`): favicons, the base path meta tag, the old admin's left/right menu size
   styles. `page_head_style.tpl` loads the legacy stylesheets and the extensions' `BackendCSSFileList` through
   ezjscore, then links `font-awesome.css`, `icomoon.css`, `style.css` and `adminui.css` as plain files, as the
   reference does. `page_head_script.tpl` loads jQuery 4 and the admin scripts (`BackendJavaScriptList`, with
   Exponential UI), then the Admin UI scripts: jQuery UI resizable, Bootstrap 3 (side bar dropdowns), Ace and `app.js`.
2. **Header**: the logo (`.logo-type-<LogoType>`) and the search box. A view can add its own top bar through the
   persistent variable `top_menu`, as the content view and the version preview do (node/view/full.tpl, content/view/versionview.tpl).
3. **Side bar** (`#aside`): the user menu (`adminui/page_aside_user.tpl`), then `adminui/menu/aside.tpl`. That
   template replaces the reference's PHP menu plugins: the admin top menu (`menu.ini [TopAdminMenu]`, drawn by
   `menu/plugins/legacy/aside.tpl`), then Layouts, Tags and Collected information, then the Cache and Bookmarks
   dropdowns. `exp_adminui.ini [MenuPlugins]` switches each block on or off.
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
