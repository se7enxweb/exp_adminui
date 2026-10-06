# Extending the adminui design

## Override a template for the Admin UI only

Put the template in your extension's `design/adminui/templates/<path>`. Design extensions are searched in reverse
order of `DesignExtensions[]` (the last one listed wins), and exp_adminui's entry is read early because it is an
access extension. So a globally active extension's `design/adminui` usually wins over exp_adminui's. Check with
`[TemplateSettings] ShowUsedTemplates=enabled`. Templates that are not
in adminui come from admin4l and admin4, so an admin view that works there works here, inside the Admin UI frame.

Override rules (`override.ini`) work as usual. The adminui siteaccess's `override.ini.append.php` is the admin one.

## Style new markup

Do not edit the copied stylesheets (`style.css`, `icomoon.css`, `font-awesome.css`, the legacy `*.css`): they are
byte-identical to the reference (ASSETS.md has their checksums), so a later Admin UI release can be compared
with them. Put rules in `adminui.css` (this design's own file, loaded last) or in your extension's
`BackendCSSFileList[]` stylesheet, which loads before the Admin UI files. Use the selector `style.css` uses for the
element you are matching, so load order decides and no `!important` is needed. Every block in `adminui.css` names
the style.css rules it mirrors.

Colours of the reference: header and side bar `#383838` / `#161616`, left column `#e6e6e6`, link
and primary button `#2970ef` (hover `#1862e6`), table header `#a7a7a7` (sorted `#919191`), active tab underline and
current menu item `#f97b62`.

## Add a side bar entry

Either a top menu tab (`menu.ini [TopAdminMenu] Tabs[]` plus `[Topmenu_<name>]`; it appears in the side bar with
the `fa-cubes` icon unless `menu/plugins/legacy/aside.tpl` maps its URL or navigation part to an icon), or a block
of your own: override `adminui/menu/aside.tpl` and add an `<li>` with an `<i class="fa fa-...">` icon and a
`<span class="tt">` label. That is the markup style.css expects.

## Give a view a left column

Set `$Result['left_menu'] = 'design:parts/<yours>/menu.tpl'` in the module view, or use a navigation part whose
`parts/<part>/menu.tpl` exists. The column is drawn only when the template produces content.

## Add to the header

A view can put markup into the header through the persistent variable `top_menu`
(`{set scope=global persistent_variable=hash( 'top_menu', $html )}`), as node/view/full.tpl and content/view/versionview.tpl do.
