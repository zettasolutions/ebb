SET SCAN OFF
CREATE OR REPLACE
PACKAGE BODY ebb_lib IS

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


   FUNCTION ServiceName RETURN VARCHAR2
   IS
      script_name     VARCHAR2(255) DEFAULT owa_util.get_cgi_env('SCRIPT_NAME');
   BEGIN
      RETURN SUBSTR(script_name, 1, INSTR(script_name,'/',-1));
   END ServiceName;


   FUNCTION ServerPath RETURN VARCHAR2 IS
   BEGIN
      RETURN '/apps/';
   END ServerPath;

   FUNCTION StylePath RETURN VARCHAR2 IS
   BEGIN
      RETURN '/apps/s004/css/';
   END StylePath;

   FUNCTION ImagePath RETURN VARCHAR2 IS
   BEGIN
      RETURN '/apps/s004/images/';
   END ImagePath;

   FUNCTION JSPath RETURN VARCHAR2 IS
   BEGIN
      RETURN '/apps/s004/js/';
   END JSPath;

   FUNCTION DHTMLXPath RETURN VARCHAR2 IS
   BEGIN
      RETURN '/apps/dhtmlx3.6/';
   END DHTMLXPath;

   FUNCTION MainCSS RETURN VARCHAR2 IS
   BEGIN
      RETURN 's004_main.css';
   END MainCSS;

   FUNCTION DefaultDateFormat RETURN VARCHAR2 IS
   BEGIN
      RETURN 'MM/DD/YYYY';
   END DefaultDateFormat;

   FUNCTION ClientLogo RETURN VARCHAR2 IS
   BEGIN
      RETURN 'mcwd.gif';
   END ClientLogo;


   FUNCTION ClientName RETURN VARCHAR2 IS
   BEGIN
      RETURN 'Metropolitan Cebu Water District';
   END ClientName;

END;
/
SHOW ERRORS
