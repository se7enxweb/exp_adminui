{*
   Reusable menu template using menu.ini settings
   for links and names.

   Two input variables are expected as input:
   * ini_section : The ini section to read settings from
   * i18n_hash : (optional) Hash for i18n values

   See parts/setup/menu.tpl for example!

   A link is shown only to a user who may follow it: its PolicyList_<key>[] (node ids or module/function)
   and, with menu.ini [MenuAccessSettings] CheckViewAccess=enabled, its address itself, checked the way the
   kernel checks the request (fetch( 'user', 'can_open' )). A link the user cannot open is left out, or shown
   without a link with NoAccessLinks=disabled. A menu with no link left is left out.
   TrailLinks[] (optional, menu.ini) names links of the section drawn after all its other links, in the order
   TrailLinks[] names them, also after the links extensions append (the Dashboard menu's Change password and Edit
   profile). Access is checked as for every link; a key the user may not open is left out as always.
   CollapseAfter=<n> (optional, menu.ini): the menu shows its first <n> links, in the order drawn (the trail links
   last), and the rest in a "More (count)" disclosure below them, closed at first and open when it holds the current
   page. Without it, or with 0, every link shows.
*}

{if is_unset( $ini_section )}
    {def $ini_section  = 'Leftmenu_'
         $i18n_section = 'design/admin/parts/menu'}
{elseif $ini_section|contains('_')}
    {def $i18n_section = concat('design/admin/parts/', $ini_section|explode('_')[1], '/menu')}
{else}
    {def $i18n_section = 'design/admin/parts/menu'}
{/if}

{if is_unset( $i18n_hash )}
    {def $i18n_hash = hash()}
{/if}

