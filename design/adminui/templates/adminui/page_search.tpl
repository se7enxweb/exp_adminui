{* Exponential Admin UI: the search form of the header, from page_search.html.twig.
   Posted to content/search, which answers with a 303 to the search as view parameters (content/search/(text)/...).
   While the user types, the field suggests content, users, classes and admin pages under it, as in every admin
   design: the field is a combobox (parts/search_suggest.tpl, javascript/page/search_suggest.js and the
   "Suggestions" block of modules/search.css, all from design/admin through the design chain; content/suggest;
   admininterface.ini [SearchSuggestSettings]); Ctrl+/ or Cmd+/ focuses it. Not in the browse mode, and not for a
   user who may not open content/suggest. *}
{def $adminui_search_text = first_set( $search_text, '' )
     $adminui_search_suggest = and( ezini( 'SearchSuggestSettings', 'Enabled', 'admininterface.ini' )|eq( 'true' ), $ui_context|ne( 'browse' ), fetch( 'user', 'can_open', hash( 'uri', 'content/suggest' ) ) )}
<form action={'/content/search/'|ezurl} method="post" class="navbar-form" role="search" aria-label="{'Quick search'|i18n( 'design/admin/pagelayout' )|wash}">
    {if $ui_context_edit}
        <button id="searchButton" name="SearchButton" type="submit" class="search-btn disabled" disabled="disabled" title="{'Search'|i18n( 'design/admin/pagelayout' )|wash}"><i class="fa fa-search" aria-hidden="true"></i><span class="sr-only">{'Search'|i18n( 'design/admin/pagelayout' )}</span></button>
        <input id="searchText" name="SearchText" class="search-input disabled" type="text" size="20" value="{$adminui_search_text|wash}" placeholder="{'Search content...'|i18n( 'design/adminui/search' )}" disabled="disabled" />
    {else}
        <button id="searchButton" name="SearchButton" type="submit" class="search-btn" title="{'Search'|i18n( 'design/admin/pagelayout' )|wash}"><i class="fa fa-search" aria-hidden="true"></i><span class="sr-only">{'Search'|i18n( 'design/admin/pagelayout' )}</span></button>
        <input id="searchText" name="SearchText" class="search-input" type="search" value="{$adminui_search_text|wash}" placeholder="{'Search content...'|i18n( 'design/adminui/search' )}" aria-label="{'Search in all content'|i18n( 'design/admin/pagelayout' )|wash}"{if $adminui_search_suggest} role="combobox" aria-autocomplete="list" aria-expanded="false" aria-controls="searchsuggest-list" aria-keyshortcuts="Control+/ Meta+/" autocomplete="off" data-suggest-url={'content/suggest'|ezurl} data-suggest-min="{ezini( 'SearchSuggestSettings', 'MinLength', 'admininterface.ini' )|int}"{/if} />
        {if $adminui_search_suggest}{include uri='design:parts/search_suggest.tpl' suggest_id='searchsuggest'}{/if}
        {if eq( $ui_context, 'browse' )}
            <input name="Mode" type="hidden" value="browse" />
            <input name="BrowsePageLimit" type="hidden" value="{min( min( ezpreference( 'admin_list_limit' ), 3 )|choose( 10, 10, 25, 50 ), ezini( 'SearchSettings', 'MaximumSearchLimit' ) )}" />
        {/if}
    {/if}
</form>
{if $adminui_search_suggest}{ezscript( array( 'page/search_suggest.js' ) )}{/if}
{undef $adminui_search_text $adminui_search_suggest}
