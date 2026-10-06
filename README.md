# Exponential Admin UI (exp_adminui)

The Netgen Admin UI look, layout and navigation for the Exponential 6 administration, as the design `adminui` and
the siteaccess of the same name. It is a port of Netgen Admin UI, the alternative administration interface that
Netgen built for eZ Platform with the legacy bridge, to plain Exponential template code. No Symfony is required.

- The frame is the Admin UI's: a dark side bar with the main sections and the user menu, a search header, a light
  left column with the section's menu or content tree, the "You are here" path and the footer.
- The views are the Admin UI's legacy templates, merged with everything Exponential 6 added to the admin since:
  escaping fixes, Exponential UI (expui) widgets in place of YUI, jQuery 4, new menu entries and features.
- The Admin UI stylesheets, fonts, images and scripts are copied unchanged. `adminui.css` adds the rules that
  give Exponential's newer markup (the expui sub-items table, for one) the same look.
- The interface shows Exponential's logo and names. The Netgen product marks are not used.

Status: in development (1.0.0.0-dev). See [doc/PROGRESS.md](doc/PROGRESS.md) for view-by-view status.

## Requirements

- Exponential 6 (the legacy kernel with the admin designs `admin`, `admin2`, `admin3`, `admin4` and `admin4l`).
- The extensions `ezjscore` (jQuery 4 with Migrate) and `expui` (Exponential UI) active, as in the stock admin.
- Optional, for their side bar entries: `explayouts_ui` (Layouts), `eztags` (Tags).

## Install

1. Put the extension in `extension/exp_adminui`, from its repository
   [github.com/se7enxweb/exp_adminui](https://github.com/se7enxweb/exp_adminui):

   ```bash
   git clone https://github.com/se7enxweb/exp_adminui.git extension/exp_adminui
   ```

   or, once the package is on Packagist, with Composer. The legacy extension installer
   (`se7enxweb/ezpublish-legacy-installer`) puts it in `extension/exp_adminui`:

   ```bash
   composer require se7enxweb/exp_adminui
   ```

   Activation is per siteaccess (steps 2 and 3). Do not add the extension to `ActiveExtensions[]`: as an access
   extension it only acts where a siteaccess names it in `ActiveAccessExtensions[]`, so the other siteaccesses keep
   their own design. Then regenerate the extension autoloads if your installation keeps them
   (`php bin/php/ezpgenerateautoloads.php -e`; the extension has no classes, so this only refreshes the list).
2. Create the siteaccess `settings/siteaccess/adminui/`. Copy the admin siteaccess's settings as a base, then set
   the design chain and switch the extension on for this siteaccess only:

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
   icon set and editor settings. Leave those files out, or empty them.
3. Add the siteaccess to `settings/override/site.ini.append.php`, `[SiteAccessSettings]`:
   `AvailableSiteAccessList[]=adminui`. With URI matching, the interface is at `https://<host>/adminui`. A host match
   (`HostMatchMapItems[]=admin.example.com;adminui`) gives it a host of its own.
4. Clear the caches:
   `php bin/php/ezcache.php --clear-tag=ini --allow-root-user` and
   `php bin/php/ezcache.php --clear-id=template,template-override,template-block,content,translation --allow-root-user`.
   Under Exponential Velocity, also run `./console exp:velocity cache clear --allow-root-user`.

The extension has no PHP classes, modules or database tables. It is a design with settings.

## Configuration

`settings/exp_adminui.ini` (override per siteaccess in `settings/siteaccess/adminui/exp_adminui.ini.append.php`):

| Setting | Default | Meaning |
|---|---|---|
| `[AdminUISettings] Title` | Exponential Admin UI | Window title, generator meta tag, logo tooltip |
| `[AdminUISettings] LogoType` | exponential | `exponential` (Exponential logo), `default` or `ngadminui` (the reference's logos) |
| `[MenuPlugins] Enabled[]` | legacy, layouts, tags, information_collection, cache, bookmarks | The side bar blocks, top to bottom |
| `[MenuPlugin_<name>] URL` | explayouts_ui/dashboard, tags/dashboard, infocollector/overview | Where a side bar entry points |
| `[ViewSettings] DefaultTab`, `DefaultTabs[<class>]` | view; subitems for containers | The tab a node view opens on |
| `[SnippetEditorSettings]` | ng_htmlbox / html_code | Text fields edited with the Ace code editor |

See [doc/settings.md](doc/settings.md) for every setting, including the ones the extension brings to `icon.ini`,
`menu.ini`, `ezoe.ini` and `zone.ini`.

## Documentation

The guide is in [doc/](doc/README.md): architecture, every view with its template, the Twig-to-template mapping
used for the port, the merge of the Admin UI templates with Exponential's changes, settings, extending the design,
known gaps and troubleshooting. [doc/ASSETS.md](doc/ASSETS.md) lists every copied file with its sha256.

## Credits and licence

Exponential Admin UI is Copyright (C) 2026 7x and licensed under the GNU General Public License v2.0 or (at your
option) any later version. See [LICENSE](LICENSE).

It is a port of **Netgen Admin UI** (Composer package `netgen/admin-ui-bundle`, used here from its fork
`se7enxweb/admin-ui-bundle` 2.9.15), Copyright (C) Netgen (https://netgen.io) and contributors, GPL-2.0-or-later.
Its legacy design templates derive from the eZ Publish Legacy administration design, Copyright (C) eZ Systems AS,
GPL-2.0. Third-party libraries are included as Netgen Admin UI ships them: Font Awesome 4.4, Bootstrap 3.3.5,
jQuery UI 1.11.4, Ace, Roboto and Material Icons. [NOTICE](NOTICE) has their copyrights and licences.
