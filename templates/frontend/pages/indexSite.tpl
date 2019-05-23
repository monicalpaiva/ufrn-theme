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
					<div class="col text-center">
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
				<h1 class="category_title m-0">{translate key="plugins.ufrn-theme.regularJournals.name"}</h1>				
			</div>
		</a>		
		{if !count($journals)}
			{translate key="site.noJournals"}
		{else}
			<ul>
				{iterate from=regular_journals item=journal}	
					{capture assign="url"}{url journal=$journal->getPath()}{/capture}
					{assign var="thumb" value=$journal->getLocalizedData('journalThumbnail')}
					{assign var="description" value=$journal->getLocalizedDescription()}
					<li class="row {if $thumb}has_thumb{/if}">
						<h3 class="col-12 d-xs-block d-sm-none">
							<a href="{$url|escape}" rel="bookmark">
								{$journal->getLocalizedName()}
							</a>
						</h3>
						{if $thumb}
							{assign var="altText" value=$journal->getLocalizedData('journalThumbnailAltText')}
							<div class="thumb col-lg-2 pt-sm-3">
								<a href="{$url|escape}">
								<!-- rotacionar imagem -->
									<ul id="bk-list" class="bk-list clearfix">
										<li>	
											<img src="{$journalFilesPath}{$journal->getId()}/{$thumb.uploadName|escape:"url"}"
												{if $altText} alt="{$altText|escape}"{/if} style="object-fit: contain;max-height:100%;" class="img-fluid">
										</li>
									</ul>			
								</a>
							</div>
						{else}
							<div class="thumb col-lg-2 pt-sm-3">
								<a href="{$url|escape}">	
									<!-- rotacionar imagem -->
									<ul id="bk-list" class="bk-list clearfix">
										<li>
											<img src="{$baseUrl}{$defaultCoverImageUrl}" alt="Journal logo" style="object-fit: contain;max-height:100%;" class="img-fluid">																
										</li>
									</ul>
								</a>
							
							</div>
						{/if}

						<div class="body col-lg-8 d-none d-sm-block">
							<h3>
								<a href="{$url|escape}" rel="bookmark">
									{$journal->getLocalizedName()}
								</a>
							</h3>
							{if $description}
							<!-- colocar limite na caixa de texto do scopo das revitas: adcionar na div description 
								style="min-height: 50px;max-height: 140px;overflow: hidden;text-overflow: ellipsis;"-->
								<div class="description" >
									{$description|nl2br}
								</div>
							{/if}
							<ul class="links">
								<li class="view">
									<a href="{$url|escape}">
										{translate key="site.journalView"}
									</a>
								</li>
								<li class="current">
									<a href="{url|escape journal=$journal->getPath() page="issue" op="current"}">
										{translate key="site.journalCurrent"}
									</a>
								</li>
							</ul>
						</div>
					</li>
				{/iterate}
			</ul>

			{if $journals->getPageCount() > 0}
				<div class="cmp_pagination">
					{page_info iterator=$journals}
					{page_links anchor="journals" name="journals" iterator=$journals}
				</div>
			{else}	
				{if $incubated_journals->count > 0}			
					<div class="content p-3">
						<a name="incubadas" href="{$baseUrl}/index.php/index/incubadora">
							<div class="row incubadas_encerradas_title p-2">
								<h1 class="category_title m-0 p-0 col-11">{translate key="plugins.ufrn-theme.incubatedJournals.name"}</h1>
								<h1 class="category_title m-0 p-0 col-1 text-right"><span class="fa fa-info-circle"></span></h1>
							</div>
						</a>
					<div class="row incubadas_encerradas">
						{iterate from=incubated_journals item=journal}
							{capture assign="url"}{url journal=$journal->getPath()}{/capture}
							{assign var="description" value=$journal->getLocalizedDescription()}
							{assign var="thumb" value=$journal->getLocalizedData('journalThumbnail')}
							
								<div class="col-sm-12 col-md-6 incubadas_encerradas_content">									
									<div class="row">
										<div class="col-2 mt-0 incubadas_encerradas_thumb">
											<a href="{$url|escape}">
												{if $thumb}												
													<img src="{$journalFilesPath}{$journal->getId()}/{$thumb.uploadName|escape:"url"}"{if $altText} alt="{$altText|escape}"{/if} class="incubada-img-card">												
												{else}
													<img src="{$baseUrl}{$defaultCoverImageUrl}" alt="Journal logo" class="incubadora-img-card">												
												{/if}
											</a>
										</div>
										<div class="col-10">
											<a href="{$url|escape}">
												<h4 style="margin-top: 0">{$journal->getLocalizedName()}</h4>
											</a>
											<div class="d-none d-sm-block">
												{if $description}
													<p class="card-text">{$description|nl2br|truncate:120}</p>
												{else}
													<a href="{$url|escape}">{translate key="site.journalView"}</a>
												{/if}
											</div>
											
										</div>
									</div>									
								</div>
							{/iterate}
						</div>
					</div>
				{/if}

				{if $terminated_journals->count > 0}
					<div class="content p-3">
						<a name="encerradas" href="{$baseUrl}/index.php/index/encerradas">
							<div class="row incubadas_encerradas_title p-2">
								<h1 class="category_title m-0 p-0 col-11">{translate key="plugins.ufrn-theme.terminatedJournals.name"}</h1>
								<h1 class="category_title m-0 p-0 col-1 text-right"><span class="fa fa-info-circle"></span></h1>
							</div>
						</a>
						<div class="row incubadas_encerradas">
							{iterate from=terminated_journals item=journal}							

								{capture assign="url"}{url journal=$journal->getPath()}{/capture}
								{assign var="description" value=$journal->getLocalizedDescription()}
								{assign var="thumb" value=$journal->getLocalizedData('journalThumbnail')}
								
								<div class="col-sm-12 col-md-6 mb-md-3 incubadas_encerradas_content">									
									<div class="row">
										<div class="col-2 mt-0 incubadas_encerradas_thumb">
											<a href="{$url|escape}">
												{if $thumb}												
													<img src="{$journalFilesPath}{$journal->getId()}/{$thumb.uploadName|escape:"url"}"{if $altText} alt="{$altText|escape}"{/if} class="incubada-img-card">												
												{else}
													<img src="{$baseUrl}{$defaultCoverImageUrl}" alt="Journal logo" class="incubadora-img-card">												
												{/if}
											</a>
										</div>
										<div class="col-10">
											<a href="{$url|escape}">
												<h4 class="mt-0">{$journal->getLocalizedName()}</h4>
											</a>

											<div class="d-none d-sm-block">
												{if $description}
													<p class="card-text">{$description|nl2br|truncate:120}</p>
												{else}
													<a href="{$url|escape}">{translate key="site.journalView"}</a>
												{/if}
											</div>
											
										</div>
									</div>									
								</div>
									
							{/iterate}
						</div>
					</div>
				{/if}						
			{/if}			
		{/if}
	</div>

</div><!-- .page -->
	
<button class="back-to-top" type="button"></button>

{include file="frontend/components/footer.tpl"}

