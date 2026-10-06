<?php /* #?ini charset="utf-8"?

# Exponential Admin UI: the side bar draws the admin top menu. Layouts and Tags have their own side bar entries
# (exp_adminui.ini [MenuPlugins]), so their tabs are left out here, as in the reference.

[TopAdminMenu]
HiddenTabs[]
HiddenTabs[]=explayouts_ui_dashboard
HiddenTabs[]=eztags

# The names the reference shows in the side bar (Exponential's menu.ini shortens them to Media, Users, Store)
[Topmenu_media]
Name=Media library

[Topmenu_users]
Name=User accounts

[Topmenu_shop]
Name=Webshop

# The setup left menu of the reference, in its order
[Leftmenu_setup]
Links[]
Links[cache]=setup/cache
Links[classes]=class/grouplist
Links[collected]=infocollector/overview
Links[extensions]=setup/extensions
Links[ini]=settings/view
Links[languages]=content/translations
Links[packages]=package/list
Links[rss]=rss/list
Links[search_statistics]=search/stats
Links[sections]=section/list
Links[states]=state/groups
Links[system_information]=setup/info
Links[upgrade_check]=setup/systemupgrade
Links[triggers]=trigger/list
Links[url_management]=url/list
Links[url_translator]=content/urltranslator
Links[url_wildcards]=content/urlwildcards
Links[workflows]=workflow/grouplist
Links[workflow_processes]=workflow/processlist
*/ ?>
