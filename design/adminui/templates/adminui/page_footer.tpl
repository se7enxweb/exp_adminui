{* Exponential Admin UI: the footer, from page_footer.html.twig *}
<footer id="footer">
    {* the Help center (the kernel's help system) for users with exphelp/read while the help is switched on *}
    {if ezini_hasvariable( 'HelpSettings', 'Enabled', 'exphelp.ini' )}{if and( ezini( 'HelpSettings', 'Enabled', 'exphelp.ini' )|eq( 'true' ), fetch( 'user', 'has_access_to', hash( 'module', 'exphelp', 'function', 'read' ) ) )}
    <p class="aui-footer-help"><a href={'/exphelp/dashboard'|ezurl}><i class="fa fa-question-circle" aria-hidden="true"></i> {'Help center'|i18n( 'design/admin/page_copyright' )|wash}</a></p>
    {/if}{/if}
    <p>{'Exponential Admin UI. Based on Exponential Platform Administration'|i18n( 'design/adminui/pagelayout' )}</p>
    {* the kernel's footer notice, the same message as the admin and admin4 designs, so every catalogue already has it *}
    <p>{'<a href="%ezpublish_link">Exponential</a> Copyright &copy; 1998-2026 <a href="%foundation_link">Exponential Foundation</a> and <a href="%7x_link">7x</a>'|i18n( 'design/admin/page_copyright',, hash( '%ezpublish_link', 'https://exponential.earth', '%foundation_link', 'https://foundation.exponential.earth', '%7x_link', 'https://se7enx.com' ) )}</p>
</footer>
