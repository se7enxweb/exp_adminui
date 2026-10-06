{* Exponential Admin UI: the "You are here" path, from page_toppath.html.twig (items from $module_result.path) *}
<p class="path">
    <span class="path-here-text">{'You are here:'|i18n( 'design/adminui/pagelayout' )}</span>
    {foreach $module_result.path as $path_item}
        {if ne( $ui_context, 'edit' )}
            {if and( is_set( $path_item.url_alias ), $path_item.url_alias )}
                <a class="path" href={$path_item.url_alias|ezurl}>{$path_item.text|wash}</a>
            {elseif and( is_set( $path_item.url ), $path_item.url )}
                <a class="path" href={$path_item.url|ezurl}>{$path_item.text|wash}</a>
            {else}
                <span class="path">{$path_item.text|wash}</span>
            {/if}
        {else}
            <span class="disabled">{$path_item.text|wash}</span>
        {/if}
        {delimiter}<span class="slash">/</span>{/delimiter}
    {/foreach}
&nbsp;</p>
