<?php
define('OMEGAUP_ALLOW_PRIVILEGE_SELF_ASSIGNMENT', true);
define('OMEGAUP_CSP_LOG_FILE', '/tmp/csp.log');
define('OMEGAUP_DB_HOST', 'localhost');
define('OMEGAUP_DB_NAME', 'omegaup');
define('OMEGAUP_DB_PASS', '');
define('OMEGAUP_DB_USER', 'travis');
// Setting non-development mode to make all requests faster by avoiding parsing
// Smarty templates every time.
define('OMEGAUP_ENVIRONMENT', 'production');
define('OMEGAUP_GRADER_FAKE', true);
define('OMEGAUP_LOG_FILE', '/tmp/omegaup.log');
define('OMEGAUP_ENABLE_SOCIAL_MEDIA_RESOURCES', false);
define('SMARTY_CACHE_DIR', '/tmp');
