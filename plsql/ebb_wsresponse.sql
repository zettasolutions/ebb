SET SCAN OFF
CREATE OR REPLACE 
PROCEDURE ebb_wsresponse (p_ws_id          IN VARCHAR2 default NULL,
                          p_job_id         IN VARCHAR2 default NULL,
                          p_ws_response    IN VARCHAR2 default NULL,
                          p_ws_url         IN VARCHAR2 default NULL) IS
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

BEGIN
  INSERT INTO ebb_job_ws (job_id, ws_id, ws_response, ws_url) VALUES (p_job_id, p_ws_id, p_ws_response, p_ws_url);
  
  htp.p('{ "Code":"JOBCOMPLETED", "Job_Id":"' || p_job_id || '","Msg":"' || p_ws_response || '"  }');
END;
/
SHOW ERR;