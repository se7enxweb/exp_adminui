{* Exponential Admin UI dashboard. The same widgets and checks as admin4's dashboard (design/admin4/templates/content/dashboard.tpl),
   in the Admin UI look: a welcome band with the quick actions as Admin UI buttons, the key figures as panels, the last
   14 days of publishing, the system panel with the maintenance notice (dashboard/maintenance.tpl), "Stay secure" and
   every block of dashboard.ini [DashboardSettings] DashboardBlocks in its priority order, each through its own template
   (Template= or dashboard/<identifier>.tpl), an extension's block included. Styles: stylesheets/adminui-dashboard.css.
   Read-only fetches, cheap counts. *}
{* set scope=global persistent_variable=hash('extra_menu', false()) *}
{* $user (the current user) is set by the content/dashboard view *}
{def $root_node   = ezini( 'NodeSettings', 'RootNode', 'content.ini' )
     $media_node  = ezini( 'NodeSettings', 'MediaRootNode', 'content.ini' )
     $users_node  = ezini( 'NodeSettings', 'UserRootNode', 'content.ini' )
     $extensions  = ezini( 'ExtensionSettings', 'ActiveExtensions' )
     $hour        = currentdate()|datetime( 'custom', '%H' )|int
     $day_start   = maketime( 0, 0, 0, currentdate()|datetime( 'custom', '%n' ), currentdate()|datetime( 'custom', '%j' ), currentdate()|datetime( 'custom', '%Y' ) )
     $greeting    = 'Good evening'|i18n( 'design/admin/dashboard' )}
{if and( ge( $hour, 5 ), lt( $hour, 12 ) )}{set $greeting = 'Good morning'|i18n( 'design/admin/dashboard' )}
{elseif and( ge( $hour, 12 ), lt( $hour, 18 ) )}{set $greeting = 'Good afternoon'|i18n( 'design/admin/dashboard' )}{/if}

{* What the user can open: every link below is shown only to a user who can follow it, checked the way
   the kernel checks the request (fetch user/can_open: the view's policies with their limitations, the
   siteaccess, the node). No role names. *}
{def $can = hash(
        'content',  fetch( 'user', 'can_open', hash( 'uri', concat( 'content/view/full/', $root_node ) ) ),
        'media',    fetch( 'user', 'can_open', hash( 'uri', concat( 'content/view/full/', $media_node ) ) ),
        'users',    fetch( 'user', 'can_open', hash( 'uri', concat( 'content/view/full/', $users_node ) ) ),
        'upload',   and( $extensions|contains( 'ezmultiupload' ), fetch( 'user', 'can_open', hash( 'uri', concat( 'ezmultiupload/upload/', $media_node ) ) ) ),
        'tags',     and( $extensions|contains( 'eztags' ), fetch( 'user', 'can_open', hash( 'uri', 'tags/dashboard' ) ) ),
        'layouts',  and( $extensions|contains( 'explayouts_ui' ), fetch( 'user', 'can_open', hash( 'uri', 'explayouts_ui/dashboard' ) ) ),
        'cache',    fetch( 'user', 'can_open', hash( 'uri', 'setup/cache' ) ),
        'info',     fetch( 'user', 'can_open', hash( 'uri', 'setup/info' ) ),
        'upgrade',  fetch( 'user', 'can_open', hash( 'uri', 'setup/systemupgrade' ) ),
        'sessions', fetch( 'user', 'can_open', hash( 'uri', 'setup/session' ) ),
        'drafts',   fetch( 'user', 'can_open', hash( 'uri', 'content/draft' ) ),
        'pending',  fetch( 'user', 'can_open', hash( 'uri', 'content/pendinglist' ) ),
        'trash',    fetch( 'user', 'can_open', hash( 'uri', 'content/trash' ) ) )}

{* Key figures *}
{def $count_content   = fetch( 'content', 'tree_count', hash( 'parent_node_id', $root_node ) )
     $count_week      = fetch( 'content', 'tree_count', hash( 'parent_node_id', 1, 'attribute_filter', array( array( 'published', '>=', sub( $day_start, mul( 6, 86400 ) ) ) ) ) )
     $count_drafts    = fetch( 'content', 'draft_count' )
     $count_pending   = fetch( 'content', 'pending_count' )
     $count_users     = fetch( 'content', 'tree_count', hash( 'parent_node_id', $users_node, 'class_filter_type', 'include', 'class_filter_array', array( 'user' ) ) )
     $count_online    = fetch( 'user', 'logged_in_count' )
     $count_media     = fetch( 'content', 'tree_count', hash( 'parent_node_id', $media_node ) )
     $count_trash     = fetch( 'content', 'trash_count' )}

