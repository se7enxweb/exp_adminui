{* Exponential Admin UI: the left column, from page_leftmenu.html.twig and the "left" template of the legacy menu
   plugin (menu/plugins/legacy/left.html.twig): a view's own left menu ($module_result.left_menu), else
   parts/<navigation part>/menu.tpl. Drawn only when it has content. *}
{def $left_menu_template = ''
     $left_menu_html     = ''
     $np_short           = $navigation_part_identifier|explode( 'navigationpart' )|implode( '' )}
{if $np_short|begins_with( 'ez' )}{set $np_short = $np_short|extract_right( $np_short|count_chars|sub( 2 ) )}{/if}
{if is_set( $module_result.left_menu )}
    {set $left_menu_template = $module_result.left_menu}
{else}
    {set $left_menu_template = concat( 'design:parts/', $np_short, '/menu.tpl' )}
{/if}
{set-block variable=$left_menu_html}{include uri=$left_menu_template uri_string=first_set( $module_result.uri, '' )|trim( '/' )}{/set-block}
{if $left_menu_html|trim|ne( '' )}
    <div id="left-column" class="left-column layout-column">
        <div class="layout-column-inner">
            <div class="inner-cell">
                {$left_menu_html}
            </div>
        </div>
    </div>
{/if}
{undef $left_menu_template $left_menu_html $np_short}
