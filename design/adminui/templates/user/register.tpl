{* Exponential Admin UI: registration (user/register) in the sign-in frame of user/login.tpl, wider for the account's
   fields (.aui-login-wide), instead of the admin designs' template, whose light header and unstyled buttons
   loginpagelayout.tpl showed full width on the dark page. The fields and buttons are the kernel's: the content
   attributes (content/edit_attribute.tpl), the e-mail choices (mailpreferences/parts/signup.tpl), PublishButton
   and CancelButton (page/user_register.js holds back a second click). *}
{if $validation.processed}
<div class="alert alert-warning" role="alert">
    <h2><span class="time">[{currentdate()|l10n( shortdatetime )}]</span> {'The information could not be stored...'|i18n( 'design/admin/user/register' )}</h2>
    <p>{'The following information is either incorrect or missing'|i18n( 'design/admin/user/register' )}:</p>
    <ul>
    {foreach $validation.attributes as $unvalidated}
        <li>{$unvalidated.name|wash}: {$unvalidated.description|wash}</li>
    {/foreach}
    </ul>
    <p>{'Please correct the inputs (marked with red labels) and try again.'|i18n( 'design/admin/user/register' )}</p>
</div>
{/if}

<div class="login-container aui-login-wide">
    <header class="login-header">
        <a href={'/user/login'|ezurl} class="logo logo-type-{ezini( 'AdminUISettings', 'LogoType', 'exp_adminui.ini' )|wash}" title="{ezini( 'AdminUISettings', 'Title', 'exp_adminui.ini' )|wash}"></a>
        <h1 class="aui-login-title">{'Register new user'|i18n( 'design/admin/user/register' )}</h1>
    </header>

    {* jQuery for the attribute groups' fold script of content/edit_attribute.tpl (exp_adminui_content_edit_attribute.js):
       loginpagelayout.tpl loads no scripts, and without it the page stopped with "jQuery is not defined" *}
    {ezscript( array( 'ezjsc::jquery' ) )}
    <form name="registerform" class="aui-register-form" method="post" action={'/user/register/'|ezurl} enctype="multipart/form-data">
    {if count( $content_attributes )|gt( 0 )}
        <div class="context-attributes">
            {include uri='design:content/edit_attribute.tpl'}
            {include uri='design:mailpreferences/parts/signup.tpl' categories=first_set( $mail_categories, array() )}
        </div>
        <div class="aui-login-actions">
            <input class="btn btn-primary" type="submit" id="PublishButton" name="PublishButton" value="{'OK'|i18n( 'design/admin/user/register' )}" />
            <input class="btn btn-default" type="submit" id="CancelButton" name="CancelButton" value="{'Cancel'|i18n( 'design/admin/user/register' )}" />
        </div>
    {else}
        <div class="alert alert-warning" role="alert"><h2>{'Unable to register new user'|i18n( 'design/admin/user/register' )}</h2></div>
        <div class="aui-login-actions">
            <input class="btn btn-primary" disabled="disabled" type="submit" id="PublishButton" name="PublishButton" value="{'OK'|i18n( 'design/admin/user/register' )}" />
            <input class="btn btn-default" type="submit" id="CancelButton" name="CancelButton" value="{'Back'|i18n( 'design/admin/user/register' )}" />
        </div>
    {/if}
    </form>

    <p class="aui-login-links"><a href={'/user/login'|ezurl}>{'Sign in'|i18n( 'design/admin/user/login' )}</a></p>
</div>

{ezscript( array( 'page/user_register.js' ) )}
