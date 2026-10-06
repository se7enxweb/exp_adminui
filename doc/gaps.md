# Known gaps and deliberate differences

## Reference features backed by Symfony bundles

| Reference | Here | Why |
|---|---|---|
| Netgen Layouts admin (`/nglayouts/admin`, layout wizard, node "Layouts" tab with mappings) | Side bar "Layouts" opens Exponential Layouts (`explayouts_ui/dashboard`); the node tab is Exponential Layouts' own | The reference's pages are Symfony controllers of netgen/layouts; Exponential has its own layouts module |
| Netgen Tags admin (`/tags/admin/`) | Side bar "Tags" opens the eztags module (`tags/dashboard`), which the reference also has | The Symfony tags admin is not part of Exponential |
| Information collection admin (`/netgen/informationcollection/overview`) | Side bar "Collected information" opens `infocollector/overview` | Symfony bundle |
| Translations (`/translations/`, a Symfony message editor) | Not in the side bar | No Exponential equivalent; translation files are edited in the `.ts` files |
| Lists by class (`/classlists/list`) | Not in the side bar: the ezclasslists extension is not installed on alpha | It is that extension's own top menu tab; it appears wherever the extension is active |

## Deliberate differences

- **Branding**: the Exponential logo and names replace the Netgen marks (owner decision). `LogoType=ngadminui`
  brings the reference logo back.
- **Editor engine**: the online editor follows Exponential's engine choice (TinyMCE 8 or 3). The reference had
  TinyMCE 3 only. Under TinyMCE 3 the Admin UI dialog skin (`tinyngadminui`) is used.
- **Sub-items table, date fields, uploads**: Exponential UI widgets with the Admin UI look, in place of the
  reference's YUI widgets. Their DOM differs, so `adminui.css` reproduces the look. Spacing can differ by a pixel
  or two. They also do more: column presets, CSV export, "Create multiple new", copy/hide/unhide selected.
- **More entries**: the side bar and left menus show everything Exponential has (Audit, Git, Export, Newsletter,
  E-mail preferences, Maintenance ...). The side bar scrolls when they do not fit, as the reference's does.
- **Below 640px** the reference covers the page with "The current window is too small". So does the port.
- **Glyphicons**: the reference's `style.css` loads the Bootstrap glyphicon font from an absolute Symfony path
  (`/bundles/netgenadminui/...`). The copied file keeps that path, so the font does not load. No Admin UI
  template uses glyphicons; the fonts are in `fonts/bootstrap/` should a rule ever need them.
- **Material Icons TTF**: `style.css` names `../font/MaterialIcons/...ttf` (a typo upstream). Browsers use the
  WOFF2 file, which loads.

## Not ported

- The reference's `tabs/nglayouts*.tpl` (a node tab that renders Netgen Layouts mappings through Symfony) is copied
  but not switched on (`admininterface.ini` has no `AdditionalTabs[]=nglayouts`).
- The YUI stand-ins of the reference's `page_head_script.html.twig` (`YUILoader`, `ContentStructureMenu`,
  `treeMenu` stubs). Nothing here uses YUI.

## Differences from Exponential's own admin (admin4)

- **Accent colour**: Exponential's pages use the Admin UI blue in adminui (owner decision); admin4 keeps its orange.
- **Root font size**: the Admin UI stylesheet is Bootstrap 3 (10px root). adminui sets the root back to 16px for
  Exponential's rem-sized page styles and repeats the Admin UI's own rem rules in px (`adminui-rem.css`).
- **Contrast**: a few of Exponential's greys and tints that are just under 4.5:1 are darkened within their hue in
  adminui (`adminui-modules.css`). The Admin UI's own colours (left menu links on grey, the path label, white table
  heads on grey, grey node tabs) are kept as the reference has them, although some are under 4.5:1 too.
