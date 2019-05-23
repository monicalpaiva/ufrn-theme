{**
 * lib/pkp/templates/frontend/components/header.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Common frontend site header.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}
{strip}
	{* Determine whether a logo or title string is being displayed *}
	{assign var="showingLogo" value=true}
	{if $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
		{assign var="showingLogo" value=false}
	{/if}
{/strip}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key=$pageTitle}{/capture}{/if}
{include file="frontend/components/headerHead.tpl"}
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"} has_site_logo" dir="{$currentLocaleLangDir|escape|default:"ltr"}">

	<div class="cmp_skip_to_content">
		<a href="#pkp_content_main">{translate key="navigation.skip.main"}</a>
		<a href="#pkp_content_nav">{translate key="navigation.skip.nav"}</a>
		<a href="#pkp_content_footer">{translate key="navigation.skip.footer"}</a>
	</div>
	<div class="pkp_structure_page">
		<div id="barra-brasil" style="height: 23px; width: 100%; opacity: 0.1;">
			<ul id="menu-barra-temp" style="list-style:none;">
				<li style="display:inline; padding-right:10px; margin-right:10px;">
				<a href="http://brasil.gov.br" target="_blank" style="font-family:sans,sans-serif; text-decoration:none; color: transparent;">
					Portal do Governo Brasileiro</a>
				</li>
			</ul>
		</div>
		{* Header *}
		<header class="pkp_structure_head" id="headerNavigationContainer" role="banner">
			<div class="pkp_head_wrapper">
				<nav class="pkp_navigation_user_wrapper" id="navigationUserWrapper" aria-label="{translate|escape key="common.navigation.user"}">
					{load_menu name="user" id="navigationUser" ulClass="pkp_navigation_user"}
				</nav>
				<div class="pkp_site_name_wrapper">
					{* Logo or site title. Only use <h1> heading on the homepage.
					   Otherwise that should go to the page title. *}
					{if $requestedOp == 'index'}
						<h1 class="pkp_site_name">
					{else}
						<div class="pkp_site_name">
					{/if}
						{capture assign="homeUrl"}
							{if $currentContext && $multipleContexts}
								{url page="index" router=$smarty.const.ROUTE_PAGE}
							{else}
								{url context="index" router=$smarty.const.ROUTE_PAGE}
							{/if}
						{/capture}
						{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
							<a href="{$homeUrl}" class="is_img">
								<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}" {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
							</a>
						{elseif $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
							<a href="{$homeUrl}" class="is_text">{$displayPageHeaderTitle}</a>
						{elseif $displayPageHeaderTitle && !$displayPageHeaderLogo && is_array($displayPageHeaderTitle)}
							<a href="{$homeUrl}" class="is_img">
								<img src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}" alt="{$displayPageHeaderTitle.altText|escape}" width="{$displayPageHeaderTitle.width|escape}" height="{$displayPageHeaderTitle.height|escape}" />
							</a>
						{else}
							<a href="{$homeUrl}" class="is_img">
								<img src="{$baseUrl}/templates/images/structure/logo.png" alt="{$applicationName|escape}" title="{$applicationName|escape}" width="180" height="90" />
							</a>
						{/if}
					{if $requestedOp == 'index'}
						</h1>
					{else}
						</div>
					{/if}

					{include file="frontend/components/searchForm_simple.tpl"}
				</div>

				{* Primary site navigation *}
				{capture assign="primaryMenu"}					
					{load_menu name="primary" id="navigationPrimary" ulClass="pkp_navigation_primary"}
				{/capture}

				{if !empty(trim($primaryMenu)) || $currentContext}
					<nav class="pkp_navigation_primary_row" aria-label="{translate|escape key="common.navigation.site"}">
						<div class="pkp_navigation_primary_wrapper">
							{* Primary navigation menu for current application *}
							{$primaryMenu}

							{if $currentContext}
								{* Search form *}
								{include file="frontend/components/searchForm_simple.tpl"}
							{/if}
						</div>
					</nav>
				{/if}			
				
			</div><!-- .pkp_head_wrapper -->
		</header><!-- .pkp_structure_head -->
{** bandeiras 
<nav class="nav-bar">
		{foreach key=field item=language from=$supportedLocales}
			{if $language}
					<a class="language_flag" href="{url router=$smarty.const.ROUTE_PAGE page="user" op="setLocale" path=$field source=$smarty.server.REQUEST_URI}">
						<img src="{$baseUrl}{$defaultFlagsUrl}{$field}.svg" alt="Language select">
					</a>
			{/if}
		{/foreach}
</nav>
*}
				<div class="menuInterno" >
					<nav class="navbar navbar-expand-md navbar-light" style="height:30px" >
						<div class="col-sm-12">
						<div id="collapsibleNavbar">
							<div class="container p-0" >
								<ul class="topnav navbar-nav" style="text-align:left"> <!-- Defina uma classe a Ul -->
									<li class="p-3"><a class="nav-link" href="{$baseUrl}" style="color: #fff;">{translate key="plugins.ufrn-theme.regularJournals.name"}</a></li>
									<li class="p-3"><a class="nav-link" href="{$baseUrl}#incubadas" style="color: #fff;">{translate key="plugins.ufrn-theme.incubatedJournals.name"}</a></li>
									<li class="p-3"><a class="nav-link" href="{$baseUrl}#encerradas" style="color: #fff;">{translate key="plugins.ufrn-theme.terminatedJournals.name"}</a></li>
									<li class="icon">
										<a href="javascript:void(0);" onclick="myFunction()">&#9776;</a>
									</li>
								</ul>
							</div>
						</div>
						</div>
					</nav>
				</div>


		{* Wrapper for page content and sidebars *}
		{if $isFullWidth}
			{assign var=hasSidebar value=0}
		{/if}
		<div class="pkp_structure_content{if $hasSidebar} has_sidebar{/if}">
			<div id="pkp_content_main" class="pkp_structure_main" role="main">

