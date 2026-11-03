{* Exponential Admin UI: the header search, from parts/search_box.html.twig and page_search.html.twig.
   aui-search-box: the suggestions under the field show over the page (adminui-pages.css). *}
<div class="search-form aui-search-box">
    {if $ui_context_edit|not}
        {include uri='design:adminui/page_search.tpl'}
    {/if}
</div>
