{* Exponential Admin UI: the side bar menu. The reference draws it from its menu plugins in this order: legacy (the
   admin top menu, menu/plugins/legacy/aside.tpl), Layouts, Tags, Information collection, Cache, Bookmarks. Here
   each plugin is a block switched by exp_adminui.ini [MenuPlugins] and pointed at the Exponential module that does
   the job (explayouts_ui, tags, infocollector). See doc/views.md. *}
{def $plugins = ezini( 'MenuPlugins', 'Enabled', 'exp_adminui.ini' )
     $hide_navigation_parts = array()}
{if $plugins|contains( 'tags' )}{set $hide_navigation_parts = $hide_navigation_parts|append( 'eztagsnavigationpart' )}{/if}
{if $plugins|contains( 'layouts' )}{set $hide_navigation_parts = $hide_navigation_parts|append( 'ezexplayoutsuinavigationpart' )}{/if}
{if $plugins|contains( 'legacy' )}
    {include uri='design:menu/plugins/legacy/aside.tpl' hide_navigation_parts=$hide_navigation_parts}
{/if}
{if and( $plugins|contains( 'layouts' ), fetch( 'user', 'has_access_to', hash( 'module', 'explayouts_ui', 'function', 'read' ) ) )}
    <li{if eq( $navigation_part_identifier, 'ezexplayoutsuinavigationpart' )} class="active"{/if}>
        <a href={ezini( 'MenuPlugin_layouts', 'URL', 'exp_adminui.ini' )|ezurl}>
            <i class="fa fa-columns"></i>
            <span class="tt">{'Layouts'|i18n( 'design/adminui/menu' )}</span>
        </a>
    </li>
{/if}
{if and( $plugins|contains( 'tags' ), fetch( 'user', 'has_access_to', hash( 'module', 'tags', 'function', 'read' ) ) )}
    <li{if eq( $navigation_part_identifier, 'eztagsnavigationpart' )} class="active"{/if}>
        <a href={ezini( 'MenuPlugin_tags', 'URL', 'exp_adminui.ini' )|ezurl}>
            <i class="fa fa-tags"></i>
            <span class="tt">{'Tags'|i18n( 'design/adminui/menu' )}</span>
        </a>
    </li>
{/if}
{if and( $plugins|contains( 'information_collection' ), fetch( 'user', 'has_access_to', hash( 'module', 'infocollector', 'function', 'read' ) ) )}
    <li{if and( is_set( $module_result.uri ), $module_result.uri|begins_with( '/infocollector' ) )} class="active"{/if}>
        <a href={ezini( 'MenuPlugin_information_collection', 'URL', 'exp_adminui.ini' )|ezurl}>
            <i class="fa fa-inbox"></i>
            <span class="tt">{'Collected information'|i18n( 'design/adminui/menu' )}</span>
        </a>
    </li>
{/if}
{if and( $plugins|contains( 'cache' ), fetch( 'user', 'has_access_to', hash( 'module', 'setup', 'function', 'managecache' ) ) )}
    <li class="aside-dropdown">
        <a href="#" class="aside-dropdown-toggle" data-toggle="dropdown">
            <i class="fa fa-refresh"></i>
            <span class="tt">{'Cache'|i18n( 'design/adminui/menu' )}</span>
            <span class="caret"></span>
        </a>

        <div class="dropdown-menu dropdown-cache">
            <div id="clearcache-tool" class="clearcache-tool">
                {if ne( $ui_context, 'browse' )}
                    {if eq( $ui_context, 'edit' )}
                        <h4><span class="disabled">{'Clear cache'|i18n( 'design/adminui/menu' )}</span></h4>
                    {else}
                        <h4>{'Clear cache'|i18n( 'design/adminui/menu' )}</h4>
                    {/if}
                {/if}
                {include uri='design:setup/clear_cache.tpl'}
            </div>
        </div>
    </li>
{/if}
{if and( $plugins|contains( 'bookmarks' ), fetch( 'user', 'has_access_to', hash( 'module', 'content', 'function', 'bookmark' ) ) )}
    <li class="aside-dropdown">
        <a class="aside-dropdown-toggle" data-toggle="dropdown">
            <i class="fa fa-bookmark"></i>
            <span class="tt">{'Bookmarks'|i18n( 'design/adminui/menu' )}</span>
            <span class="caret"></span>
        </a>

        <div class="dropdown-menu dropdown-cache">
            <div id="bookmarks">
                {if ne( $ui_context, 'browse' )}
                    {if eq( $ui_context, 'edit' )}
                        <h4><span class="disabled">{'Bookmarks'|i18n( 'design/adminui/menu' )}</span></h4>
                    {else}
                        <h4>{'Bookmarks'|i18n( 'design/adminui/menu' )}</h4>
                    {/if}
                {/if}

                <div class="box-content">
                    {include uri='design:toolbar/full/admin_bookmarks.tpl'}
                </div>
            </div>
        </div>
    </li>
{/if}
{undef $plugins $hide_navigation_parts}
