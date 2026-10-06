# Merging the Admin UI templates with Exponential's changes

## Why

Netgen copied the admin templates of its time into the `ngadminui` design and restyled them. Exponential 6 kept
developing its own copies after that: it escapes values it printed raw (`{$x|wash}`), moved from YUI to Exponential
UI (expui) and jQuery 4 (`.on()`, `.prop()`), and added menu entries, buttons, permission checks and views. A Netgen
template copied as it is would hide all of that in the adminui design, because the first design in the chain wins.

Comparing each Admin UI template's admin counterpart on the reference site (the base) with the one Exponential
serves today found 110 of 231 templates that Exponential has changed since.

## How

Each such template is a three-way merge:

| Side | File |
|---|---|
| base | the template the reference's admin chain (admin3, admin2, admin, standard, extension designs) serves |
| ours | the Netgen Admin UI template |
| theirs | the template Exponential's admin chain (admin4l, admin4, admin3 ...) serves |

The product rename (eZ Publish to Exponential) and trailing blanks are normalised first, so they do not count as
conflicts. Then `git merge-file` combines the two sets of changes:

- **Clean merges** (19) took Netgen's markup and Exponential's changes together without help.
- **Conflicts** (86) were resolved by hand, one hunk at a time, with one rule: keep the Admin UI look (Netgen's
  markup, ids and Bootstrap classes) and every Exponential feature and fix. Where Exponential rewrote a view
  completely, Exponential's version is the base and Netgen's classes are put back where they are only
  presentation. No YUI comes back.

Templates that were not changed on either side since (106) are the Netgen copies, unchanged.

## Templates that use admin4's version instead

These Netgen templates need YUI 2 or 3 code, which Exponential 6 does not ship. They are not in the adminui
design, so admin4's Exponential UI versions serve them, with `adminui.css` giving them the Admin UI look:

- `children.tpl` (the Netgen template is used, loading admin4's `ezajaxsubitems_expdatatable.js`) and
  `children_detailed.tpl` (admin4's, with the Netgen "Create new subitem" label): the sub-items table.
- `content/datatype/edit/ezdate.tpl`, `ezdatetime.tpl`: the expui date picker.
- `content/datatype/edit/ezobjectrelation_ajaxuploader.tpl`, `ezobjectrelationlist_ajaxuploader.tpl`: the expui upload dialog.
- `javascript/ezajaxsubitems_datatable.js`.

`content/edit.tpl` is the Netgen template with its YUI collapse of the object information column replaced by
jQuery. `tags/dashboard.tpl` is the Netgen template with eztags' sub-tag table. `content/trash.tpl` carries YUI
class names only (no YUI code), for the stylesheet, and is copied.

## Re-running

When Exponential changes an admin template again, the same audit finds it (the admin chain file differs from the
base), and the same merge, with the current adminui file as "ours", carries the change over.
