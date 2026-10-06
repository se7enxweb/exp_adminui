{* Exponential Admin UI: the head of the page frame, from page_head.html.twig of the Netgen Admin UI bundle.
   Favicons, the generator, the base path and the old admin's left/right menu sizes. *}
    <meta charset="utf-8" />
    <meta name="generator" content="{ezini( 'AdminUISettings', 'Title', 'exp_adminui.ini' )|wash}" />
    {* the Exponential mark (images/exponential/); the reference's favicon set, manifest and tile config carried its
       own brand and are not linked *}
    <link rel="apple-touch-icon" sizes="180x180" href={'exponential/apple-touch-icon.png'|ezimage} />
    <link rel="icon" type="image/png" href={'exponential/favicon-32.png'|ezimage} sizes="32x32" />
    <link rel="icon" type="image/png" href={'exponential/favicon-16.png'|ezimage} sizes="16x16" />
    <link rel="shortcut icon" href={'exponential/favicon.ico'|ezimage} />
    <meta name="theme-color" content="#ffffff" />
    <meta name="ngadminui-base-path" content={'/'|ezurl} />
{def $hide_left_menu      = first_set( $module_result.content_info.persistent_variable.left_menu, $content_edit|not )|not
     $hide_right_menu     = first_set( $module_result.content_info.persistent_variable.extra_menu, $ui_context_edit|not )|not
     $collapse_right_menu = ezpreference( 'admin_right_menu_show' )|not
     $admin_left_size     = ezpreference( 'admin_left_menu_size' )
     $left_menu_widths    = ezini( 'LeftMenuSettings', 'MenuWidth', 'menu.ini' )}
{if $hide_right_menu}{set $collapse_right_menu = false()}{/if}
{if and( $ui_context_edit|not, or( $collapse_right_menu, $admin_left_size, $hide_left_menu ) )}
    <style type="text/css">
        {if $collapse_right_menu}
            div#page div#rightmenu {ldelim} width: 18px; {rdelim}
            div#page div#maincolumn {ldelim} margin-right: 27px; {rdelim}
        {/if}
        {if $hide_left_menu}
            div#maincolumn {ldelim} padding-right: 20px; padding-left: 50px; {rdelim}
        {elseif $admin_left_size}
            {if is_set( $left_menu_widths[$admin_left_size] )}
            div#leftmenu {ldelim} width: {$left_menu_widths[$admin_left_size]|wash}em; {rdelim}
            div#maincontent {ldelim} margin-left: {$left_menu_widths[$admin_left_size]|wash}em; {rdelim}
            {else}
            div#page div#leftmenu {ldelim} width: {$admin_left_size|wash}; {rdelim}
            div#page div#maincontent {ldelim} margin-left: {$admin_left_size|wash}; {rdelim}
            {/if}
        {/if}
    </style>
{/if}
{undef $hide_left_menu $hide_right_menu $collapse_right_menu $admin_left_size $left_menu_widths}
