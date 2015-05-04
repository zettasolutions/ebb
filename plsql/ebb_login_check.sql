SET SCAN OFF
CREATE OR REPLACE
PROCEDURE ebb_login_check (p_username  IN  VARCHAR2  DEFAULT NULL,
                           p_password  IN  VARCHAR2  DEFAULT NULL,
                           p_url       IN  VARCHAR2  DEFAULT NULL) AS
/*
========================================================================
*
* Copyright (c) 2014-2015 ZettaSolution, Inc.  All rights reserved.
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

   --DECLARATION SECTION
   l_style_path                 VARCHAR2(100) := zsi_lib.StylePath;
   l_image_path                 VARCHAR2(100) := zsi_lib.ImagePath;
   l_js_path                    VARCHAR2(100) := zsi_lib.JSPath;

   val_error                    BOOLEAN := FALSE;
   l_err_msg                    VARCHAR2(255);

   l_logon                      ebb_users.logon%TYPE;
   l_active                     ebb_users.active%TYPE;

   l_validuser                  VARCHAR2(1) := 'N';
   l_session                    VARCHAR2(100);
   l_terminal                   VARCHAR2(100);
   l_ip                         VARCHAR2(100);

   l_session_id                 NUMBER;
BEGIN
   IF TRIM(p_username) IS NULL THEN
      val_error := TRUE;
      l_err_msg := 'Username is Required';
   END IF;

   IF TRIM(p_password) IS NULL THEN
      val_error := TRUE;
      l_err_msg := l_err_msg || '<br><br>' || 'Password is Required';
   END IF;

   IF val_error THEN
      pageheader;
      htp.p('<body>
             <h4>enterProj - Login</h4>
             <b class="error">' || l_err_msg || '</b>
             <p>
             <b class="error">Unable to Login</b>
             <br>
             <br>
             <a href="javascript:history.back()">Click here to Login again</a>
             </body>
             </html>');
      RETURN;
   END IF;

   l_logon := UPPER(TRIM(p_username));

   BEGIN
      SELECT 'Y', active
        INTO l_validuser, l_active
        FROM ebb_users
       WHERE UPPER(logon) = l_logon
         AND pwd          = ORA_HASH(TRIM(p_password));
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
           l_validuser := 'N';
   END;

   IF l_validuser = 'Y' AND l_active = 'N' THEN   /* Inactive User */
      htp.p('<script type="text/javascript">
                alert(''Your Login is Inactive; Please contact the Administrator'');
                window.top.location.hreff=''ebb_login'';
             </script>');
      RETURN;
   END IF;

   IF l_validuser = 'Y' THEN   /* Valid User */

      ebb_sessions_lib.SetCookieUser (l_logon);

      IF p_url IS NOT NULL THEN
         htp.p('<script type="text/javascript">
                   window.top.location.href=' || '''' || utl_url.unescape(p_url) || '''' || ';
                </script>');
         RETURN;
      END IF;

      htp.p('<script type="text/javascript">
                window.location.href="ebb_home";
             </script>');
   ELSE

      htp.p('<script type="text/javascript">
                alert("Invalid Username/Password; Please try again");
                window.top.location.href="ebb_login?p_url=' || p_url || '";
             </script>');

   END IF;
END;
/
SHOW ERRORS