{* the request address: uri_string when the menu template passes it on, else the page's own *}
{if and( is_set( $uri_string ), $uri_string )}
    {def $current_uri_string = $uri_string}
{elseif and( is_set( $module_result.uri ), $module_result.uri|trim( '/' ) )}
    {def $current_uri_string = $module_result.uri|trim( '/' )}
{else}
    {def $current_uri_string = ezini( 'SiteSettings', 'IndexPage')}
{/if}
{* the request address carries the siteaccess of a URI siteaccess (adminui/setup/cache); the links do not *}
{def $site_prefix = '/'|ezurl( 'no' )|trim( '/' )}
{if and( $site_prefix|ne( '' ), $current_uri_string|trim( '/' )|begins_with( concat( $site_prefix, '/' ) ) )}
    {set $current_uri_string = $current_uri_string|trim( '/' )|extract_right( $current_uri_string|trim( '/' )|count_chars|sub( $site_prefix|count_chars, 1 ) )}
{/if}
{undef $site_prefix}


{if ezini_hasvariable( $ini_section, 'Links', 'menu.ini' )}
    {def $im_url_list   = ezini( $ini_section, 'Links', 'menu.ini' )
         $name_list  = hash()
         $menu_name  = ''
         $check      = array()
         $has_access = true()
         $item_name = ''
         $disabled = true()
         $enabled_hash = hash()
         $enabled_defaults = hash( 'default', 'true', 'edit', 'false', 'browse', 'false' )
         $check_view = ezini( 'MenuAccessSettings', 'CheckViewAccess', 'menu.ini' )|ne( 'disabled' )
         $hide_no_access = ezini( 'MenuAccessSettings', 'NoAccessLinks', 'menu.ini' )|ne( 'disabled' )
         $items = array()}

    {* LinkNames[] is optional: a link without one takes its name from $i18n_hash or its key *}
    {if ezini_hasvariable( $ini_section, 'LinkNames', 'menu.ini' )}
        {set $name_list = ezini( $ini_section, 'LinkNames', 'menu.ini' )}
    {/if}

    {if ezini_hasvariable( $ini_section, 'Name', 'menu.ini' )}
        {set $menu_name = ezini( $ini_section, 'Name', 'menu.ini' )}
    {/if}

    {* Check access globally *}
    {if ezini_hasvariable( $ini_section, 'PolicyList', 'menu.ini' )}
        {foreach ezini( $ini_section, 'PolicyList', 'menu.ini' ) as $policy}
            {if $policy|contains('/')}
                {set $check = $policy|explode('/')}
                {if fetch( 'user', 'has_access_to', hash( 'module', $check[0], 'function', $check[1] ) )|not}
                    {set $has_access = false()}
                    {break}
                {/if}
            {else}
                {set $check = fetch('content', 'node', hash( 'node_id', $policy ))}
                {if and( $check, $check.can_read )|not}
                    {set $has_access = false()}
                    {break}
                {/if}
            {/if}
        {/foreach}
    {/if}

    {if $has_access}
        {foreach $im_url_list as $link_key => $link_url}
            {if is_set( $name_list[ $link_key ] )}
                {set $item_name = $name_list[$link_key]|d18n($i18n_section)}
            {else}
                {set $item_name = first_set( $i18n_hash[ $link_key ], $link_key )|wash}
            {/if}

            {* Check if link should be disabled *}
            {if ezini_hasvariable( $ini_section, concat( 'Enabled_', $link_key ), 'menu.ini' )}
                {set $enabled_hash = $enabled_defaults|merge( ezini( $ini_section, concat( 'Enabled_', $link_key ), 'menu.ini' ) )}
            {else}
                {set $enabled_hash = $enabled_defaults}
            {/if}

            {if is_set( $enabled_hash[$ui_context] )}
                {set $disabled = $enabled_hash[$ui_context]}
            {else}
                {set $disabled = $enabled_hash['default']|eq( 'false' )}
            {/if}

            {* Check access per link: its policies, then its address *}
            {set $has_access = true()}
            {if ezini_hasvariable( $ini_section, concat( 'PolicyList_', $link_key ), 'menu.ini' )}
                {foreach ezini( $ini_section, concat( 'PolicyList_', $link_key ), 'menu.ini' ) as $policy}
                    {if $policy|contains('/')}
                        {set $check = $policy|explode('/')}
                        {if fetch( 'user', 'has_access_to', hash( 'module', $check[0], 'function', $check[1] ) )|not}
                            {set $has_access = false()}
                            {break}
                        {/if}
                    {else}
                        {set $check = fetch('content', 'node', hash( 'node_id', $policy ))}
                        {if and( $check, $check.can_read )|not}
                            {set $has_access = false()}
                            {break}
                        {/if}
                    {/if}
                {/foreach}
            {/if}
            {if and( $has_access, $check_view, $link_url|begins_with( 'http' )|not )}
                {set $has_access = fetch( 'user', 'can_open', hash( 'uri', $link_url ) )}
            {/if}

            {if $has_access}
                {set $items = $items|append( hash( 'key', $link_key, 'url', $link_url, 'name', $item_name, 'state', cond( $disabled, 'disabled', 'link' ) ) )}
            {elseif $hide_no_access|not}
                {set $items = $items|append( hash( 'key', $link_key, 'url', $link_url, 'name', $item_name, 'state', 'no-access' ) )}
            {/if}
        {/foreach}
    {/if}

    {* TrailLinks[]: the links named there move to the end, in that order; the rest keep theirs *}
    {if and( $items|count, ezini_hasvariable( $ini_section, 'TrailLinks', 'menu.ini' ) )}
        {def $trail_items = array()
             $trail_keys = array()
             $kept_items = array()}
        {foreach ezini( $ini_section, 'TrailLinks', 'menu.ini' ) as $trail_key}
            {foreach $items as $item}
                {if and( eq( $item.key, $trail_key ), $trail_keys|contains( $item.key )|not )}
                    {set $trail_items = $trail_items|append( $item )
                         $trail_keys = $trail_keys|append( $item.key )}
                {/if}
            {/foreach}
        {/foreach}
        {foreach $items as $item}
            {if $trail_keys|contains( $item.key )|not}
                {set $kept_items = $kept_items|append( $item )}
            {/if}
        {/foreach}
        {set $items = $kept_items|merge( $trail_items )}
        {undef $trail_items $trail_keys $kept_items}
    {/if}

    {if $items|count}
        {* DESIGN: Header START *}
        {if $menu_name}<h4 class="leftmenu-hl">{if is_set( $i18n_hash[ $menu_name ] )}{$i18n_hash[ $menu_name ]|wash}{else}{$menu_name|d18n($i18n_section)}{/if}</h4>{/if}
        {* DESIGN: Header END *}

        {* DESIGN: Content START *}

        {* CollapseAfter: the first links, then the rest in a "More" disclosure, open when it holds the current page *}
        {def $collapse_after = 0
             $im_parts = array( $items )
             $im_more_open = false()}
        {if ezini_hasvariable( $ini_section, 'CollapseAfter', 'menu.ini' )}
            {set $collapse_after = ezini( $ini_section, 'CollapseAfter', 'menu.ini' )}
        {/if}
        {if and( $collapse_after|gt( 0 ), $items|count|gt( $collapse_after ) )}
            {set $im_parts = array( $items|extract_left( $collapse_after ), $items|extract( $collapse_after ) )}
            {foreach $im_parts[1] as $item}
                {if and( eq( $item.state, 'link' ), $current_uri_string|begins_with( $item.url ) )}{set $im_more_open = true()}{/if}
            {/foreach}
        {/if}
        {foreach $im_parts as $im_part_index => $im_part}
        {if $im_part_index}<details class="leftmenu-more"{if $im_more_open} open{/if}><summary>{'More'|i18n( 'design/admin/pagelayout' )|wash} ({$im_part|count})</summary>{/if}
        <ul class="leftmenu-items-list">
        {foreach $im_part as $item}
            {if eq( $item.state, 'disabled' )}
                <li><span class="disabled">{$item.name}</span></li>
            {elseif eq( $item.state, 'link' )}
                <li{if $current_uri_string|begins_with( $item.url )} class="current"{/if}><a href={$item.url|ezurl}>{$item.name}</a></li>
            {else}
                <li class="disabled-no-access"><span class="disabled">{$item.name}</span></li>
            {/if}
        {/foreach}
        </ul>
        {if $im_part_index}</details>{/if}
        {/foreach}
        {undef $collapse_after $im_parts $im_more_open}

        {* DESIGN: Content END *}
    {/if}
    {undef $im_url_list $menu_name $check $has_access $items $check_view $hide_no_access}
{/if}
