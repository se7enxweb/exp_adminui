{* Change password, in the Admin UI panel and form markup, with Exponential's password page: the current password,
   the new one with its requirements and strength, and the confirmation; errors inline at each field and in a summary
   at the top; a success state. Passwords are never written back into the form.
   Works without JavaScript; design:javascript/exp_password_field.js adds show / hide, the live checklist, the
   meter, the match feedback and "Generate" through the data-exp-password-* hooks. Posts what the view has always
   read: oldPassword, newPassword, confirmPassword, OKButton, CancelButton (to the same address).
   Variables: see the user/password template contract (password_rules, field_errors, field_ids, error_summary,
   password_changed, password_js_config_json ...); every one is optional, so an older kernel still renders. *}
{def $ids = first_set( $field_ids, hash( 'oldPassword', 'password-old', 'newPassword', 'password-new', 'confirmPassword', 'password-confirm' ) )
     $errors = first_set( $field_errors, hash( 'oldPassword', array(), 'newPassword', array(), 'confirmPassword', array() ) )
     $rules = first_set( $password_rules, array() )
     $summary = first_set( $error_summary, array() )
     $changed = first_set( $password_changed, false() )
     $ctx = 'design/admin/user/password_page'}
{* an older kernel: only the three flags *}
{if and( $summary|count|eq( 0 ), $message, or( $oldPasswordNotValid, $newPasswordNotMatch, $newPasswordTooShort ) )}
    {if $oldPasswordNotValid}{set $errors = $errors|merge( hash( 'oldPassword', array( 'Your current password is not correct.'|i18n( $ctx ) ) ) )}
    {elseif $newPasswordTooShort}{set $errors = $errors|merge( hash( 'newPassword', array( 'The new password must be at least %1 characters long.'|i18n( $ctx, '', array( first_set( $min_length, ezini( 'UserSettings', 'MinPasswordLength' ) ) ) ) ) ) )}
    {elseif $newPasswordNotMatch}{set $errors = $errors|merge( hash( 'confirmPassword', array( 'The two new passwords do not match.'|i18n( $ctx ) ) ) )}{/if}
    {foreach array( 'oldPassword', 'newPassword', 'confirmPassword' ) as $f}{foreach $errors[$f] as $t}{set $summary = $summary|append( hash( 'field', $f, 'field_id', $ids[$f], 'text', $t ) )}{/foreach}{/foreach}
{/if}
{if and( $message, $changed|not, $summary|count|eq( 0 ), $oldPasswordNotValid|not, $newPasswordNotMatch|not, $newPasswordTooShort|not, is_unset( $password_changed ) )}{set $changed = true()}{/if}

