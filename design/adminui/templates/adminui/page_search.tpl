{* Exponential Admin UI: the search form of the header, from page_search.html.twig *}
{def $search_text = cond( ezhttp_hasvariable( 'SearchText', 'get' ), ezhttp( 'SearchText', 'get' ), '' )}
<form action={'/content/search'|ezurl} method="get" class="navbar-form" role="search">
    {if $ui_context_edit}
        <button id="searchButton" name="SearchButton" type="submit" class="search-btn disabled" disabled="disabled"><i class="fa fa-search"></i></button>
        <input id="searchText" name="SearchText" class="search-input disabled" type="text" size="20" value="{$search_text|wash}" placeholder="{'Search content...'|i18n( 'design/adminui/search' )}" disabled="disabled" />
    {else}
        <button id="searchButton" name="SearchButton" type="submit" class="search-btn"><i class="fa fa-search"></i></button>
        <input id="searchText" name="SearchText" class="search-input" type="text" value="{$search_text|wash}" placeholder="{'Search content...'|i18n( 'design/adminui/search' )}" />
        {if eq( $ui_context, 'browse' )}
            <input name="Mode" type="hidden" value="browse" />
            <input name="BrowsePageLimit" type="hidden" value="{min( ezpreference( 'admin_list_limit' ), 3 )|choose( 10, 10, 25, 50 )}" />
        {/if}
    {/if}
</form>
{undef $search_text}
