# Settings

## exp_adminui.ini

Defaults in `settings/exp_adminui.ini`. Override per siteaccess in
`settings/siteaccess/adminui/exp_adminui.ini.append.php` (in the extension or the installation).

### [AdminUISettings]

- `Title`: the name in the window title, the generator meta tag and the logo's tooltip. Default `Exponential Admin UI`.
- `LogoType`: which logo the stylesheets draw. `exponential` (default) is the Exponential mark in the header and
  the full logo on the login page (`images/exponential/`, white ink for the dark backgrounds). `default` and
  `ngadminui` are the reference's own logos, still drawn by its unchanged `style.css`.

### [MenuPlugins]

- `Enabled[]`: the blocks of the side bar, in the order the reference has them:
  - `legacy`: the admin top menu, one entry per `menu.ini [TopAdminMenu] Tabs[]`, with the reference's icons per
    URL or navigation part. Tabs another block draws are left out (`eztags` when `tags` is on,
    `explayouts_ui_dashboard` when `layouts` is on).
  - `layouts`, `tags`, `information_collection`: one entry each, shown when the user has access
    (`explayouts_ui/read`, `tags/read`, `infocollector/read`).
  - `cache`: the clear cache dropdown (`setup/clear_cache.tpl`), with `setup/managecache` access.
  - `bookmarks`: the bookmarks dropdown (`toolbar/full/admin_bookmarks.tpl`), with `content/bookmark` access.

### [MenuPlugin_layouts], [MenuPlugin_tags], [MenuPlugin_information_collection]

- `URL`: where the entry points. Defaults `explayouts_ui/dashboard`, `tags/dashboard`, `infocollector/overview`.

### [ViewSettings] (from the reference's ngadminui.ini)

- `DefaultTab`: the tab a content view opens on: `view`, `subitems`, `translations`, `locations` or `relations`.
- `DefaultTabs[<class identifier>]`: per class. Containers (folder, user_group, ng_* containers) open on `subitems`.

### [SnippetEditorSettings], [SnippetEditorClass_<class>]

- `ClassList[]`: classes whose text fields are edited with the Ace code editor.
- `FieldList[]`: per class, the `eztext` fields that get it.
- `SnippetEditorConfig_<field>[mode|theme|highlight_active_line|show_print_margin]`: editor options.

## Other INI files (extension/exp_adminui/settings/siteaccess/adminui/)

| File | What |
|---|---|
| `design.ini.append.php` | `DesignExtensions[]=exp_adminui` |
| `site.ini.append.php` | `TranslationExtensions[]=exp_adminui` |
| `icon.ini.append.php` | The reference's icon set: repository `design/adminui/images/icons`, theme `kp` (with `StandardTheme=kp`), class, class group, MIME and flag icons |
| `menu.ini.append.php` | `HiddenTabs[]` for the tabs the side bar draws itself; the reference's tab names (Media library, User accounts, Webshop); the reference's Setup left menu |
| `ezoe.ini.append.php` | `SkinVariant=silver`, as in the reference |
| `zone.ini.append.php` | ezflow zone thumbnails, as in the reference |

## The siteaccess (settings/siteaccess/adminui/ of the installation)

A copy of the admin siteaccess's settings, with `SiteDesign=adminui`, the chain
`admin4l, admin4, admin3, admin2, admin`, and `ActiveAccessExtensions[]=exp_adminui`. Its `icon.ini` and `ezoe.ini`
are empty, because a copy of the admin's would override the extension's.

## Reading order, and why some values cannot be set here

Exponential reads, from first to last (last wins): defaults, access-extension settings (this extension, including
its `settings/override/`), the siteaccess, every globally active extension, `settings/override`. A value a global
extension also sets beats this extension and the siteaccess. Example: cjw_newsletter maps its classes to crystal
icon paths (`filesystems/folder.png` ...). The adminui design therefore carries copies of fitting kp icons under
those paths (`images/icons/kp/<size>/filesystems/...`, listed in ASSETS.md) instead of remapping the classes.
