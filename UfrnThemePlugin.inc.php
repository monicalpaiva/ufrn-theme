<?php

/**
 * @file plugins/themes/default/UfrnThemePlugin.inc.php
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class UfrnThemePlugin
 * @ingroup plugins_themes_default
 *
 * @brief Ufrn theme
 */

import('lib.pkp.classes.plugins.ThemePlugin');

class UfrnThemePlugin extends ThemePlugin {

	/**
	 * Initialize the theme's styles, scripts and hooks. This is only run for
	 * the currently active theme.
	 *
	 * @return null
	 */	
	public function init() {

		$this->import('classes.IssueUfrnDAO');
		$this->import('classes.JournalUfrnDAO');
		DAORegistry::registerDAO('IssueUfrnDAO', new IssueUfrnDAO());
		DAORegistry::registerDAO('JournalUfrnDAO', new JournalUfrnDAO());

		$this->setParent('defaultthemeplugin');	
		
		$this->addOption('regularJournals', 'text', array(
			'label' => 'plugins.ufrn-theme.regularJournals.name',
			'description' => 'plugins.ufrn-theme.regularJournals.description',
		));
		
		$this->addOption('incubatedJournals', 'text', array(
			'label' => 'plugins.ufrn-theme.incubatedJournals.name',
			'description' => 'plugins.ufrn-theme.incubatedJournals.description',
		));
		
		$this->addOption('terminatedJournals', 'text', array(
			'label' => 'plugins.ufrn-theme.terminatedJournals.name',
			'description' => 'plugins.ufrn-theme.terminatedJournals.description',
		));

		$this->addStyle('bootstrap', 'styles/bootstrap.min.css');
		$this->addStyle('slick-css', 'styles/slick.min.css');
		$this->addStyle('slick-theme-css', 'styles/slick-theme.min.css');
		$this->addStyle('ufrn-css', 'styles/ufrn_azul.css');

		$this->addScript('bootstrap-bundle', 'scripts/bootstrap.bundle.js');
		$this->addScript('barra-governo', 'scripts/barra.js'); 
		$this->addScript('barra-governo-hack', 'scripts/barragoverno.hack.js');
		$this->addScript('slick-script', 'scripts/slick.min.js');
		$this->addScript('index-script', 'scripts/index.js');

		HookRegistry::register('TemplateManager::display', array($this, 'browseJournals'), HOOK_SEQUENCE_CORE);
		HookRegistry::register('TemplateManager::display', array($this, 'languagesMenu'), HOOK_SEQUENCE_CORE);			
		HookRegistry::register('TemplateManager::display', array($this, 'imagensIbictCariniana'), HOOK_SEQUENCE_CORE);	
	}	

	/**
	 * Get the display name of this plugin
	 * @return string
	 */
	function getDisplayName() {
		return __('plugins.themes.ufrn-theme.name');
	}

	/**
	 * Get the description of this plugin
	 * @return string
	 */
	function getDescription() {
		return __('plugins.themes.ufrn-theme.description');
	}	

	/* Retrieving journals */
	public function browseJournals($hookName, $args) {
		$smarty = $args[0];
		$template = $args[1];

		$smarty->assign(array(
			'brandImage' => 'templates/images/ojs_brand_white.png',
			'packageKey' => 'common.openJournalSystems',
		));	

		if ($template != 'frontend/pages/indexSite.tpl') return false;
		
		//Journals
		$regularJournalsPaths = $this->getJournalsByPath($this->getOption('regularJournals'));		
		$incubatedJournalsPaths =  $this->getJournalsByPath($this->getOption('incubatedJournals'));
		$terminatedJournalsPaths =  $this->getJournalsByPath($this->getOption('terminatedJournals'));
		
		$journalDao = DAORegistry::getDAO('JournalUfrnDAO');
		$regular_journals = $journalDao->getJournalsByPath($regularJournalsPaths);
		$incubated_journals = $journalDao->getJournalsByPath($incubatedJournalsPaths);
		$terminated_journals = $journalDao->getJournalsByPath($terminatedJournalsPaths);		
		
		$smarty->assign('regular_journals', $regular_journals);
		$smarty->assign('incubated_journals', $incubated_journals);
		$smarty->assign('terminated_journals', $terminated_journals);
		
		//Images
		$defaultCoverImageUrl = "/" . $this->getPluginPath() . "/images/journal-default.png";		
		$smarty->assign('defaultCoverImageUrl', $defaultCoverImageUrl);				

		//latest issues
		$issueUfrnDAO = DAORegistry::getDAO('IssueUfrnDAO');
		$latestIssues = $issueUfrnDAO->getLatestIssues();
		$smarty->assign('issueList', $latestIssues);
	}

	public function getJournalsByPath($paths) {
		//Removing blank spaces from list
		$paths = preg_replace('/\s+/', '', $paths);	
		return explode(',', $paths);	
	}

	public function languagesMenu($hookName, $args) {
		$smarty = $args[0];
		$template = $args[1];

		$defaultFlagsUrl = "/" . $this->getPluginPath() . "/images/flags/";

		$request = $this::getRequest();
		$site = $request->getSite();
		$locales = $site->getSupportedlocaleNames();

		$smarty->assign('supportedLocales', $locales);
		$smarty->assign('defaultFlagsUrl', $defaultFlagsUrl);
	}

	public function imagensIbictCariniana($hookName, $args){
		$smarty = $args[0];
		$template = $args[1];

		$defaultCariniana = "/" . $this->getPluginPath() . "/images/cariniana.png";
		$defaultIbict = "/" . $this->getPluginPath() . "/images/ibict.png";
		$defaultCC = "/" . $this->getPluginPath() . "/images/Creatives.png";
		$defaultBCZM = "/" . $this->getPluginPath() . "/images/BCZM.png";

		$smarty->assign('defaultCariniana', $defaultCariniana);
		$smarty->assign('defaultIbict', $defaultIbict);
		$smarty->assign('defaultCC', $defaultCC);
		$smarty->assign('defaultBCZM', $defaultBCZM);
		
	}
}

?>
