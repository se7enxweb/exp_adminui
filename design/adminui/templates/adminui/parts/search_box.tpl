{* Exponential Admin UI: the header search, from parts/search_box.html.twig and page_search.html.twig *}
<div class="search-form">
    {if $ui_context_edit|not}
        {include uri='design:adminui/page_search.tpl'}
    {/if}
</div>
