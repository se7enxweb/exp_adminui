# Templates of the adminui design

Every template in `design/adminui/templates/`, with where it comes from, and which admin design template it takes
the place of (the first one the chain admin4l, admin4, admin3, admin2, admin has under the same path; empty when
only adminui has it). Generated from the files; see merging.md for how "merged" templates were made.

- **new**: written for Exponential Admin UI (14)
- **copy**: the Netgen Admin UI template, unchanged (112)
- **merged**: the Netgen Admin UI template with Exponential's later changes merged in, or ported by hand (106)

| Template | Origin | Overrides |
|---|---|---|
| `adminui/menu/aside.tpl` | new |  |
| `adminui/page_aside_user.tpl` | new |  |
| `adminui/page_footer.tpl` | new |  |
| `adminui/page_head.tpl` | new |  |
| `adminui/page_leftmenu.tpl` | new |  |
| `adminui/page_search.tpl` | new |  |
| `adminui/page_toppath.tpl` | new |  |
| `adminui/parts/search_box.tpl` | new |  |
| `block/edit/edit.tpl` | copy |  |
| `children.tpl` | merged | `design/admin4` |
| `children_detailed.tpl` | merged | `design/admin4` |
| `class/classlist.tpl` | merged | `design/admin4` |
| `class/datatype/edit/ezbinaryfile.tpl` | copy |  |
| `class/datatype/edit/ezcountry.tpl` | merged |  |
| `class/datatype/edit/ezdate.tpl` | copy |  |
| `class/datatype/edit/ezdatetime.tpl` | merged |  |
| `class/datatype/edit/ezenum.tpl` | merged |  |
| `class/datatype/edit/ezfloat.tpl` | copy |  |
| `class/datatype/edit/ezidentifier.tpl` | copy |  |
| `class/datatype/edit/ezimage.tpl` | merged |  |
| `class/datatype/edit/ezinisetting.tpl` | copy |  |
| `class/datatype/edit/ezinteger.tpl` | copy |  |
| `class/datatype/edit/ezisbn.tpl` | copy |  |
| `class/datatype/edit/ezmatrix.tpl` | copy |  |
| `class/datatype/edit/ezmedia.tpl` | copy |  |
| `class/datatype/edit/ezmultiprice.tpl` | merged |  |
| `class/datatype/edit/ezobjectrelation.tpl` | copy |  |
| `class/datatype/edit/ezobjectrelationlist.tpl` | merged |  |
| `class/datatype/edit/ezpage.tpl` | copy |  |
| `class/datatype/edit/ezprice.tpl` | copy |  |
| `class/datatype/edit/ezrangeoption.tpl` | copy |  |
| `class/datatype/edit/ezstring.tpl` | copy |  |
| `class/datatype/edit/eztags.tpl` | copy |  |
| `class/datatype/edit/ezxmltext.tpl` | copy |  |
| `class/datatypes.tpl` | copy |  |
| `class/edit.tpl` | merged | `design/admin4` |
| `class/groupedit.tpl` | copy | `design/admin4` |
| `class/grouplist.tpl` | merged | `design/admin4` |
| `class/groups.tpl` | copy | `design/admin4` |
| `class/removegroup.tpl` | copy | `design/admin4` |
| `class/templates.tpl` | copy | `design/admin4` |
| `class/translations.tpl` | copy | `design/admin4` |
| `class/view.tpl` | merged | `design/admin4` |
| `class/window_controls.tpl` | copy | `design/admin4` |
| `class/windows.tpl` | copy | `design/admin4` |
| `collaboration/view/summary.tpl` | merged | `design/admin4` |
| `content/advancedsearch.tpl` | copy | `design/admin4` |
| `content/bookmark.tpl` | merged | `design/admin4` |
| `content/browse.tpl` | merged | `design/admin4` |
| `content/browse_mode_list.tpl` | merged | `design/admin4` |
| `content/browse_move_node.tpl` | merged | `design/admin4` |
| `content/browse_placement.tpl` | copy | `design/admin4` |
| `content/create_languages.tpl` | copy | `design/admin4` |
| `content/dashboard.tpl` | merged | `design/admin4` |
| `content/datatype/edit/ezauthor.tpl` | merged |  |
| `content/datatype/edit/ezbinaryfile.tpl` | copy |  |
| `content/datatype/edit/ezcountry.tpl` | merged |  |
| `content/datatype/edit/ezemail.tpl` | copy |  |
| `content/datatype/edit/ezenum.tpl` | merged |  |
| `content/datatype/edit/ezfloat.tpl` | copy |  |
| `content/datatype/edit/ezgmaplocation.tpl` | merged |  |
| `content/datatype/edit/ezimage.tpl` | copy |  |
| `content/datatype/edit/ezinisetting.tpl` | copy |  |
| `content/datatype/edit/ezinteger.tpl` | copy |  |
| `content/datatype/edit/ezisbn.tpl` | copy |  |
| `content/datatype/edit/ezkeyword.tpl` | copy |  |
| `content/datatype/edit/ezmatrix.tpl` | copy |  |
| `content/datatype/edit/ezmedia.tpl` | merged |  |
| `content/datatype/edit/ezmultioption.tpl` | merged |  |
| `content/datatype/edit/ezmultioption2.tpl` | copy |  |
| `content/datatype/edit/ezmultioption2_rules.tpl` | copy |  |
| `content/datatype/edit/ezmultiprice.tpl` | merged |  |
| `content/datatype/edit/ezobjectrelation.tpl` | merged |  |
| `content/datatype/edit/ezobjectrelationlist.tpl` | merged |  |
| `content/datatype/edit/ezpackage.tpl` | merged |  |
| `content/datatype/edit/ezprice.tpl` | merged |  |
| `content/datatype/edit/ezproductcategory.tpl` | merged |  |
| `content/datatype/edit/ezrangeoption.tpl` | copy |  |
| `content/datatype/edit/ezselection.tpl` | merged |  |
| `content/datatype/edit/ezstring.tpl` | copy |  |
| `content/datatype/edit/eztext.tpl` | merged |  |
| `content/datatype/edit/eztime.tpl` | copy |  |
| `content/datatype/edit/ezurl.tpl` | copy |  |
| `content/datatype/edit/ezuser.tpl` | copy |  |
| `content/datatype/edit/ezxmltext.tpl` | copy |  |
| `content/datatype/edit/ezxmltext_ezoe.tpl` | merged |  |
| `content/datatype/edit/multioption2/multioption.tpl` | merged |  |
| `content/datatype/edit/multioption2/multioption2.tpl` | merged |  |
| `content/datatype/edit/multioption2/multioption_rule.tpl` | merged |  |
| `content/datatype/edit/ngclasslist.tpl` | copy |  |
| `content/datatype/edit/sckenhancedselection.tpl` | merged |  |
| `content/datatype/edit/xrowmetadata.tpl` | merged |  |
| `content/datatype/view/ezmultioption.tpl` | merged |  |
| `content/datatype/view/ezrangeoption.tpl` | copy |  |
| `content/datatype/view/eztags.tpl` | merged |  |
| `content/datatype/view/ezuser.tpl` | copy |  |
| `content/datatype/view/multioption2/multioption.tpl` | merged |  |
| `content/draft.tpl` | copy | `design/admin4` |
| `content/edit.tpl` | merged | `design/admin4` |
| `content/edit_attribute.tpl` | merged | `design/admin4` |
| `content/edit_draft.tpl` | copy | `design/admin4` |
| `content/edit_languages.tpl` | merged | `design/admin4` |
| `content/edit_locations.tpl` | copy | `design/admin4` |
| `content/edit_menu.tpl` | copy | `design/admin4` |
| `content/edit_validation.tpl` | copy | `design/admin4` |
| `content/history.tpl` | merged | `design/admin4` |
| `content/parts/edit_sections.tpl` | copy | `design/admin4` |
| `content/parts/edit_states.tpl` | copy | `design/admin4` |
| `content/parts/object_information.tpl` | copy | `design/admin4` |
| `content/restore.tpl` | copy | `design/admin4` |
| `content/search.tpl` | copy | `design/admin4` |
| `content/translationnew.tpl` | merged | `design/admin4` |
| `content/translations.tpl` | merged | `design/admin4` |
| `content/translationview.tpl` | merged | `design/admin4` |
| `content/trash.tpl` | merged | `design/admin4` |
| `content/urlalias_global.tpl` | merged | `design/admin4` |
| `content/urlalias_wildcard.tpl` | copy | `design/admin4` |
| `content/view/versioncontrol.tpl` | copy |  |
| `content/view/versionview.tpl` | merged | `design/admin4` |
| `contentstructuremenu/content_structure_menu_dynamic.tpl` | merged | `design/admin4` |
| `dashboard/all_latest_content.tpl` | merged |  |
| `dashboard/drafts.tpl` | copy |  |
| `dashboard/latest_content.tpl` | copy |  |
| `infocollector/collectionlist.tpl` | copy | `design/admin` |
| `infocollector/confirmremoval.tpl` | copy | `design/admin4` |
| `infocollector/overview.tpl` | merged | `design/admin` |
| `infocollector/view.tpl` | copy | `design/admin` |
| `locations.tpl` | merged | `design/admin4` |
| `loginpagelayout.tpl` | new | `design/admin4` |
| `menu/plugins/legacy/aside.tpl` | merged |  |
| `no_children.tpl` | copy | `design/admin4` |
| `node/removeobject.tpl` | merged | `design/admin4` |
| `node/view/admin_preview.tpl` | copy | `design/admin4` |
| `node/view/full.tpl` | merged | `design/admin4` |
| `notification/handler/ezcollaboration/settings/edit.tpl` | merged | `design/admin4` |
| `notification/handler/ezgeneraldigest/settings/edit.tpl` | merged | `design/admin4` |
| `notification/handler/ezsubtree/settings/edit.tpl` | merged | `design/admin4` |
| `notification/settings.tpl` | merged | `design/admin4` |
| `package/create.tpl` | merged | `design/admin4` |
| `package/create/changelog.tpl` | copy | `design/admin4` |
| `package/create/error.tpl` | copy | `design/admin4` |
| `package/create/info.tpl` | merged | `design/admin4` |
| `package/create/maintainer.tpl` | copy | `design/admin4` |
| `package/create/thumbnail.tpl` | copy | `design/admin4` |
| `package/creators/ezcontentclass/class.tpl` | merged |  |
| `package/creators/ezcontentobject/object_limit.tpl` | copy | `design/admin4` |
| `package/creators/ezcontentobject/object_select.tpl` | merged | `design/admin4` |
| `package/creators/ezextension/extension.tpl` | merged |  |
| `package/creators/ezstyle/cssfile.tpl` | copy | `design/admin4` |
| `package/creators/ezstyle/imagefiles.tpl` | copy | `design/admin4` |
| `package/header.tpl` | copy | `design/admin4` |
| `package/install.tpl` | merged | `design/admin4` |
| `package/list.tpl` | merged | `design/admin4` |
| `package/navigator.tpl` | merged | `design/admin4` |
| `package/upload.tpl` | copy | `design/admin4` |
| `package/view/files.tpl` | merged | `design/admin4` |
| `package/view/full.tpl` | merged | `design/admin4` |
| `page_aside_user.tpl` | copy |  |
| `page_head_script.tpl` | new | `design/admin4` |
| `page_head_style.tpl` | new | `design/admin4` |
| `pagelayout.tpl` | new | `design/admin4l` |
| `parts/content/menu.tpl` | copy | `design/admin4` |
| `parts/explayouts_ui/menu.tpl` | new |  |
| `parts/ini_menu.tpl` | merged | `design/admin4` |
| `parts/media/menu.tpl` | merged | `design/admin4` |
| `parts/my/menu.tpl` | merged | `design/admin4` |
| `parts/setup/menu.tpl` | merged | `design/admin4` |
| `parts/shop/menu.tpl` | merged | `design/admin4` |
| `parts/tags/menu.tpl` | copy |  |
| `parts/user/menu.tpl` | merged | `design/admin4` |
| `parts/visual/menu.tpl` | merged | `design/admin4` |
| `pdf/edit.tpl` | merged | `design/admin4` |
| `pdf/list.tpl` | merged | `design/admin4` |
| `preview.tpl` | copy | `design/admin4` |
| `relations.tpl` | copy | `design/admin4` |
| `role/assign_limited_section.tpl` | copy | `design/admin4` |
| `role/createpolicystep1.tpl` | merged | `design/admin4` |
| `role/createpolicystep2.tpl` | copy | `design/admin4` |
| `role/createpolicystep3.tpl` | copy | `design/admin4` |
| `role/edit.tpl` | merged | `design/admin4` |
| `role/list.tpl` | merged | `design/admin4` |
| `role/policyedit.tpl` | copy | `design/admin4` |
| `role/view.tpl` | merged | `design/admin4` |
| `rss/list.tpl` | merged | `design/admin4` |
| `search/stats.tpl` | merged | `design/admin4` |
| `section/list.tpl` | merged | `design/admin4` |
| `settings/view.tpl` | merged | `design/admin4` |
| `setup/cache.tpl` | merged | `design/admin4` |
| `setup/clear_cache.tpl` | merged |  |
| `setup/extensions.tpl` | merged | `design/admin4` |
| `setup/info.tpl` | merged | `design/admin4` |
| `setup/quick_settings.tpl` | merged | `design/admin4` |
| `setup/rad.tpl` | merged | `design/admin4` |
| `setup/systemupgrade.tpl` | copy | `design/admin4` |
| `state/group.tpl` | merged | `design/admin4` |
| `state/group_edit.tpl` | merged | `design/admin4` |
| `state/groups.tpl` | merged | `design/admin4` |
| `subitems.tpl` | copy |  |
| `tabs/nglayouts.tpl` | copy |  |
| `tabs/nglayouts_header.tpl` | copy |  |
| `tabs/user/roles.tpl` | copy | `design/admin4` |
| `tags/add.tpl` | copy |  |
| `tags/add_languages.tpl` | copy |  |
| `tags/addsynonym.tpl` | copy |  |
| `tags/addsynonym_languages.tpl` | copy |  |
| `tags/dashboard.tpl` | merged |  |
| `tags/delete.tpl` | copy |  |
| `tags/edit.tpl` | copy |  |
| `tags/edit_languages.tpl` | copy |  |
| `tags/makesynonym.tpl` | copy |  |
| `tags/merge.tpl` | copy |  |
| `tags/tabs/tags_search.tpl` | copy |  |
| `tags/tabs/translations.tpl` | merged |  |
| `tagsstructuremenu/tags_structure_menu_dynamic.tpl` | copy |  |
| `toolbar/full/admin_bookmarks.tpl` | merged | `design/admin4` |
| `toolbar/full/admin_quick_settings.tpl` | copy | `design/admin4` |
| `translations.tpl` | merged | `design/admin4` |
| `trigger/list.tpl` | copy | `design/admin4` |
| `url/list.tpl` | copy | `design/admin4` |
| `url/view.tpl` | copy | `design/admin4` |
| `user/login.tpl` | new | `design/admin4` |
| `user/password.tpl` | merged | `design/admin4` |
| `window_controls.tpl` | merged | `design/admin4` |
| `window_controls_extratabs.tpl` | copy | `design/admin4` |
| `window_preview_toolbar.tpl` | copy |  |
| `windows.tpl` | copy | `design/admin4` |
| `windows_extratabs.tpl` | copy | `design/admin4` |
| `workflow/groupedit.tpl` | copy | `design/admin4` |
| `workflow/grouplist.tpl` | merged | `design/admin4` |
| `workflow/processlist.tpl` | merged | `design/admin4` |
| `workflow/view.tpl` | copy | `design/admin4` |
| `workflow/workflowlist.tpl` | copy | `design/admin4` |
