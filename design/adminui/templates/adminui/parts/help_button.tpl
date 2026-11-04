{* Exponential Admin UI: the context Help control at the end of the header. It opens the help page of the module and
   view on screen (fetch( 'exphelp', 'context' ): the help system's context map for this design, falling back to the
   module's page and then the help dashboard; its url carries the heading anchor). Shown only when the kernel has
   the help module and the user may read the help (the fetch gives false otherwise), so an older kernel or a user
   without exphelp/read sees nothing. No inline script or style (stylesheets/adminui-pages.css).

   With a kernel that has the Help menu (exphelp.ini [ContextHelp] MenuLinks[], fetch exphelp/context_menu), the
   control is a menu as in admin4's header: a <details> disclosure (no script needed: the browser opens and closes
   it, Esc and the keyboard included) with a search of the help, the Help center right below it, the help for this
   page, the related topics and the quick links. Without it, a plain link to the help of the page. *}
{if ezini( 'ModuleSettings', 'ModuleList', 'module.ini' )|contains( 'exphelp' )}
{def $adminui_help_mp    = module_params()
     $adminui_help_ctx   = fetch( 'exphelp', 'context', hash( 'module', first_set( $adminui_help_mp.module_name, '' ),
                                                              'view', first_set( $adminui_help_mp.function_name, '' ),
                                                              'design', ezini( 'DesignSettings', 'SiteDesign', 'site.ini' ) ) )
     $adminui_help_label = ''
     $adminui_help_menu  = false()}
{if $adminui_help_ctx}
{if $adminui_help_ctx.title}
    {set $adminui_help_label = 'Help: %title'|i18n( 'kernel/exphelp',, hash( '%title', $adminui_help_ctx.title ) )}
{else}
    {set $adminui_help_label = 'Help for this page'|i18n( 'kernel/exphelp' )}
{/if}
{if ezini_hasvariable( 'ContextHelp', 'MenuLinks', 'exphelp.ini' )}
    {set $adminui_help_menu = fetch( 'exphelp', 'context_menu', hash( 'module', first_set( $adminui_help_mp.module_name, '' ),
                                                                      'view', first_set( $adminui_help_mp.function_name, '' ),
                                                                      'design', ezini( 'DesignSettings', 'SiteDesign', 'site.ini' ) ) )}
{/if}
{* marked on the help's own pages (exphelp/*), as the admin4 header marks its "?" *}
<div class="aui-help{if eq( first_set( $adminui_help_mp.module_name, '' ), 'exphelp' )} is-current{/if}">
{if $adminui_help_menu}
    {def $adminui_help_names = hash( 'getting_started',    'Getting started'|i18n( 'kernel/exphelp' ),
                                     'keyboard_shortcuts', 'Keyboard shortcuts'|i18n( 'kernel/exphelp' ),
                                     'whats_new',          "What's new"|i18n( 'kernel/exphelp' ),
                                     'report',             'Report an error'|i18n( 'kernel/exphelp' ),
                                     'git',                'Develop with Git'|i18n( 'kernel/exphelp' ) )}
    <details class="aui-help-menu">
        <summary class="aui-help-btn" title="{'Help menu'|i18n( 'kernel/exphelp' )|wash}">
            <i class="fa fa-question-circle" aria-hidden="true"></i>
            <span class="aui-help-label">{'Help'|i18n( 'kernel/exphelp' )}</span>
            <span class="sr-only">{'Help menu'|i18n( 'kernel/exphelp' )|wash}</span>
        </summary>
        <div class="aui-help-panel">
            <form class="aui-help-search" action={'/exphelp/search'|ezurl} method="get" role="search">
                <label class="sr-only" for="aui-help-q">{'Search the help'|i18n( 'kernel/exphelp' )|wash}</label>
                <input type="search" id="aui-help-q" class="form-control" name="q" maxlength="200" autocomplete="off" placeholder="{'Search the help'|i18n( 'kernel/exphelp' )|wash}" />
                <button type="submit" class="btn btn-default">{'Search'|i18n( 'kernel/exphelp' )|wash}</button>
            </form>
            <a class="aui-help-center" href={'/exphelp/dashboard'|ezurl}>{'Open the Help center'|i18n( 'kernel/exphelp' )|wash}</a>
            <a class="aui-help-front" href={$adminui_help_ctx.url|ezurl} title="{$adminui_help_label|wash}">
                <strong>{'Help for this page'|i18n( 'kernel/exphelp' )|wash}</strong>
                {if $adminui_help_ctx.title}<span>{$adminui_help_ctx.title|wash}</span>{/if}
            </a>
            {if $adminui_help_menu.topics|count}
            <p class="aui-help-heading" id="aui-help-topics">{'Related topics'|i18n( 'kernel/exphelp' )|wash}</p>
            <ul class="aui-help-list" aria-labelledby="aui-help-topics">
                {foreach $adminui_help_menu.topics as $adminui_help_item}
                <li><a href={$adminui_help_item.url|ezurl}>{$adminui_help_item.title|wash}</a></li>
                {/foreach}
            </ul>
            {/if}
            {if $adminui_help_menu.links|count}
            <p class="aui-help-heading" id="aui-help-links">{'Quick links'|i18n( 'kernel/exphelp' )|wash}</p>
            <ul class="aui-help-list" aria-labelledby="aui-help-links">
                {foreach $adminui_help_menu.links as $adminui_help_item}
                <li><a href={$adminui_help_item.url|ezurl}>{first_set( $adminui_help_names[$adminui_help_item.key], $adminui_help_item.title )|wash}</a></li>
                {/foreach}
            </ul>
            {/if}
        </div>
    </details>
    {undef $adminui_help_names}
{else}
    <a class="aui-help-btn" href={$adminui_help_ctx.url|ezurl} title="{$adminui_help_label|wash}" aria-label="{$adminui_help_label|wash}">
        <i class="fa fa-question-circle" aria-hidden="true"></i>
        <span class="aui-help-label">{'Help'|i18n( 'kernel/exphelp' )}</span>
    </a>
{/if}
</div>
{/if}
{undef $adminui_help_mp $adminui_help_ctx $adminui_help_label $adminui_help_menu}
{/if}
