{* Exponential Admin UI: the user menu at the foot of the side bar, from page_aside_user.html.twig. The avatar is the
   user's image attribute (design:page_aside_user.tpl, the legacy helper), else images/a0.jpg. *}
{def $user_content = $current_user.contentobject
     $user_avatar  = ''}
{if $user_content}
<div class="aside-footer">
    {set-block variable=$user_avatar}{include uri='design:page_aside_user.tpl' content=$user_content}{/set-block}
    {set $user_avatar = $user_avatar|trim}
    {if eq( $user_avatar, '' )}{set $user_avatar = 'a0.jpg'|ezimage( 'no' )}{/if}

    <a href="#" class="user-dropdown-toggle" data-toggle="dropdown">
        <span class="user-avatar" style="background-image:url({$user_avatar})"></span>
    </a>

    <!-- dropdown -->
    <ul class="dropdown-menu user-dropdown">

        <li>
            <div class="user-avatar" style="background-image:url({$user_avatar})">
            </div>
            <h4 class="user-name">{$user_content.name|wash}</h4>
            <p class="user-role">{$current_user.login|wash}</p>
        </li>

        <li class="divider"></li>

        {if and( ne( $ui_context, 'edit' ), ne( $ui_context, 'browse' ) )}
            {if $user_content.can_read}
                <li><a href={$user_content.main_node.url_alias|ezurl}>{'View profile'|i18n( 'design/adminui/user' )}</a></li>
            {/if}
            {if $user_content.can_edit}
                <li>
                    <a href={concat( '/content/edit/', $user_content.id )|ezurl}>{'Change information'|i18n( 'design/adminui/user' )}</a>
                </li>
            {/if}
            <li>
                <a href={'/user/password'|ezurl}>{'Change password'|i18n( 'design/adminui/user' )}</a>
            </li>
        {else}
            <li><span class="disabled">{'View profile'|i18n( 'design/adminui/user' )}</span></li>
            <li><span class="disabled">{'Change information'|i18n( 'design/adminui/user' )}</span></li>
            <li><span class="disabled">{'Change password'|i18n( 'design/adminui/user' )}</span></li>
        {/if}

        <li class="divider"></li>

        <li><span>{'Edit interface settings'|i18n( 'design/adminui/user' )}</span></li>
        {if ne( $ui_context, 'edit' )}
            <li><span class="tt">{'Show locations'|i18n( 'design/adminui/user' )}</span>
                <span class="control-toggle">
                    {if ezpreference( 'admin_edit_show_locations' )}
                        <strong>{'on'|i18n( 'design/adminui/user' )}</strong>
                        <a href={'/user/preferences/set/admin_edit_show_locations/0'|ezurl} title="{'Disable location window when editing content.'|i18n( 'design/adminui/user' )}">{'off'|i18n( 'design/adminui/user' )}</a>
                    {else}
                        <a href={'/user/preferences/set/admin_edit_show_locations/1'|ezurl} title="{'Enable location window when editing content.'|i18n( 'design/adminui/user' )}">{'on'|i18n( 'design/adminui/user' )}</a>
                        <strong>{'off'|i18n( 'design/adminui/user' )}</strong>
                    {/if}
                </span>
            </li>
        {/if}

        {if ne( $ui_context, 'browse' )}
            <li><span class="tt">{'Enable re-edit'|i18n( 'design/adminui/user' )}</span>
                <span class="control-toggle">
                    {if ezpreference( 'admin_edit_show_re_edit' )}
                        <strong>{'on'|i18n( 'design/adminui/user' )}</strong>
                        <a href={'/user/preferences/set/admin_edit_show_re_edit/0'|ezurl} title="{'Disable &quot;Back to edit&quot; checkbox when editing content.'|i18n( 'design/adminui/user' )}">{'off'|i18n( 'design/adminui/user' )}</a>
                    {else}
                        <a href={'/user/preferences/set/admin_edit_show_re_edit/1'|ezurl} title="{'Enable &quot;Back to edit&quot; checkbox when editing content.'|i18n( 'design/adminui/user' )}">{'on'|i18n( 'design/adminui/user' )}</a>
                        <strong>{'off'|i18n( 'design/adminui/user' )}</strong>
                    {/if}
                </span>
            </li>
        {/if}
        <li class="divider"></li>

        <li>
            {if $ui_context_edit}
                <span class="disabled">{'Logout'|i18n( 'design/adminui/user' )}</span>
            {else}
                <a href={'/user/logout'|ezurl}>{'Logout'|i18n( 'design/adminui/user' )}</a>
            {/if}
        </li>

    </ul>
    <!-- / dropdown -->

</div>
{/if}
{undef $user_content $user_avatar}