{* The last 14 days of publishing, oldest first *}
{def $days = array() $day_max = 1 $day_from = 0 $day_count = 0}
{for 13 to 0 as $i}
    {set $day_from = sub( $day_start, mul( $i, 86400 ) )}
    {set $day_count = fetch( 'content', 'tree_count', hash( 'parent_node_id', 1, 'attribute_filter', array( array( 'published', 'between', array( $day_from, sum( $day_from, 86399 ) ) ) ) ) )}
    {set $days = $days|append( hash( 'time', $day_from, 'count', $day_count ) )}
    {if gt( $day_count, $day_max )}{set $day_max = $day_count}{/if}
{/for}

<div class="context-block content-dashboard">
<div class="panel">
<div class="aui-dashboard">

    {* ---- Welcome ---- *}
    <section class="aui-dash-hero">
        <div class="aui-dash-hero-text">
            <p class="aui-dash-date">{currentdate()|l10n( 'date' )}</p>
            <h1>{$greeting}, {$user.contentobject.name|wash}</h1>
            <p class="aui-dash-sub">{'Here is what is happening on %site.'|i18n( 'design/admin/dashboard', , hash( '%site', ezini( 'SiteSettings', 'SiteName' )|wash ) )}</p>
        </div>
        <nav class="aui-dash-actions" aria-label="{'Quick actions'|i18n( 'design/admin/dashboard' )|wash}">
            {if $can.content}
            <a class="btn btn-primary" href={concat( 'content/view/full/', $root_node )|ezurl}><i class="fa fa-sitemap" aria-hidden="true"></i> {'Content structure'|i18n( 'design/admin/dashboard' )}</a>
            {/if}
            {if $can.media}
            <a class="btn btn-default" href={concat( 'content/view/full/', $media_node )|ezurl}><i class="fa fa-picture-o" aria-hidden="true"></i> {'Media library'|i18n( 'design/admin/dashboard' )}</a>
            {/if}
            {if $can.upload}
            <a class="btn btn-default" href={concat( 'ezmultiupload/upload/', $media_node )|ezurl}><i class="fa fa-upload" aria-hidden="true"></i> {'Upload files'|i18n( 'design/admin/dashboard' )}</a>
            {/if}
            {if $can.users}
            <a class="btn btn-default" href={concat( 'content/view/full/', $users_node )|ezurl}><i class="fa fa-users" aria-hidden="true"></i> {'Users'|i18n( 'design/admin/dashboard' )}</a>
            {/if}
            {if $can.tags}
            <a class="btn btn-default" href={'tags/dashboard'|ezurl}><i class="fa fa-tags" aria-hidden="true"></i> {'Tags'|i18n( 'design/admin/dashboard' )}</a>
            {/if}
            {if $can.layouts}
            <a class="btn btn-default" href={'explayouts_ui/dashboard'|ezurl}><i class="fa fa-th-large" aria-hidden="true"></i> {'Layouts'|i18n( 'design/admin/dashboard' )}</a>
            {/if}
            {if $can.cache}
            <a class="btn btn-default" href={'setup/cache'|ezurl}><i class="fa fa-refresh" aria-hidden="true"></i> {'Caches'|i18n( 'design/admin/dashboard' )}</a>
            {/if}
        </nav>
    </section>

    {* ---- Key figures ---- *}
    <section class="aui-dash-figures" aria-label="{'Key figures'|i18n( 'design/admin/dashboard' )|wash}">
        {if $can.content}<a class="panel aui-dash-figure" href={concat( 'content/view/full/', $root_node )|ezurl}><i class="fa fa-sitemap" aria-hidden="true"></i><strong>{$count_content}</strong><span>{'Content items'|i18n( 'design/admin/dashboard' )}</span></a>{/if}
        <div class="panel aui-dash-figure aui-accent"><i class="fa fa-calendar-check-o" aria-hidden="true"></i><strong>{$count_week}</strong><span>{'Published in the last 7 days'|i18n( 'design/admin/dashboard' )}</span></div>
        {if $can.drafts}<a class="panel aui-dash-figure" href={'content/draft'|ezurl}><i class="fa fa-pencil" aria-hidden="true"></i><strong>{$count_drafts}</strong><span>{'My drafts'|i18n( 'design/admin/dashboard' )}</span></a>{/if}
        {if $can.pending}<a class="panel aui-dash-figure" href={'content/pendinglist'|ezurl}><i class="fa fa-clock-o" aria-hidden="true"></i><strong>{$count_pending}</strong><span>{'My pending items'|i18n( 'design/admin/dashboard' )}</span></a>{/if}
        {if $can.users}<a class="panel aui-dash-figure" href={concat( 'content/view/full/', $users_node )|ezurl}><i class="fa fa-user" aria-hidden="true"></i><strong>{$count_users}</strong><span>{'Users'|i18n( 'design/admin/dashboard' )}</span></a>{/if}
        {* who is signed in belongs to the session list (setup/session) *}
        {if $can.sessions}<div class="panel aui-dash-figure"><i class="fa fa-sign-in" aria-hidden="true"></i><strong>{$count_online}</strong><span>{'Signed in now'|i18n( 'design/admin/dashboard' )}</span></div>{/if}
        {if $can.media}<a class="panel aui-dash-figure" href={concat( 'content/view/full/', $media_node )|ezurl}><i class="fa fa-picture-o" aria-hidden="true"></i><strong>{$count_media}</strong><span>{'Media items'|i18n( 'design/admin/dashboard' )}</span></a>{/if}
        {if $can.trash}<a class="panel aui-dash-figure" href={'content/trash'|ezurl}><i class="fa fa-trash-o" aria-hidden="true"></i><strong>{$count_trash}</strong><span>{'In the trash'|i18n( 'design/admin/dashboard' )}</span></a>{/if}
    </section>

    <div class="aui-dash-row">
        {* ---- Activity ---- *}
        <section class="panel aui-dash-card aui-dash-activity">
            <div class="panel-hl"><h2>{'Publishing, last 14 days'|i18n( 'design/admin/dashboard' )}</h2></div>
            <div class="aui-dash-body">
                <div class="aui-dash-bars" role="img" aria-label="{'Content published per day over the last 14 days'|i18n( 'design/admin/dashboard' )|wash}">
                    {foreach $days as $d}
                    <div class="aui-dash-bar" title="{$d.time|l10n( 'shortdate' )}: {$d.count}">
                        <span class="aui-dash-bar-value">{if gt( $d.count, 0 )}{$d.count}{/if}</span>
                        <span class="aui-dash-bar-fill" style="height: {if gt( $d.count, 0 )}{max( 4, div( mul( $d.count, 100 ), $day_max )|round )}{else}0{/if}%"></span>
                        <span class="aui-dash-bar-day">{$d.time|datetime( 'custom', '%j' )}</span>
                    </div>
                    {/foreach}
                </div>
            </div>
        </section>

        {* ---- System ---- *}
        <section class="panel aui-dash-card aui-dash-system">
            <div class="panel-hl"><h2>{'System'|i18n( 'design/admin/dashboard' )}</h2></div>
            <div class="aui-dash-body">
                {include uri='design:dashboard/maintenance.tpl'}
                <table class="list aui-dash-facts">
                    <tr><td>{'Version'|i18n( 'design/admin/dashboard' )}</td><td>{fetch( 'setup', 'version' )}</td></tr>
                    {* the database and the extensions are system information (setup/info) *}
                    {if $can.info}
                    <tr><td>{'Database'|i18n( 'design/admin/dashboard' )}</td><td>{ezini( 'DatabaseSettings', 'DatabaseImplementation' )|wash}</td></tr>
                    <tr><td>{'Extensions'|i18n( 'design/admin/dashboard' )}</td><td>{$extensions|count}</td></tr>
                    {/if}
                </table>
                {if or( $can.info, $can.cache, $can.upgrade )}
                <p class="aui-dash-links">
                    {if $can.info}<a class="btn btn-default btn-sm" href={'setup/info'|ezurl}>{'System information'|i18n( 'design/admin/dashboard' )}</a>{/if}
                    {if $can.cache}<a class="btn btn-default btn-sm" href={'setup/cache'|ezurl}>{'Caches'|i18n( 'design/admin/dashboard' )}</a>{/if}
                    {if $can.upgrade}<a class="btn btn-default btn-sm" href={'setup/systemupgrade'|ezurl}>{'Upgrade check'|i18n( 'design/admin/dashboard' )}</a>{/if}
                </p>
                {/if}
            </div>
        </section>
    </div>

    {* ---- Stay secure: the two updates that keep an installation safe ---- *}
    {* Shown only to a user who can run one of the two updates; the rest have nothing to do here. *}
    {def $can_git    = and( $extensions|contains( 'git_manager' ), fetch( 'user', 'can_open', hash( 'uri', 'git_manager/dashboard' ) ) )
         $can_update = and( $extensions|contains( 'ezupdate' ), fetch( 'user', 'can_open', hash( 'uri', 'update/dashboard' ) ) )}
    {if or( $can_git, $can_update )}
    <section class="panel aui-dash-card aui-dash-secure" aria-labelledby="aui-dash-secure-title">
        <div class="panel-hl">
            <h2 id="aui-dash-secure-title"><i class="fa fa-shield" aria-hidden="true"></i> {'Stay secure: keep Exponential up to date'|i18n( 'design/admin/dashboard' )}</h2>
        </div>
        <div class="aui-dash-body">
            <p class="aui-dash-secure-intro">{'Most attacks use flaws that are already fixed in a newer version. Two updates keep this installation safe; check both regularly, and right away when a security release is announced.'|i18n( 'design/admin/dashboard' )}</p>
            <ol class="aui-dash-steps">
                <li>
                    <span class="aui-dash-step-no" aria-hidden="true">1</span>
                    <div>
                        <h3>{'Update the CMS with the Git manager'|i18n( 'design/admin/dashboard' )}</h3>
                        <p>{'Exponential itself -- the kernel, its designs and the extensions kept in git -- is updated by pulling the newest release into the installation: see which branch and version it runs, what has changed upstream, and update.'|i18n( 'design/admin/dashboard' )}</p>
                        {if $can_git}
                            <a class="btn btn-primary btn-sm" href={'git_manager/dashboard'|ezurl}>{'Open the Git manager'|i18n( 'design/admin/dashboard' )}&nbsp;<i class="fa fa-arrow-right" aria-hidden="true"></i></a>
                        {else}
                            <p class="aui-dash-step-note">{'The Git manager is not available to you here; ask an administrator to run this step.'|i18n( 'design/admin/dashboard' )}</p>
                        {/if}
                    </div>
                </li>
                <li>
                    <span class="aui-dash-step-no" aria-hidden="true">2</span>
                    <div>
                        <h3>{'Update the libraries with Composer'|i18n( 'design/admin/dashboard' )}</h3>
                        <p>{'The libraries the CMS requires are Composer packages. The Updates dashboard lists the installed packages, checks Packagist for newer versions and security advisories, and updates them.'|i18n( 'design/admin/dashboard' )}</p>
                        {if $can_update}
                            <a class="btn btn-primary btn-sm" href={'update/dashboard'|ezurl}>{'Open the Updates dashboard'|i18n( 'design/admin/dashboard' )}&nbsp;<i class="fa fa-arrow-right" aria-hidden="true"></i></a>
                        {else}
                            <p class="aui-dash-step-note">{'The Updates dashboard is not available to you here; ask an administrator to run this step.'|i18n( 'design/admin/dashboard' )}</p>
                        {/if}
                    </div>
                </li>
            </ol>
        </div>
    </section>
    {/if}

    {* ---- The configured blocks (dashboard.ini), each in a panel ---- *}
    <div class="aui-dash-blocks a4-dash-blocks">
    {foreach $blocks as $block}
        <section class="panel aui-dash-card dashboard-item aui-dash-block aui-dash-block-{$block.identifier|wash} a4-dash-block-{$block.identifier|wash}">
            <div class="aui-dash-body">
            {if $block.template}
                {include uri=concat( 'design:', $block.template )}
            {else}
                {include uri=concat( 'design:dashboard/', $block.identifier, '.tpl' )}
            {/if}
            </div>
        </section>
    {/foreach}
    </div>

</div>
</div>
</div>
{undef}
