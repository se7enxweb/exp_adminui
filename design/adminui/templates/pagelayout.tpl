{* Exponential Admin UI: the page frame. Ported from the Netgen Admin UI Twig layout
   (pagelayout.html.twig, pagelayout_variables.html.twig and pagelayout_legacy.html.twig of se7enxweb/admin-ui-bundle,
   GPL-2.0-or-later) to Exponential template code. The markup is the reference's, element for element, so its
   stylesheet (stylesheets/style.css, copied unchanged) draws it the same way. See doc/twig-to-tpl.md. *}
<!DOCTYPE html>
<html lang="{$site.http_equiv.Content-language|wash}">
<head>
{def $ui_context_edit   = eq( $ui_context, 'edit' )
     $content_edit      = and( $ui_context_edit, eq( $ui_component, 'content' ) )
     $adminui_navpart   = first_set( $module_result.navigation_part, $navigation_part.identifier, 'ezcontentnavigationpart' )
     $adminui_section   = first_set( $module_result.section_id, 0 )
     $persistent_vars   = first_set( $module_result.content_info.persistent_variable, array() )
     $show_side_menu    = true()
     $adminui_uri       = first_set( $module_result.uri, '' )
     $adminui_mp        = module_params()
     $user_hash         = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}
{* the side menu is left out of version previews, as in the reference *}
{if and( is_set( $adminui_mp.module_name ), eq( $adminui_mp.module_name, 'content' ), eq( first_set( $adminui_mp.function_name, '' ), 'versionview' ) )}
    {set $show_side_menu = false()}
{/if}
{include uri='design:adminui/page_head.tpl'}
    <title>{ezini( 'AdminUISettings', 'Title', 'exp_adminui.ini' )|wash}</title>
{include uri='design:page_head_style.tpl'}
{include uri='design:page_head_script.tpl'}
</head>

<body>
    <div id="page" class="{$adminui_navpart} section_id_{$adminui_section} {if or( $content_edit, $ui_context_edit )} content-edit{/if}{if $show_side_menu|not} hide-side-menu{/if}">
        <header id="header">
            <div class="header-nav">
                <a id="header-logo" class="logo-type-{ezini( 'AdminUISettings', 'LogoType', 'exp_adminui.ini' )|wash}" href={'/'|ezurl} title="{ezini( 'AdminUISettings', 'Title', 'exp_adminui.ini' )|wash}"></a>
            </div>
            {* the "top" part of the legacy menu plugin: the search box and a view's own top menu *}
            {include uri='design:adminui/parts/search_box.tpl'}
            {if is_set( $persistent_vars.top_menu )}{$persistent_vars.top_menu}{/if}
        </header>

        {if $show_side_menu}
            <aside id="aside">
                <div class="aside-wrap">
                    {include uri='design:adminui/page_aside_user.tpl'}

                    <div class="navi-wrap">
                        <div class="clearfix hidden-xs text-center hide" id="aside-user"></div>

                        <nav class="aside-nav">
                            <ul class="nav">
                                {include uri='design:adminui/menu/aside.tpl' navigation_part_identifier=$adminui_navpart}
                            </ul>
                        </nav>
                    </div>
                    <a id="menu-toggle"><i></i></a>
                </div>
            </aside>
        {/if}

        <div id="content">
            <div class="content-body">
                <div id="columns">
                    {if $content_edit|not}
                        {include uri='design:adminui/page_leftmenu.tpl' navigation_part_identifier=$adminui_navpart}
                    {/if}

                    <div id="main-column" class="main-column layout-column">
                        <div class="layout-column-inner">
                            <div class="inner-cell">
                                <div class="main-content">
                                    {if and( is_set( $module_result.path ), $module_result.path|count|gt( 0 ), ezini( 'AdminUISettings', 'NoPathNavigationParts', 'exp_adminui.ini' )|contains( $adminui_navpart )|not )}
                                        <div id="path"{if $content_edit} class="path-edit"{/if}>
                                            <div id="path-design">
                                                {include uri='design:adminui/page_toppath.tpl'}
                                            </div>
                                        </div>
                                    {/if}
                                    {$module_result.content}
                                    {include uri='design:adminui/page_footer.tpl'}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="break"></div>

        {* The popup menu include must be outside all divs. It is hidden by default. *}
        {include uri='design:popupmenu/popup_menu.tpl'}
    </div>

    <div id="overlay-mask" style="display:none;"></div>
    <img src={'loader.gif'|ezimage} id="ajaxuploader-loader" style="display:none;" alt="{'Loading...'|i18n( 'design/adminui/pagelayout' )}" />

    <div id="size-warning">
        <div class="size-warning-text">
            <span class="icon"></span>
            <h2>{'The current window is too small'|i18n( 'design/adminui/pagelayout' )}</h2>
            <p>{'Consider resizing your browser window or switching to another device to properly display the Admin UI interface.'|i18n( 'design/adminui/pagelayout' )}</p>
        </div>
    </div>
<!--DEBUG_REPORT-->
</body>
</html>
