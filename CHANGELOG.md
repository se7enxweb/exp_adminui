# Changelog

Releases of Exponential Admin UI (exp_adminui). Older releases are described on the
[GitHub releases page](https://github.com/se7enxweb/exp_adminui/releases).

## 1.0.0.56 (2026-10-29)

- Updated: One copyright notice, Exponential Foundation and 7x.

## 1.0.0.55 (2026-10-29)

- Updated: The footer carries the kernel notice "Exponential Copyright © 1998-2026 Exponential Foundation and 7x" (the same message as the admin designs, so it is translated already), and its Exponential link goes to https://exponential.earth; the old "1998-today 7x and others" line is gone.

## 1.0.0.54 (2026-10-29)

- Updated: The admin stylesheets use the shared admin tokens for weights, durations, radii, table headers and muted text, with the old values as fallbacks where a design has no tokens.

## 1.0.0.53 (2026-10-28)

- Removed: The Admin UI's width rule for .a4-help, which no help page uses any more.

## 1.0.0.52 (2026-10-26)

- Updated: The Admin UI head loads ClassicBackendJavaScriptList after BackendJavaScriptList, from ekked's pull
  request #4.
- Updated: The login page offers passkey sign-in, as the admin design's does.
- Updated: The account page has the Passkeys and Your devices cards of the admin design.
- Fixed: The inline CSS test finds the login page's passkey classes in adminui.css.

## 1.0.0.51 (2026-10-24)

- Added: The login form has a Remember me box, checked by default (shown when site.ini [Session]
  RememberMeTimeout is set; Exponential 6.0.15 sets it to 360 days). Before, an Admin UI sign-in always ended
  with the browser session.
- Added: Change password at next sign-in. The account form has the kernel's checkbox, shown only when you edit
  someone else's account and ticked while the account is new; the password page tells a marked user why they
  are there. Needs Exponential 6.0.15.

## 1.0.0.50 (2026-10-21)

- Updated: The Media library, User accounts and Webshop tabs name their icons in the adminui siteaccess's
  menu.ini (`Icon=images`, `Icon=people`, `Icon=box-seam`), with the comment the kernel's menu.ini uses for the
  setting. They are the icons an admin4 header draws for these tabs; the adminui side bar keeps its own Font
  Awesome icons.
- Updated: A modern README: who the extension is for, requirements, installation with Composer and by hand,
  every setting with an example block, usage, permissions, upgrading, known limits, troubleshooting, tests and
  contributing.
- Updated: composer.json credits Netgen, links the documentation and names the extension directory for both
  installers; extension.xml lists the bundled third-party software and the dependencies on ezjscore and expui.
- Added: This changelog.
