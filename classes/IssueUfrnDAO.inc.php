<?php
/**
 * @file classes/issue/IssueDAO.inc.php
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class IssueDAO
 * @ingroup issue
 * @see Issue
 *
 * @brief Operations for retrieving and modifying Issue objects.
 */
import ('classes.issue.IssueDAO');

class IssueUfrnDAO extends IssueDAO {

    public function getLatestIssues() {

		$issues = array();
		$issueList = array();
		$volLabel = __('issue.vol');
		$numLabel = __('issue.no');		
		$journalDao = DAORegistry::getDAO('JournalDAO');
		
		$query_all_journals = "SELECT issue_id FROM issues WHERE published = '1' AND access_status= '1' AND year != '0' ORDER BY date_published DESC LIMIT 9";
		$sql_enabled_journals = "SELECT i.issue_id FROM issues i INNER JOIN journals j ON i.journal_id = j.journal_id WHERE i.published = '1' AND i.access_status= '1' AND j.enabled = 1 AND i.year != '0' ORDER BY date_published DESC LIMIT 9";
		$result = $this->retrieve($sql_enabled_journals);
		
		while (!$result->EOF) {
			$resultRow = $result->GetRowAssoc(false);
			$issues[$resultRow['issue_id']] = $this->getById($resultRow['issue_id']);
			$result->MoveNext();
		}
		$result->Close();

		foreach($issues as $issueId => $issue){
			
			$journal = $journalDao->getById($issue->getJournalId());
			$issueList[$issueId]['journal'] = $journal->getLocalizedName();
			$issueList[$issueId]['journalPath'] = $journal->getPath();
			
			if ($issue->getLocalizedCoverImageUrl()){
				$issueList[$issueId]['cover'] =  $issue->getLocalizedCoverImageUrl();
				$issueList[$issueId]['contain'] =  true;
			}	
			else{
				$issueList[$issueId]['cover'] =  null;
			}
			
			
			$issueList[$issueId]['path'] =  $issue->getBestIssueId();
			
			$volume = $issue->getVolume();
			$number = $issue->getNumber();
			$year = $issue->getyear();
			
			$issueIdentification = "";
			if ($year != "") $issueIdentification = "(".$year.")".$issueIdentification;
			if ($number != "0") $issueIdentification = $numLabel." ".$number." ".$issueIdentification;
			if ($volume != "0") $issueIdentification = $volLabel." ".$volume." ".$issueIdentification;		
			
			$issueList[$issueId]['identification'] =  $issueIdentification;	
			
		}
		return $issueList;
	}

}