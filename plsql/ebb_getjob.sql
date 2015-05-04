SET SCAN OFF
CREATE OR REPLACE 
PROCEDURE ebb_getjob (p_ws_id          IN VARCHAR2 default NULL) IS
/*
========================================================================
*
* Copyright (c) 2014 ZettaSolution, Inc.  All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification is strictly prohibited.
*
========================================================================
*/
/* Modification History
   Date       By    History
   ---------  ----  ---------------------------------------------------------------------
   03-AUG-14  GT    New
*/
--DECLARATION SECTION
l_ws_id    NUMBER;

l_job_id    NUMBER;
l_filename  VARCHAR2(32000);
l_action    VARCHAR2(100);




BEGIN

  SELECT a.job_id, a.filename, a.action INTO l_job_id, l_filename, l_action FROM ebb_curr_jobs_v a  
  WHERE NOT EXISTS (SELECT b.job_id FROM ebb_job_ws b where b.job_id = a.job_id AND b.ws_id = p_ws_id)
  AND ws_id = p_ws_id
  AND ROWNUM=1;
  
  htp.p('{ "Code":"' || l_action || '","Job_Id":"' || l_job_id || '","Msg":"' || l_filename || '" }');

EXCEPTION
   WHEN NO_DATA_FOUND THEN
       htp.p('{ "Code":"' || l_action || '","Job_Id":"' || l_job_id || '","Msg":"' || l_filename || '" }');
END;
/
SHOW ERR;