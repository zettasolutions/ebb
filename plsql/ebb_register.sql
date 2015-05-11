SET SCAN OFF
CREATE OR REPLACE 
PROCEDURE ebb_register (p_macadd          IN VARCHAR2 default NULL,
                        p_ws_name         IN VARCHAR2 default NULL) IS
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


BEGIN
  BEGIN
     SELECT ws_id INTO l_ws_id
       FROM ebb_workstations
      WHERE ws_name = p_ws_name;
  EXCEPTION
     WHEN NO_DATA_FOUND THEN
          NULL;
     WHEN OTHERS THEN
          NULL;
  END;
   
   IF l_ws_id IS NULL THEN
      SELECT ebb_workstations_sq001.NEXTVAL INTO l_ws_id FROM DUAL;
      INSERT INTO ebb_workstations (
         ws_id
         ,ws_name
      )
      VALUES (
         l_ws_id
        ,p_ws_name);        
      INSERT INTO ebb_workstation_mac (ws_id, macaddress) values (l_ws_id,p_macadd);
  ELSE
     BEGIN
         INSERT INTO ebb_workstation_mac (ws_id, macaddress) values (l_ws_id,p_macadd);
     EXCEPTION
         WHEN OTHERS THEN
           NULL;
     END;      
           
  END IF;
  
  htp.p('{ "Code":"WSID", "value":"' || l_ws_id || '" }');
   
 
END;
/
SHOW ERR;