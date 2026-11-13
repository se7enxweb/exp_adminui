{* Exponential Admin UI: the account activation (user/activate, the link of the registration mail) in the sign-in
   frame of user/login.tpl; the texts are those of the admin designs' activate.tpl, the next step is signing in. *}
<div class="login-container">
    <header class="login-header">
        <a href={'/user/login'|ezurl} class="logo logo-type-{ezini( 'AdminUISettings', 'LogoType', 'exp_adminui.ini' )|wash}" title="{ezini( 'AdminUISettings', 'Title', 'exp_adminui.ini' )|wash}"></a>
        <h1 class="aui-login-title">{'Activate account'|i18n( 'design/admin/user' )}</h1>
    </header>
    <div class="aui-login-text" role="{if or( $account_activated, $already_active )}status{else}alert{/if}">
        <p>
        {if $account_activated}
            {if $is_pending}
                {'Your email address has been confirmed. An administrator needs to approve your sign up request, before your login becomes valid.'|i18n( 'design/standard/user' )}
            {else}
                {'Your account is now activated.'|i18n( 'design/standard/user' )}
            {/if}
        {elseif $already_active}
            {'Your account is already active.'|i18n( 'design/standard/user' )}
        {else}
            {'Sorry, the key submitted was not a valid key. Account was not activated.'|i18n( 'design/standard/user' )}
        {/if}
        </p>
    </div>
    <a class="btn btn-primary aui-login-button" href={'/user/login'|ezurl}>{'Sign in'|i18n( 'design/admin/user/login' )}</a>
</div>
