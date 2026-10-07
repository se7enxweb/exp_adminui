{* Window controls of the class view: the class has no node, so nothing here reads one *}
{def $default_tab         = 'view'
     $node_tab_index      = first_set( $view_parameters.tab, $default_tab )
     $read_open_tab_by_cookie = true()
     $additional_tabs = array()}


<ul class="tabs{if $read_open_tab_by_cookie} tabs-by-cookie{/if} clearfix">

    {* Ordering *}
    <li id="node-tab-groups" class="{if $additional_tabs}middle{else}last{/if}{if $node_tab_index|eq('groups')} selected{/if}">
        <a href={'/user/preferences/set/admin_navigation_class_groups/1'|ezurl} title="{'Show class groups.'|i18n( 'design/admin/class/view' )}">{'Class groups'|i18n( 'design/admin/node/class/view' )}</a>
    </li>

    {* Content (pre)view *}
    <li id="node-tab-templates" class="first{if $node_tab_index|eq('templates')} selected{/if}">
        <a href={'/user/preferences/set/admin_navigation_class_temlates/1'|ezurl} title="{'Show override templates.'|i18n( 'design/admin/class/view' )}">{'Override templates'|i18n( 'design/admin/node/class/view' )}</a>
    </li>

    {* Locations *}
    <li id="node-tab-translations" class="middle{if $node_tab_index|eq('translations')} selected{/if}">
        <a href={'/user/preferences/set/admin_navigation_class_translations/1'|ezurl} title="{'Show available translations.'|i18n( 'design/admin/class/view' )}">{'Translations'|i18n( 'design/admin/class/view' )}</a>
    </li>
</ul>


{ezscript_require( 'node_tabs.js' )}
{undef}
