{**
 * templates/frontend/pages/indexSite.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Site index.
 *
 *}
{include file="frontend/components/header.tpl"}

<div class="page_index_site">

	{if $about}
		<div class="about_site">
			{$about|nl2br}
		</div>	
	{/if}	

	<div class="container mt-3">
		<h1 class="title-slick mt-1">{translate key="plugins.ufrn-theme.recentSubmissions"}</h1>
		<div class="recent-issues pt-4">
			{foreach from=$issueList item=issue}
				<div>
					<div class="col text-center p-0 m-0">
						<a href="{url journal=$issue.journalPath page="issue" op="view" path=$issue.path}">
							{if $issue.cover}
								<img src="{$issue.cover}" {*{if $issue.contain}background-size: contain;{/if}"*} class="slick_item_img">
							{else}
								<img src="{$baseUrl}{$defaultCoverImageUrl}" alt="Journal logo" class="slick_item_img">
							{/if}
							<p style="font-size: 14px; line-height: 17px;">{$issue.journal}</p>
							{* <p>{$issue.identification}</p> *}
						</a>
					</div>
				</div>		
			{/foreach}
		</div>
	</div>

	<div class="journals p-3">
		<a name="regulares">
			<div class="incubadas_encerradas_title p-2">
				<h1 class="category_title m-0" style="text-align: left">{translate key="plugins.ufrn-theme.regularJournals.name"}</h1>				
			</div>
		</a>		
		{if !count($journals)}
			{translate key="site.noJournals"}
		{else}
			<div  class="row">
				{iterate from=regular_journals item=journal}	
					{capture assign="url"}{url journal=$journal->getPath()}{/capture}
					{assign var="thumb" value=$journal->getLocalizedData('journalThumbnail')}
					<div class="col-lg-2 pt-sm-3 m-3 p-3  {if $thumb}has_thumb{/if} ">
						{if $thumb}
							{assign var="altText" value=$journal->getLocalizedData('journalThumbnailAltText')}
							<div class="center-img">
								<a href="{$url|escape}">
									<div class="side journals_img img-fluid" style="background-image: url({$journalFilesPath}{$journal->getId()}/{$thumb.uploadName|escape:"url"})"></div>	
								</a>
							</div>
						{else}
							<div class="center-img">
								<a href="{$url|escape}">	
									<div class="side journals_img img-fluid" style="background-image: url({$baseUrl}{$defaultCoverImageUrl})">
									</div>
								</a>							
							</div>
						{/if}

						<h3 style="text-align: center;">
							<a href="{$url|escape}" rel="bookmark">
								{$journal->getLocalizedName()}
							</a>
						</h3>
					</div>
				{/iterate}
			</div>

			{if $journals->getPageCount() > 0}
				<div class="cmp_pagination">
					{page_info iterator=$journals}
					{page_links anchor="journals" name="journals" iterator=$journals}
				</div>
			{else}	
	</div>
	{if $incubated_journals->count > 0}			
	<div class="journals p-3">
		<a name="incubadas" class="row incubadas_encerradas_title p-2" data-toggle="collapse" data-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
			<h1 class="category_title m-0 p-0 col-11" style="text-align: left">{translate key="plugins.ufrn-theme.incubatedJournals.name"}</h1>
			<h1 class="category_title m-0 p-0 col-1 text-right"><span class="fa fa-info-circle"></span></h1>
			<div class="collapse col-12" id="collapseOne">
				<div class="card card-body" style="text-align: justify;">
					{$incubadora}
				</div>
			</div>
		</a>
		<div class="row">
			{iterate from=incubated_journals item=journal}
			{capture assign="url"}{url journal=$journal->getPath()}{/capture}
			{assign var="thumb" value=$journal->getLocalizedData('journalThumbnail')}
			<div class="col-lg-2 pt-sm-3 mt-3 pt-3  {if $thumb}has_thumb{/if} ">
				{if $thumb}
				{assign var="altText" value=$journal->getLocalizedData('journalThumbnailAltText')}
					<div class="center-img">
						<a href="{$url|escape}">
							<div class="side journals_img img-fluid" style="background-image: url({$journalFilesPath}{$journal->getId()}/{$thumb.uploadName|escape:"url"})"></div>	
						</a>
					</div>
				{else}
					<div class="center-img">
						<a href="{$url|escape}">	
							<div class="side journals_img img-fluid" style="background-image: url({$baseUrl}{$defaultCoverImageUrl_incubadas})">
							</div>
						</a>							
					</div>
				{/if}
				<h3 style="text-align: center;">
					<a href="{$url|escape}" rel="bookmark">
						{$journal->getLocalizedName()}
					</a>
				</h3>
			</div>
			{/iterate}
		</div>
	</div>
	{/if}
	{if $terminated_journals->count > 0}
	<div class="journals p-3">
		<a name="encerradas" class="row incubadas_encerradas_title p-2" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
			<h1 class="category_title m-0 p-0 col-11" style="text-align: left">{translate key="plugins.ufrn-theme.terminatedJournals.name"}</h1>
			<h1 class="category_title m-0 p-0 col-1 text-right"><span class="fa fa-info-circle"></span></h1>
			<div class="collapse col-12" id="collapseTwo">
				<div class="card card-body" style="text-align: justify;">
					{$encerradas}
				</div>
			</div>
		</a>
		<div class="row">
			{iterate from=terminated_journals item=journal}	
			{capture assign="url"}{url journal=$journal->getPath()}{/capture}
			{assign var="thumb" value=$journal->getLocalizedData('journalThumbnail')}

			<div class="col-lg-2 pt-sm-3 mt-3 pt-3  {if $thumb}has_thumb{/if} ">
				{if $thumb}
				{assign var="altText" value=$journal->getLocalizedData('journalThumbnailAltText')}
					<div class="center-img">
						<a href="{$url|escape}">
							<div class="side journals_img img-fluid" style="background-image: url({$journalFilesPath}{$journal->getId()}/{$thumb.uploadName|escape:"url"})"></div>	
						</a>
					</div>
				{else}
					<div class="center-img">
						<a href="{$url|escape}">	
							<div class="side journals_img img-fluid" style="background-image: url({$baseUrl}{$defaultCoverImageUrl_encerradas})">
							</div>
						</a>							
					</div>
				{/if}
				<h3 style="text-align: center;">
					<a href="{$url|escape}" rel="bookmark">
						{$journal->getLocalizedName()}
					</a>
				</h3>
			</div>
			{/iterate}
		</div>
	</div>
	{/if}						
{/if}			
{/if}

</div><!-- .page -->
<button class="back-to-top" type="button"></button>

{include file="frontend/components/footer.tpl"}