{literal}
<style type="text/css">
.adminui-pw [hidden] { display: none !important; }
.adminui-pw .adminui-pw-username { position: absolute; width: 1px; height: 1px; margin: -1px; padding: 0; overflow: hidden; clip: rect(0 0 0 0); border: 0; opacity: 0; }
.adminui-pw .adminui-pw-sr { position: absolute; width: 1px; height: 1px; margin: -1px; overflow: hidden; clip: rect(0 0 0 0); white-space: nowrap; }
.adminui-pw .adminui-pw-label-row { display: flex; justify-content: space-between; align-items: baseline; gap: 1em; }
.adminui-pw .btn-link { padding: 0; }
.adminui-pw .adminui-pw-meter { display: flex; flex-wrap: wrap; align-items: center; gap: 6px 12px; margin: 8px 0 0; font-size: 13px; color: #777; }
.adminui-pw .adminui-pw-meter-bar { display: inline-grid; grid-template-columns: repeat(5, 1fr); gap: 4px; width: 12rem; max-width: 100%; }
.adminui-pw .adminui-pw-meter-bar span { height: 6px; border-radius: 3px; background: #ddd; }
.adminui-pw .adminui-pw-meter[data-score="0"] .adminui-pw-meter-bar span:nth-child(-n+1) { background: #b91c1c; }
.adminui-pw .adminui-pw-meter[data-score="1"] .adminui-pw-meter-bar span:nth-child(-n+2) { background: #c2410c; }
.adminui-pw .adminui-pw-meter[data-score="2"] .adminui-pw-meter-bar span:nth-child(-n+3) { background: #a16207; }
.adminui-pw .adminui-pw-meter[data-score="3"] .adminui-pw-meter-bar span:nth-child(-n+4) { background: #4d7c0f; }
.adminui-pw .adminui-pw-meter[data-score="4"] .adminui-pw-meter-bar span { background: #166534; }
.adminui-pw .adminui-pw-meter:not([data-score]) .adminui-pw-meter-label { visibility: hidden; }
.adminui-pw .adminui-pw-rules-title { margin: 10px 0 4px; font-size: 13px; color: #777; }
.adminui-pw .adminui-pw-rules { list-style: none; margin: 0; padding: 0; font-size: 13px; }
.adminui-pw .adminui-pw-rules li { margin: 2px 0; }
.adminui-pw .adminui-pw-rules li .fa { width: 1.2em; color: #999; }
.adminui-pw .adminui-pw-rules li[data-state="met"] { color: #166534; }
.adminui-pw .adminui-pw-rules li[data-state="met"] .fa { color: #166534; }
.adminui-pw .adminui-pw-rules li[data-state="met"] .fa:before { content: "\f058"; }
.adminui-pw .adminui-pw-rules li[data-failed="true"]:not([data-state="met"]) { color: #a94442; font-weight: 600; }
.adminui-pw .adminui-pw-match { margin: 6px 0 0; font-size: 13px; }
.adminui-pw .adminui-pw-match[data-state="match"] { color: #166534; }
.adminui-pw .adminui-pw-match[data-state="nomatch"] { color: #777; }
</style>
{/literal}

<div class="adminui-pw">

{if $changed}
    <div class="alert alert-success" role="status" tabindex="-1" autofocus>
        <h2><span class="time">[{currentdate()|l10n( shortdatetime )}]</span> {'Your password was changed.'|i18n( $ctx )}</h2>
        <p>{'You stay signed in here.'|i18n( $ctx )}{if and( is_set( $sessions_ended ), $sessions_ended|gt( 0 ) )} {'Your other sessions (%count) were signed out.'|i18n( $ctx, '', hash( '%count', $sessions_ended ) )}{elseif first_set( $other_sessions_signed_out, false() )} {'You were signed out on your other devices.'|i18n( $ctx )}{/if}</p>
{if first_set( $notification_sent, false() )}
        <p>{'A confirmation was sent to your e-mail address.'|i18n( $ctx )}</p>
{/if}
        <p><a class="btn btn-primary" href={first_set( $redirect_uri, '/' )|ezurl}>{'Continue'|i18n( $ctx )}</a></p>
    </div>
{else}

{if $summary|count}
    <div class="alert alert-warning" id="password-error-summary" role="alert" tabindex="-1" aria-labelledby="password-error-summary-title" data-exp-password-summary autofocus>
        <h2 id="password-error-summary-title"><span class="time">[{currentdate()|l10n( shortdatetime )}]</span> {'The password could not be changed.'|i18n( $ctx )}</h2>
        <ul>
{foreach $summary as $e}
            <li>{if $e.field_id}<a href="#{$e.field_id|wash}">{$e.text|wash}</a>{else}{$e.text|wash}{/if}</li>
{/foreach}
        </ul>
    </div>
{/if}

<div class="panel">
    {* DESIGN: Header START *}
    <div class="panel-hl">
        <h3>{'Change password for %username'|i18n( 'design/admin/user/password',, hash( '%username', $userAccount.login ) )|wash}</h3>
    </div>

    {* DESIGN: Mainline *}
    {* DESIGN: Header END *}

    <div class="row">
        <div class="col-lg-6">
            <form name="Password" method="post" action={concat( $module.functions.password.uri, '/', $userID )|ezurl} novalidate
                  data-exp-password-form{if is_set( $password_js_config_json )} data-exp-password-config="{$password_js_config_json|wash}"{/if}>
                {* DESIGN: Content START *}

                {* for password managers: the account the password belongs to *}
                <input type="text" class="adminui-pw-username" name="a4pwUsername" value="{$userAccount.login|wash}" autocomplete="username" readonly tabindex="-1" aria-hidden="true" />

                {* Username. *}
                <div class="form-group">
                    <label>{'Username'|i18n( 'design/admin/user/password' )}:</label>
                    {$userAccount.login|wash}
                </div>

                {* Current password. *}
                <div class="form-group{if $errors.oldPassword|count} has-error{/if}">
                    <label class="control-label" for="{$ids.oldPassword}">{'Current password'|i18n( $ctx )}:</label>
                    <div class="input-group">
                        <input class="form-control" id="{$ids.oldPassword}" type="password" name="oldPassword" value="" autocomplete="current-password" spellcheck="false" autocapitalize="off"
                               data-exp-password="current"{if $errors.oldPassword|count} aria-invalid="true" aria-describedby="{$ids.oldPassword}-error"{/if}{if $summary|count|eq( 0 )} autofocus{/if} />
                        <span class="input-group-btn"><button type="button" class="btn btn-default" data-exp-password-toggle="{$ids.oldPassword}" aria-controls="{$ids.oldPassword}" aria-pressed="false" hidden><i class="fa fa-eye" aria-hidden="true"></i> <span data-exp-password-toggle-text>{'Show'|i18n( $ctx )}</span></button></span>
                    </div>
{if $errors.oldPassword|count}
                    <p class="help-block" id="{$ids.oldPassword}-error">{foreach $errors.oldPassword as $t}<span>{$t|wash}</span>{/foreach}</p>
{/if}
                </div>

                {* New password. *}
                <div class="form-group{if $errors.newPassword|count} has-error{/if}">
                    <div class="adminui-pw-label-row">
                        <label class="control-label" for="{$ids.newPassword}">{'New password'|i18n( $ctx )}:</label>
                        <button type="button" class="btn btn-link btn-sm" data-exp-password-generate hidden>{'Generate a strong password'|i18n( $ctx )}</button>
                    </div>
                    <div class="input-group">
                        <input class="form-control" id="{$ids.newPassword}" type="password" name="newPassword" value="" autocomplete="new-password" spellcheck="false" autocapitalize="off"
                               minlength="{first_set( $min_length, ezini( 'UserSettings', 'MinPasswordLength' ) )}" data-exp-password="new"
                               aria-describedby="{if $errors.newPassword|count}{$ids.newPassword}-error {/if}password-new-rules"{if $errors.newPassword|count} aria-invalid="true"{/if} />
                        <span class="input-group-btn"><button type="button" class="btn btn-default" data-exp-password-toggle="{$ids.newPassword}" aria-controls="{$ids.newPassword}" aria-pressed="false" hidden><i class="fa fa-eye" aria-hidden="true"></i> <span data-exp-password-toggle-text>{'Show'|i18n( $ctx )}</span></button></span>
                    </div>
{if $errors.newPassword|count}
                    <p class="help-block" id="{$ids.newPassword}-error">{foreach $errors.newPassword as $t}<span>{$t|wash}</span>{/foreach}</p>
{/if}
                    <div class="adminui-pw-meter" data-exp-password-meter aria-live="polite" hidden>
                        <span class="adminui-pw-meter-bar" aria-hidden="true"><span></span><span></span><span></span><span></span><span></span></span>
                        <span class="adminui-pw-meter-label">{'Strength'|i18n( $ctx )}: <b data-exp-password-meter-text></b></span>
                    </div>
                    <p class="adminui-pw-rules-title" id="password-new-rules-title">{'Your new password needs'|i18n( $ctx )}</p>
                    <ul class="adminui-pw-rules" id="password-new-rules" aria-labelledby="password-new-rules-title" data-exp-password-rules>
{if $rules|count}
{foreach $rules as $r}
                        <li data-exp-password-rule="{$r.id|wash}"{if $r.failed} data-state="unmet" data-failed="true"{/if}><i class="fa fa-circle-o" aria-hidden="true"></i> <span>{$r.text|wash}</span><span class="adminui-pw-sr" data-exp-password-rule-state>{if $r.failed}{'not met'|i18n( $ctx )}{/if}</span></li>
{/foreach}
{else}
                        <li data-exp-password-rule="length"><i class="fa fa-circle-o" aria-hidden="true"></i> <span>{'At least %1 characters'|i18n( $ctx, '', array( ezini( 'UserSettings', 'MinPasswordLength' ) ) )}</span><span class="adminui-pw-sr" data-exp-password-rule-state></span></li>
{/if}
                    </ul>
                </div>

                {* Confirm new password. *}
                <div class="form-group{if $errors.confirmPassword|count} has-error{/if}">
                    <label class="control-label" for="{$ids.confirmPassword}">{'Confirm new password'|i18n( $ctx )}:</label>
                    <div class="input-group">
                        <input class="form-control" id="{$ids.confirmPassword}" type="password" name="confirmPassword" value="" autocomplete="new-password" spellcheck="false" autocapitalize="off"
                               data-exp-password="confirm"{if $errors.confirmPassword|count} aria-invalid="true" aria-describedby="{$ids.confirmPassword}-error"{/if} />
                        <span class="input-group-btn"><button type="button" class="btn btn-default" data-exp-password-toggle="{$ids.confirmPassword}" aria-controls="{$ids.confirmPassword}" aria-pressed="false" hidden><i class="fa fa-eye" aria-hidden="true"></i> <span data-exp-password-toggle-text>{'Show'|i18n( $ctx )}</span></button></span>
                    </div>
{if $errors.confirmPassword|count}
                    <p class="help-block" id="{$ids.confirmPassword}-error">{foreach $errors.confirmPassword as $t}<span>{$t|wash}</span>{/foreach}</p>
{/if}
                    <p class="adminui-pw-match" data-exp-password-match aria-live="polite" hidden></p>
                </div>

                <p class="help-block" data-exp-password-status aria-live="polite" hidden></p>

                {* DESIGN: Content END *}

                <div class="controlbar">
                    {* DESIGN: Control bar START *}
                    <div class="block">
                        <button class="btn btn-primary" type="submit" name="OKButton" value="OK">{'Change password'|i18n( $ctx )}</button>
                        <button class="btn btn-default" type="submit" name="CancelButton" value="Cancel" formnovalidate>{'Cancel'|i18n( $ctx )}</button>
                    </div>
                    {* DESIGN: Control bar END *}
                </div>
            </form>
        </div>
    </div>
</div>
{ezscript( array( 'exp_password_field.js' ) )}
{/if}
</div>
{undef}
