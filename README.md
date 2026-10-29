# Exponential Admin UI (exp_adminui)

A second look for the Exponential 6 administration: the layout, navigation and style of Netgen Admin UI, served as
its own siteaccess (`adminui`) next to the stock admin. Editors get a dark side bar with the main sections, a search
header, a content tree on the left, tabbed node views and a details panel, while every admin feature of Exponential
keeps working, because the views underneath are Exponential's own.

It is for site owners and editors who prefer the Admin UI way of working, and for integrators who want to offer it
without Symfony. The extension is plain Exponential template code: a design with settings, no PHP classes, no
modules and no database tables. Install it, add one siteaccess, and both admins run side by side on the same content.

- The frame is the Admin UI's: the side bar with the main sections and the user menu, the search header, the light
  left column with the section's menu or content tree, the "You are here" path and the footer.
- The views are the Admin UI's legacy templates, merged with everything Exponential 6 added to the admin since:
  escaping fixes, Exponential UI (expui) widgets in place of YUI, jQuery 4, new menu entries and features.
- The Admin UI stylesheets, fonts, images and scripts are copied unchanged. `adminui.css` adds the rules that give
  Exponential's newer markup (the expui sub-items table, for one) the same look.
- The interface shows Exponential's logo and names. The Netgen product marks are not used (they can be switched
  back on, see [Configuration](#configuration)).

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Permissions](#permissions)
- [Upgrading](#upgrading)
- [Known limits](#known-limits)
- [Troubleshooting](#troubleshooting)
- [Tests](#tests)
- [Contributing](#contributing)
- [License and credits](#license-and-credits)

## Requirements

- Exponential 6.x (the legacy kernel with the admin designs `admin`, `admin2`, `admin3`, `admin4` and `admin4l`;
  the adminui design falls back to them for every template it does not have).
- PHP 8.0 or later.
- The extensions `ezjscore` (jQuery 4 with Migrate) and `expui` (Exponential UI) active, as in the stock admin.
- Optional, for their side bar entries: `explayouts_ui` (Layouts) and `eztags` (Tags). An entry is only drawn when
  the user may use that module.

## Installation

### A new installation sets it up by itself

Since Exponential 6.0.15 the setup wizard, the kickstarter, `exp:install` and the multisite package installer create
the `adminui` siteaccess by default whenever `extension/exp_adminui` is present: `settings/siteaccess/adminui/` as
a copy of the admin siteaccess's settings with the design chain below, `ActiveAccessExtensions[]=exp_adminui`,
empty `icon.ini.append.php` and `ezoe.ini.append.php`, and `adminui` in `AvailableSiteAccessList[]` and
`SiteList[]`, matched by URI. Put the extension in place before installing and open `https://<host>/adminui`.
Without the extension nothing is created, and `var/log/setup.log` says why.

The steps below are for an installation that already exists.

### 1. Get the extension

With Composer, from the root of your Exponential installation. The legacy extension installer
(`se7enxweb/ezpublish-legacy-installer`, required by this package) puts it in `extension/exp_adminui`:

```bash
composer require se7enxweb/exp_adminui
```

By hand, from Git or a release archive:

```bash
git clone https://github.com/se7enxweb/exp_adminui.git extension/exp_adminui
# or: download a release from https://github.com/se7enxweb/exp_adminui/releases
#     and unpack it so the files are in extension/exp_adminui/
```

### 2. Create the siteaccess

`exp_adminui` is an **access extension**: switch it on only in the `adminui` siteaccess, not in
`[ExtensionSettings] ActiveExtensions[]` of `settings/override/site.ini.append.php`. Activated globally it would
change the design of every siteaccess.

Copy the admin siteaccess's settings as a base:

```bash
cp -r settings/siteaccess/admin settings/siteaccess/adminui
```

Then set the design chain and the extension in `settings/siteaccess/adminui/site.ini.append.php`:

```ini
[ExtensionSettings]
ActiveAccessExtensions[]=exp_adminui

[DesignSettings]
SiteDesign=adminui
AdditionalSiteDesignList[]
AdditionalSiteDesignList[]=admin4l
AdditionalSiteDesignList[]=admin4
AdditionalSiteDesignList[]=admin3
AdditionalSiteDesignList[]=admin2
AdditionalSiteDesignList[]=admin
```

Keep `RequireUserLogin=true`, `LoginPage=custom` and `ShowHiddenNodes=true`, as the admin siteaccess has them.
An `icon.ini.append.php` or `ezoe.ini.append.php` copied from the admin siteaccess would override the extension's
icon set and editor skin: delete those two copies, or empty them.

### 3. Register the siteaccess

In `settings/override/site.ini.append.php`, `[SiteAccessSettings]`:

```ini
[SiteAccessSettings]
AvailableSiteAccessList[]=adminui
```

With URI matching the interface is at `https://<host>/adminui`. For a host of its own, add a host match such as
`HostMatchMapItems[]=admin.example.com;adminui`.

### 4. Regenerate autoloads and clear the caches

```bash
php bin/php/ezpgenerateautoloads.php -e
php bin/php/ezcache.php --clear-tag=ini --allow-root-user
php bin/php/ezcache.php --clear-id=template,template-override,template-block,content,translation --allow-root-user
```

The extension has no classes, so the autoload run only refreshes the extension list. Use `--clear-tag=ini`, not
`--clear-id=ini`, which misses the global INI cache. Under Exponential Velocity also run
`./console exp:velocity cache clear --allow-root-user`. Drop `--allow-root-user` when you run the commands as the
web server's user.

### 5. Sign in

Open `https://<host>/adminui` and sign in with an administrator account. The same users, roles and content as in
`/admin` apply.

## Configuration

Defaults are in `settings/exp_adminui.ini`. Override them per siteaccess in
`settings/siteaccess/adminui/exp_adminui.ini.append.php` (of the installation, or of the extension).

```ini
<?php /* #?ini charset="utf-8"?

[AdminUISettings]
# Window title, generator meta tag and logo tooltip
Title=Exponential Admin UI
# exponential (the Exponential logo), or default / ngadminui (the reference's logos)
LogoType=exponential
# Navigation parts whose pages have no "You are here" path
NoPathNavigationParts[]
NoPathNavigationParts[]=ezexplayoutsuinavigationpart

[MenuPlugins]
# The side bar blocks, top to bottom; leave one out to hide it
Enabled[]
Enabled[]=legacy
Enabled[]=layouts
Enabled[]=tags
Enabled[]=information_collection
Enabled[]=cache
Enabled[]=bookmarks
Enabled[]=uiswitch

[MenuPlugin_layouts]
URL=explayouts_ui/rule_list

[MenuPlugin_tags]
URL=tags/dashboard

[MenuPlugin_information_collection]
URL=infocollector/overview

[ViewSettings]
# The tab a node view opens on: view, subitems, translations, locations or relations
DefaultTab=view
DefaultTabs[]
DefaultTabs[folder]=subitems
DefaultTabs[user_group]=subitems

[SnippetEditorSettings]
# Classes whose text fields are edited with the Ace code editor
ClassList[]
ClassList[]=ng_htmlbox

[SnippetEditorClass_ng_htmlbox]
FieldList[]
FieldList[]=html_code
SnippetEditorConfig_html_code[mode]=html
SnippetEditorConfig_html_code[theme]=chrome
SnippetEditorConfig_html_code[highlight_active_line]=true
SnippetEditorConfig_html_code[show_print_margin]=false
*/ ?>
```

The side bar blocks:

| Block | What it draws | Shown when |
|---|---|---|
| `legacy` | One entry per `menu.ini [TopAdminMenu] Tabs[]`, with the Admin UI icon for its URL or navigation part | the tab's own `PolicyList[]` allows it |
| `layouts`, `tags`, `information_collection` | A link to that module (the `URL` above) | the user has `explayouts_ui/read`, `tags/read`, `infocollector/read` |
| `cache` | The clear cache dropdown | `setup/managecache` |
| `bookmarks` | The bookmarks dropdown | `content/bookmark` |
| `uiswitch` | The interface choices, such as the display language (`uiswitch.ini`) | `uiswitch/<provider>` |

The extension also brings settings for other INI files, in `settings/siteaccess/adminui/`:

| File | What it sets |
|---|---|
| `menu.ini.append.php` | `HiddenTabs[]` for the tabs the side bar draws itself (Layouts, Tags); the Admin UI's tab names Media library, User accounts and Webshop, each with its `Icon=` (`images`, `people`, `box-seam`); the newsletter left menu lists |
| `icon.ini.append.php` | The Admin UI icon set (theme `kp`): class, class group, MIME and flag icons |
| `design.ini.append.php` | `DesignExtensions[]=exp_adminui` |
| `site.ini.append.php` | `TranslationExtensions[]=exp_adminui` |
| `ezoe.ini.append.php` | `SkinVariant=silver` for the online editor |
| `zone.ini.append.php` | ezflow zone thumbnails |

`Icon=` is the menu.ini setting the kernel documents in `settings/menu.ini`: the name of a Bootstrap Icon from
`design.ini [AdminDesignSettings] IconList[]` that admin4 draws before a tab's name. The adminui side bar draws its
own Font Awesome icons; the `Icon=` lines name the icon these three tabs have wherever an admin4 header shows them.
To give another tab an icon, add the line to its block in your own `menu.ini.append.php`:

```ini
[Topmenu_mytab]
Icon=star
```

Every setting, with the reading order of the INI files, is described in [doc/settings.md](doc/settings.md).

## Usage

1. Open `https://<host>/adminui` and sign in.
2. **Side bar.** The top entries are the admin's main sections (Content structure, Media library, User accounts,
   Webshop, Setup, My account and the tabs of other extensions), followed by Layouts, Tags, Collected information,
   the Cache and Bookmarks dropdowns and the interface choices. The side bar scrolls when the entries do not fit.
3. **Content.** The left column shows the content tree. Pick a node: its view opens on the tab set in
   `[ViewSettings]` (containers open on Sub items). The details panel on the right can be resized by dragging its
   left edge, or with the arrow keys on its handle; the width is saved as the user preference
   `exp_adminui_details_width` and follows the user to every browser.
4. **Editing.** Edit, publish, move and remove work as in the stock admin, through the same modules. Text fields of
   the classes in `[SnippetEditorSettings]` are edited with the Ace code editor.
5. **Search.** The search box in the header searches content, as the admin's does.
6. **Help.** Where the kernel's help system (the `exphelp` module) is available, the header shows a Help menu with a
   search, the help page for the current view and a link to the Help center. Escape closes it.
7. **Switching back.** The stock admin stays at `/admin`; both work on the same content at the same time.

A guide to every view and the template that draws it is in [doc/views.md](doc/views.md).

### Overriding a template for the Admin UI only

Put the template in your own extension under `design/adminui/templates/<path>`, and list your extension in
`design.ini [ExtensionSettings] DesignExtensions[]`. Templates that adminui does not have come from admin4l and
admin4, so an admin view that works there works inside the Admin UI frame too. Turn on `[TemplateSettings]
ShowUsedTemplates=enabled` to see which file is used. More in [doc/extending.md](doc/extending.md).

## Permissions

The extension adds no module and no policy functions. Access to `/adminui` is governed by the same roles as the
admin: a user needs `user/login` for the `adminui` siteaccess to sign in, and the side bar shows only the sections
and entries the user's policies allow (see the table under [Configuration](#configuration)). If a role limits
`user/login` to the admin siteaccess, add `adminui` to that limitation.

## Upgrading

- With Composer: `composer update se7enxweb/exp_adminui`. By hand: replace `extension/exp_adminui` with the new
  release (keep your own overrides outside the extension).
- Then clear the caches as in step 4 of the installation. A stylesheet change needs `template-block` in the list,
  because the admin layouts cache the packed CSS link in cache blocks.
- Release notes: [CHANGELOG.md](CHANGELOG.md) and the
  [GitHub releases](https://github.com/se7enxweb/exp_adminui/releases).

## Known limits

- The reference's Symfony-backed pages (Netgen Layouts admin, Netgen Tags admin, the information collection admin,
  the translations editor) are not part of Exponential. Their side bar entries open Exponential's own modules
  (`explayouts_ui`, `tags`, `infocollector`) instead.
- Below 640 CSS pixels wide the page is covered by "The current window is too small", as in the reference.
- Exponential UI widgets replace the reference's YUI widgets. They look the same, but spacing can differ by a pixel
  or two.

All differences, and why, are listed in [doc/gaps.md](doc/gaps.md).

## Troubleshooting

- **`/adminui` answers "Undefined module: adminui" (404).** The siteaccess is missing from
  `AvailableSiteAccessList[]`, or the INI cache is old: `php bin/php/ezcache.php --clear-tag=ini --allow-root-user`.
- **No styles, or the stock admin look.** Check `SiteDesign=adminui` and `ActiveAccessExtensions[]=exp_adminui` in
  the siteaccess, then clear `template,template-override,template-block`.
- **A new template does not show; the page is empty but answers 200.** Clear `template-override`;
  `--clear-id=template` does not include it.
- **Icons are missing (404 under `images/icons/kp/...`).** An `icon.ini.append.php` copied from the admin siteaccess
  overrides the extension's; empty it. Or an extension maps a class to an icon path the kp theme does not have.

More in [doc/troubleshooting.md](doc/troubleshooting.md).

## Tests

The tests read the extension's files and need neither a kernel nor a database. From the installation root:

```bash
php extension/exp_adminui/tests/expadminuihelpbuttontest.php
php extension/exp_adminui/tests/expadminuiadmininlinecsstest.php
php extension/exp_adminui/tests/expadminuiadmininlinescripttest.php
php extension/exp_adminui/tests/expadminuieditconflictnewdrafttest.php
php extension/exp_adminui/tests/expadminuigmapapikeytest.php
php vendor/bin/phpunit --no-configuration extension/exp_adminui/tests/expAdminUIContextMenuAndAddressTest.php
```

Each prints PASS or FAIL per check and exits non-zero on a failure.

## Documentation

The full guide is in [doc/](doc/README.md): architecture, every view with its template, the Twig-to-template mapping
used for the port, the merge of the Admin UI templates with Exponential's changes, settings, extending the design,
known gaps and troubleshooting. [doc/ASSETS.md](doc/ASSETS.md) lists every copied file with its sha256.

## Contributing

Issues and pull requests are welcome at
[github.com/se7enxweb/exp_adminui](https://github.com/se7enxweb/exp_adminui). Please keep the copied Admin UI files
byte-identical (put new rules in `adminui.css`), keep CSS out of templates (no `<style>` blocks or `style=""`
attributes), and add or extend a test in `tests/` with a fix.

## License and credits

Exponential Admin UI is Copyright (C) 1998 - 2026 Exponential Foundation and 7x and licensed under the GNU General Public License v2.0 or (at your
option) any later version. See [LICENSE](LICENSE).

It is a port of **Netgen Admin UI** (Composer package `netgen/admin-ui-bundle`, used here from its fork
`se7enxweb/admin-ui-bundle` 2.9.15), Copyright (C) Netgen (https://netgen.io) and contributors, GPL-2.0-or-later,
which Netgen built for eZ Platform with the legacy bridge. Its legacy design templates derive from the eZ Publish
Legacy administration design, Copyright (C) eZ Systems AS, GPL-2.0; eZ Publish was the content management system
that Exponential continues. Third-party libraries are included as Netgen Admin UI ships them: Font Awesome 4.4,
Bootstrap 3.3.5, jQuery UI 1.11.4, Ace, Roboto and Material Icons. [NOTICE](NOTICE) has their copyrights and
licenses.
