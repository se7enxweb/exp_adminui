# Troubleshooting

**`/adminui` gives "Undefined module: adminui" (404).** The siteaccess is not in
`AvailableSiteAccessList[]` of `settings/override/site.ini.append.php`, or the INI cache is old:
`php bin/php/ezcache.php --clear-tag=ini --allow-root-user` (not `--clear-id=ini`, which misses the global INI cache).

**The page has no styles, or the old admin look.** Check `SiteDesign=adminui` and
`ActiveAccessExtensions[]=exp_adminui` in the siteaccess, then clear `template,template-override,template-block`.
A stylesheet change needs `template-block` too: the admin layouts cache the packed CSS link in cache blocks.

**A new template does not show; the view is empty but answers 200.** Clear the template override cache
(`--clear-id=template-override`). `--clear-id=template` does not include it.

**A node view tab still shows old markup.** Tabs render inside the content view cache: clear `content` too.

**On Exponential Velocity (:8080) the page is stale.** After the caches, run `./console exp:velocity cache clear
--allow-root-user`. Templates need no restart. This extension has no PHP classes, so it never needs `exp:velocity
restart`.

**Icons are missing (404 under images/icons/kp/...).** An extension maps a class to an icon path the kp theme does
not have. Add a copy of a fitting kp icon under that path (see settings.md, reading order).

**The editor dialog looks unstyled under TinyMCE 3.** `javascript/plugins/inlinepopups/` must hold both the plugin
script (from ezoe) and the `tinyngadminui` skin.

**"The current window is too small" covers the page.** The window is narrower than 640 CSS pixels (a phone, or a
narrow window at high zoom). This is the reference's behaviour.

**JavaScript errors about YUI.** A template from an extension's own admin design still uses YUI. Exponential 6 does
not ship YUI; the template needs its Exponential UI version.
