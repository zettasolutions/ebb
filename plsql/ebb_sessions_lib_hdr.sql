SET SCAN OFF
CREATE OR REPLACE
PACKAGE ebb_sessions_lib IS

   /*
   =======================================================================
   *
   * Copyright (c) 20014-2015 by ZSI.  All rights reserved.
   *
   * Redistribution and use in source and binary forms, with or without
   * modification is strictly prohibited.
   *
   ========================================================================
   */

   /* Modification History
   Date       By    History
   ---------  ----  -------------------------------------------------------
   03-MAY-15  BD    New
   */

   FUNCTION IsValidUser (p_logon IN VARCHAR2) RETURN VARCHAR2;

   PROCEDURE SetCookieUser (p_logon  IN  VARCHAR2);

   FUNCTION GetCookieUser RETURN VARCHAR2;

   PROCEDURE RedirectURL(p_url IN VARCHAR2);

END ebb_sessions_lib;
/
SHOW ERRORS
