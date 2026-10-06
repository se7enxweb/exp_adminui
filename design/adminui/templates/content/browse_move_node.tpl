{if is_set( $browse.content.name_list )}
    {def $content_object_name = $browse.content.name_list|implode(', ')}
{else}
    {def $content_object=fetch( 'content', 'object', hash( 'object_id', $browse.content.object_id ) )
        $content_object_name = $content_object.name}
{/if}

{* DESIGN: Header START *}
<div class="box-header">

    <h1 class="context-title">{'Choose a new location for <%object_name>'|i18n( 'design/admin/content/browse_move_node',, hash( '%object_name', $content_object_name ) )|wash}</h1>

    {* DESIGN: Mainline *}<div class="header-mainline"></div>

    {* DESIGN: Header END *}
</div>

{* DESIGN: Content START *}
<div class="panel">
    <p>{'Choose a new location for <%object_name> using the radio buttons then click "Select".'|i18n( 'design/admin/content/browse_move_node',, hash( '%object_name', $content_object_name ) )|wash}</p>
    <p>{'Navigate using the available tabs (above), the tree menu (left) and the content list (middle).'|i18n( 'design/admin/content/browse_move_node' )}</p>

{* content jobs: what the move touches and the now-or-background choice, sent with the browse form *}
{if and( is_set( $browse.content_job_summary ), is_array( $browse.content_job_summary ) )}
{include uri='design:content/job_summary.tpl' job_summary=$browse.content_job_summary operation='move'}
{/if}
{if and( is_set( $browse.content_job_mode ), is_array( $browse.content_job_mode ) )}
{include uri='design:content/job_mode_choice.tpl' job_mode=$browse.content_job_mode form_name='browse'}
{/if}
</div>

{* DESIGN: Content END *}

{undef}
