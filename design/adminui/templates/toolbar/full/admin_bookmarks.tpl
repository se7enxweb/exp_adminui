{* The bookmarks of the side bar: Exponential's bookmark tree (virtual folders, content/bookmark_tree.tpl in
   sidebar mode) and the Add to bookmarks form with the folder to add to. The side bar (adminui/menu/aside.tpl)
   checks the content/bookmark access before it includes this. *}
{def $bookmark_rows = fetch( 'content', 'bookmark_rows', hash() )
     $bookmark_folders = fetch( 'content', 'bookmark_folders', hash() )}
{if $bookmark_rows}
<div class="exp-bm-scroll">
{include uri='design:content/bookmark_tree.tpl' mode='sidebar' rows=$bookmark_rows ui_context=$ui_context}
</div>
{/if}

{* Show "Add to bookmarks" button if we're viewing an actual node. *}
{if and( is_set( $module_result.content_info.node_id ), $ui_context|ne( 'edit' ), $ui_context|ne( 'browse' ) )}
    <form method="post" action={'content/action'|ezurl}>
        <input type="hidden" name="ContentNodeID" value="{$module_result.content_info.node_id}" />
        {if $bookmark_folders}
        <label class="exp-bm-sr" for="exp-bm-add-folder">{'Folder'|i18n( 'design/admin/content/bookmark' )}</label>
        <select name="BookmarkFolderID" id="exp-bm-add-folder" class="exp-bm-add-folder form-control input-sm">
            <option value="0">{'Top level'|i18n( 'design/admin/content/bookmark' )}</option>
            {foreach $bookmark_folders as $folder}
            <option value="{$folder.id}">{'&nbsp;&nbsp;'|repeat( $folder.depth )}{$folder.name|wash}</option>
            {/foreach}
        </select>
        {/if}
        <input class="btn btn-primary" type="submit" name="ActionAddToBookmarks" value="{'Add to bookmarks'|i18n( 'design/admin/pagelayout' )}" title="{'Add the current item to your bookmarks.'|i18n( 'design/admin/pagelayout' )}" />
    </form>
{else}
    <form method="post" action={'content/action'|ezurl}>
        <input class="btn btn-default" type="submit" value="{'Add to bookmarks'|i18n( 'design/admin/pagelayout' )}" disabled="disabled" />
    </form>
{/if}
{undef $bookmark_rows $bookmark_folders}
