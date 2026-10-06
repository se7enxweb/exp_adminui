{* Exponential Admin UI: the scripts. The admin's own list first (jQuery 4 with Migrate, the Exponential UI widgets
   and BackendJavaScriptList, as admin4 loads them; no YUI, which Exponential 6 does not ship), then
   page_head_script.html.twig's Netgen Admin UI scripts: jQuery UI resizable (left column), Bootstrap 3 (the
   dropdowns of the side bar), the Ace editor and the Admin UI app. The reference's YUI stand-ins are not needed. *}
{if is_unset( $load_javascript_list )}
 {def $load_javascript_list = true()}
{/if}
{include uri='design:page_head_exp.tpl'}
{if $load_javascript_list}
 {ezscript_load( ezini( 'JavaScriptSettings', 'BackendJavaScriptList', 'design.ini' )|prepend( 'ezjsc::jquery', 'ezjsc::jqueryio' ) )}
{else}
 {ezscript_load( array( 'ezjsc::jquery', 'ezjsc::jqueryio' ) )}
{/if}
{* jQuery UI resizable for the left column: only where no jQuery UI is loaded yet. The copy is jQuery UI 1.11 with its
   own widget factory; loaded over a page's newer jQuery UI (eztags' tree picker) it broke that page's widgets. A
   jQuery UI without resizable gets a no-op, so the column simply keeps its width. *}
<script type="text/javascript">
if ( !( window.jQuery && jQuery.ui ) ) document.write( '<script type="text/javascript" src="' + {'javascript/ngadminui/resizable.js'|ezdesign( 'single' )} + '"><\/script>' );
else if ( !jQuery.fn.resizable ) jQuery.fn.resizable = function () {ldelim} return this; {rdelim};
</script>
<script type="text/javascript" src={'javascript/ngadminui/bootstrap.js'|ezdesign}></script>
<script type="text/javascript" src={'javascript/ngadminui/ace/ace.js'|ezdesign}></script>
<script type="text/javascript" src={'javascript/ngadminui/ace/ext-language_tools.js'|ezdesign}></script>
<script type="text/javascript" src={'javascript/ngadminui/app.js'|ezdesign}></script>
{* app.js points Ace at the bundle's public path; point it at this design's copy *}
<script type="text/javascript">if ( window.ace ) ace.config.set( 'basePath', {'extension/exp_adminui/design/adminui/javascript/ngadminui/ace'|ezroot( 'single' )} );</script>
