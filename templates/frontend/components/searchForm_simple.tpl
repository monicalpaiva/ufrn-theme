{**
 * templates/frontend/components/searchForm_simple.tpl
 *
 * Copyright (c) 2014-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Simple display of a search form with just text input and search button
 *
 * @uses $searchQuery string Previously input search query
 *}
 

<div class="ufrn_search">
	<form action="{url page="search" op="search"}" method="post" autocomplete="off" role="search" class="row justify-content-center">
		{csrf}	
		<div class="input-group mb-3 col-8">
			<input type="text" class="query" id="query" name="query" value="{$query|escape}" placeholder="{translate|escape key="plugins.ufrn-theme.search.placeholder"}"></button>
			<div class="input-group-append">
				<button type="submit" id="button-addon2"><span class="fa fa-search"></span></button>
			</div>
		</div>	
	</form>
</div>