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
   l_job_count NUMBER;

BEGIN

     htp.p('{"code":"alert","value":true}');
END;
/
SHOW ERR;