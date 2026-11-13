{* Exponential Admin UI: "Forgot your password?" in the sign-in frame of user/login.tpl (the logo, the dark fields, the
   full-width button), so it does not fall back to the admin designs' template, which loginpagelayout.tpl shows
   without a frame. The kernel (user/forgotpassword) reads UserEmail and GenerateButton; HashKey is the link from the
   mail. States: the form (also after an address that is not valid), "a mail has been sent" ($link), "a new password
   was sent" ($generated), and a link that has expired or is invalid ($wrong_key, $key_expired). *}
{if first_set( $demo_mode_text, '' )|ne( '' )}
    <div class="alert alert-warning" role="status"><p>{$demo_mode_text|wash}</p></div>
{/if}
{if $link}
    <div class="alert alert-success" role="status"><p>{'If an account is registered with the email address %1, a mail has been sent to it. This email contains a link you need to click so that we can confirm that the correct user is getting the new password.'|i18n( 'design/standard/user/forgotpassword',, array( $email|wash ) )}</p></div>
{elseif $generated}
    <div class="alert alert-success" role="status"><p>{'Password was successfully generated and sent to: %1'|i18n( 'design/standard/user/forgotpassword',, array( $email|wash ) )}</p></div>
{elseif and( $wrong_key, first_set( $key_expired, false() ) )}
    <div class="alert alert-warning" role="alert">
        <h2>{'This link has expired.'|i18n( 'design/standard/user/forgotpassword' )}</h2>
        <ul><li>{'For your security, a link to reset your password works only for %1 minutes and only once. Ask for a new link below.'|i18n( 'design/standard/user/forgotpassword',, array( first_set( $key_lifetime_minutes, 60 ) ) )}</li></ul>
    </div>
{elseif $wrong_key}
    <div class="alert alert-warning" role="alert"><h2>{'The key is invalid or has been used. '|i18n( 'design/standard/user/forgotpassword' )|trim}</h2></div>
{elseif $wrong_email}
    <div class="alert alert-warning" role="alert"><h2>{'Please enter a valid email address.'|i18n( 'design/standard/user/forgotpassword' )}</h2></div>
{/if}

<div class="login-container">
    <header class="login-header">
        <a href={'/user/login'|ezurl} class="logo logo-type-{ezini( 'AdminUISettings', 'LogoType', 'exp_adminui.ini' )|wash}" title="{ezini( 'AdminUISettings', 'Title', 'exp_adminui.ini' )|wash}"></a>
        <h1 class="aui-login-title">{'Have you forgotten your password?'|i18n( 'design/standard/user/forgotpassword' )}</h1>
    </header>

    {if or( $link, $generated )|not}
        {if $wrong_key}
        <p class="aui-login-links"><a href={'/user/forgotpassword/'|ezurl}>{'Ask for a new link'|i18n( 'design/standard/user/forgotpassword' )}</a></p>
        {else}
        <p class="aui-login-text">{'If you have forgotten your password we can generate a new one for you. All you need to do is to enter your email address and we will create a new password for you.'|i18n( 'design/standard/user/forgotpassword' )}</p>
        <form name="forgotpassword" method="post" action={'/user/forgotpassword/'|ezurl} novalidate="novalidate">
            <label class="aui-login-label" for="email">{'Email'|i18n( 'design/standard/user/forgotpassword' )}</label>
            <div class="input-item">
                <input type="email" class="form-control aui-login-plain" name="UserEmail" id="email" value="{cond( $wrong_email, $wrong_email, '' )|wash}"
                       autocomplete="email" autocapitalize="none" spellcheck="false" inputmode="email" required="required" autofocus="autofocus"{if $wrong_email} aria-invalid="true"{/if} />
            </div>
            <button class="btn btn-primary" type="submit" id="generatebutton" name="GenerateButton" value="{'Generate new password'|i18n( 'design/standard/user/forgotpassword' )|wash}">{'Generate new password'|i18n( 'design/standard/user/forgotpassword' )}</button>
        </form>
        {/if}
    {/if}

    <p class="aui-login-links"><a href={'/user/login'|ezurl}>{'Sign in'|i18n( 'design/admin/user/login' )}</a></p>
</div>
