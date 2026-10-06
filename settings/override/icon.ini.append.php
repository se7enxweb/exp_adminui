<?php /* #?ini charset="utf-8"?

# Exponential Admin UI: settings/override of an access extension is read with the extension's other settings, before
# every globally active extension. So a class map an extension brings (cjw_newsletter maps its classes to crystal
# theme paths) still wins over this file; the design carries copies of fitting kp icons under those paths instead
# (images/icons/kp/<size>/filesystems/..., see doc/ASSETS.md). These lines only apply when no extension sets them.
[ClassIcons]
ClassMap[cjw_newsletter_root]=Mail-box.png
ClassMap[cjw_newsletter_system]=Folder.png
ClassMap[cjw_newsletter_list]=List.png
ClassMap[cjw_newsletter_edition]=Mail.png
*/ ?>
