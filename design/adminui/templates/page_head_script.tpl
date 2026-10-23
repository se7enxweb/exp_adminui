{* Exponential Admin UI: the scripts. The admin's own list first (jQuery 4 with Migrate, the Exponential UI widgets,
   BackendJavaScriptList and ClassicBackendJavaScriptList, as the older admin designs load them; admin4 loads none of
   them on every page; no YUI, which Exponential 6 does not ship), then
   page_head_script.html.twig's Netgen Admin UI scripts: jQuery UI resizable (left column), Bootstrap 3 (the
   dropdowns of the side bar), the Ace editor and the Admin UI app. The reference's YUI stand-ins are not needed. *}
{if is_unset( $load_javascript_list )}
 {def $load_javascript_list = true()}
{/if}
{include uri='design:page_head_exp.tpl'}
{if $load_javascript_list}
{* ClassicBackendJavaScriptList follows BackendJavaScriptList: the scripts the older admin designs still expect on every
   page (jQuery plugins, Exponential UI's exp:: modules). A kernel without the setting adds nothing: ezini_hasvariable()
   guards it, and the fetch is dynamic, so a compiled template neither logs a missing setting nor adds an empty entry. *}
 {def $exp_adminui_classic_scripts = cond( ezini_hasvariable( 'JavaScriptSettings', 'ClassicBackendJavaScriptList', 'design.ini' ),
                                           ezini( 'JavaScriptSettings', 'ClassicBackendJavaScriptList', 'design.ini', false(), true() ),
                                           array() )}
 {ezscript_load( ezini( 'JavaScriptSettings', 'BackendJavaScriptList', 'design.ini' )|merge( $exp_adminui_classic_scripts )|prepend( 'ezjsc::jquery', 'ezjsc::jqueryio' ) )}
 {undef $exp_adminui_classic_scripts}
{else}
 {ezscript_load( array( 'ezjsc::jquery', 'ezjsc::jqueryio' ) )}
{/if}
{* jQuery UI resizable for the left column: only where no jQuery UI is loaded yet. The copy is jQuery UI 1.11 with its
   own widget factory; loaded over a page's newer jQuery UI (eztags' tree picker) it broke that page's widgets. A
   jQuery UI without resizable gets a no-op, so the column simply keeps its width. *}
<script type="text/javascript" src={'javascript/exp_adminui_head_resizable.js'|ezdesign} data-resizable="{'javascript/ngadminui/resizable.js'|ezdesign( 'no' )|wash}"></script>
<script type="text/javascript" src={'javascript/ngadminui/bootstrap.js'|ezdesign}></script>
<script type="text/javascript" src={'javascript/ngadminui/ace/ace.js'|ezdesign}></script>
<script type="text/javascript" src={'javascript/ngadminui/ace/ext-language_tools.js'|ezdesign}></script>
<script type="text/javascript" src={'javascript/ngadminui/app.js'|ezdesign}></script>
{* Escape and the arrow keys in the side bar's dropdowns *}
<script type="text/javascript" src={'javascript/exp_adminui_aside_dropdown_keys.js'|ezdesign}></script>
{* the resizable details panel of the content view (preview.tpl) *}
<script type="text/javascript" src={'javascript/exp_adminui_details_resizer.js'|ezdesign}></script>
{* the small actions of the templates (data-expui-* attributes instead of inline handlers) *}
<script type="text/javascript" src={'javascript/exp_adminui_actions.js'|ezdesign}></script>
{* app.js points Ace at the bundle's public path; point it at this design's copy *}
<script type="text/javascript" src={'javascript/exp_adminui_ace_path.js'|ezdesign} data-base-path="{'extension/exp_adminui/design/adminui/javascript/ngadminui/ace'|ezroot( 'no' )|wash}"></script>
