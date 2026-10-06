{* Exponential Admin UI: the login form, from user/login.html.twig of the Netgen Admin UI bundle. The fields are
   the ones the Exponential user/login view reads: Login, Password, LoginButton and RedirectURI. *}
{if or( $User:warning.bad_login, $site_access.allowed|not )}
    <div class="alert alert-warning" role="alert">
        <h2><span class="time">[{currentdate()|l10n( 'shortdatetime' )}]</span>
            {if $User:warning.bad_login}{'Bad credentials.'|i18n( 'design/adminui/login' )}{else}{'Access denied!'|i18n( 'design/admin/user/login' )}{/if}</h2>
        <ul>
            {if and( is_set( $User:user_is_not_allowed_to_login ), eq( $User:user_is_not_allowed_to_login, true() ) )}
                <li>{'"%user_login" is not allowed to log in because failed login attempts by this user exceeded allowable number of failed login attempts!'|i18n( 'design/admin/user/login',, hash( '%user_login', $User:login ) )|wash}</li>
            {elseif $User:warning.bad_login}
                <li>{'Make sure that the username and password is correct.'|i18n( 'design/adminui/login' )}</li>
                <li>{'All letters must be entered in the correct case.'|i18n( 'design/adminui/login' )}</li>
            {else}
                <li>{'You do not have permission to access <%siteaccess_name>.'|i18n( 'design/admin/user/login',, hash( '%siteaccess_name', $site_access.name ) )|wash}</li>
            {/if}
            <li>{'Please try again or contact the site administrator.'|i18n( 'design/adminui/login' )}</li>
        </ul>
    </div>
{/if}

<div class="login-container">
    <header class="login-header">
        <a href="#" class="logo logo-type-{ezini( 'AdminUISettings', 'LogoType', 'exp_adminui.ini' )|wash}" title="{ezini( 'AdminUISettings', 'Title', 'exp_adminui.ini' )|wash}"></a>
    </header>

    <form name="loginform" method="post" action={'/user/login/'|ezurl}>
        <div class="input-item">
            <span class="icon icon-user"></span>
            <input type="text" class="form-control" autofocus="autofocus" size="10" name="Login" id="logintext" value="{if is_set( $User:login )}{$User:login|wash}{/if}" placeholder="{'Username'|i18n( 'design/adminui/login' )}" tabindex="1" title="{'Enter a valid username in this field.'|i18n( 'design/adminui/login' )}" autocomplete="username" />
        </div>
        <div class="input-item">
            <span class="icon icon-lock"></span>
            <input type="password" class="form-control" size="10" name="Password" id="passwordtext" placeholder="{'Password'|i18n( 'design/adminui/login' )}" tabindex="2" title="{'Enter a valid password in this field.'|i18n( 'design/adminui/login' )}" autocomplete="current-password" />
        </div>

        <input type="hidden" name="RedirectURI" value="{$User:redirect_uri|wash}" />

        <button class="btn btn-primary" type="submit" id="loginbutton" name="LoginButton" value="{'Log in'|i18n( 'design/adminui/login' )}" tabindex="3" title="{'Click here to log in using the username/password combination entered in the fields above.'|i18n( 'design/adminui/login' )}">{'Log in'|i18n( 'design/adminui/login' )}</button>
    </form>
    {* The social login buttons of sevenx_authentication_2fa, where that extension is active and enables a provider *}
    {if ezmodule( 'user2fa/oauth' )}
        {include uri='design:user2fa/exp_style.tpl'}
        {include uri='design:user2fa/parts/social_buttons.tpl' context='login' redirect=$User:redirect_uri}
    {/if}
</div>
