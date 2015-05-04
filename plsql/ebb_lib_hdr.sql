SET SCAN OFF
CREATE OR REPLACE
PACKAGE ebb_lib IS

   /*
   =======================================================================
   *
   * Copyright (c) 20014-2014 by ZSI.  All rights reserved.
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

   TYPE VC2_1_ARR    IS TABLE OF VARCHAR2(1)  INDEX BY BINARY_INTEGER;
   TYPE VC2_255_ARR  IS TABLE OF VARCHAR2(255)  INDEX BY BINARY_INTEGER;
   TYPE VC2_4K_ARR   IS TABLE OF VARCHAR2(4000)  INDEX BY BINARY_INTEGER;
   TYPE NUM10_ARR    IS TABLE OF NUMBER(10)  INDEX BY BINARY_INTEGER;
   TYPE NUM_ARR      IS TABLE OF NUMBER  INDEX BY BINARY_INTEGER;
   void_str1         VARCHAR2(100) := ' (' || '''' || ' " ` ~ < > [ ] { } / + & = % # ! ' || '|' || ' ?) ';
   void_str2         VARCHAR2(100) := ' (' || '''' || ' " ` ~ < > [ ] { } / + & = % # ! ' || '|' || ' ?) ';

   FUNCTION ServerPath RETURN VARCHAR2;

   FUNCTION StylePath RETURN VARCHAR2;

   FUNCTION ImagePath RETURN VARCHAR2;

   FUNCTION JSPath RETURN VARCHAR2;

   FUNCTION DHTMLXPath RETURN VARCHAR2;

   FUNCTION MainCSS RETURN VARCHAR2;

   FUNCTION DefaultDateFormat RETURN VARCHAR2;

   FUNCTION ClientLogo RETURN VARCHAR2;

   FUNCTION ClientName RETURN VARCHAR2;

END ebb_lib;
/
SHOW ERRORS
