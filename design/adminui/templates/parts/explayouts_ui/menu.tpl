{* Exponential Admin UI: the left menu of the Layouts pages in the reference's markup (the Layouts admin main menu
   in .layouts-sidebar .sidebar-nav, a plain list, the current page highlighted), in the reference's order: Layout
   mappings, Layouts, Shared layouts, Import; then Exponential Layouts' own Components and Dashboard. *}
{def $lm_uri   = first_set( $module_result.uri, '' )
     $lm_items = array( hash( 'view', 'rule_list',           'text', 'Layout mappings'|i18n( 'design/admin/parts/explayouts_ui/menu' ), 'also', array( 'rule_edit' ) ),
                        hash( 'view', 'layout_list',         'text', 'Layouts'|i18n( 'design/admin/parts/explayouts_ui/menu' ),         'also', array( 'layout_edit', 'layout_create' ) ),
                        hash( 'view', 'shared_layouts_list', 'text', 'Shared layouts'|i18n( 'design/admin/parts/explayouts_ui/menu' ),  'also', array() ),
                        hash( 'view', 'transfer_import',     'text', 'Import'|i18n( 'design/admin/parts/explayouts_ui/menu' ),          'also', array() ),
                        hash( 'view', 'components',          'text', 'Components'|i18n( 'design/admin/parts/explayouts_ui/menu' ),      'also', array() ),
                        hash( 'view', 'dashboard',           'text', 'Dashboard'|i18n( 'design/admin/parts/explayouts_ui/menu' ),       'also', array() ) )
     $lm_current = false()}
<div class="layouts-sidebar">
    <div class="sidebar-nav">
        <ul>
        {foreach $lm_items as $index => $item}
            {set $lm_current = $lm_uri|contains( concat( '/explayouts_ui/', $item.view ) )}
            {foreach $item.also as $also}{if $lm_uri|contains( concat( '/explayouts_ui/', $also ) )}{set $lm_current = true()}{/if}{/foreach}
            <li class="{if $lm_current}current {/if}{if eq( $index, 0 )}first{elseif eq( $index, $lm_items|count|dec )}last{/if}"><a href={concat( 'explayouts_ui/', $item.view )|ezurl}>{$item.text|wash}</a></li>
        {/foreach}
        </ul>
    </div>
</div>
{undef $lm_uri $lm_items $lm_current}
