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
import ('classes.journal.JournalDAO');
class JournalUfrnDAO extends JournalDAO {
    public function getJournalsByPath($paths) {
		$query = "SELECT * FROM " . $this->_getTableName(). " WHERE path IN ('". implode("','", $paths) ."') ORDER BY seq";
		$result = $this->retrieve($query);
		return new DAOResultFactory($result, $this, '_fromRow');
	}
}