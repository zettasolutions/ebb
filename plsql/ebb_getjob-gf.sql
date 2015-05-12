SET SCAN OFF
CREATE OR REPLACE
PROCEDURE ebb_getjob (
   p_ws_id       IN VARCHAR2 default NULL
  ,p_rt          IN VARCHAR2 default NULL
) IS
   l_ws_id    NUMBER;

   l_job_id    NUMBER;
   l_filename  VARCHAR2(32000);
   l_action    VARCHAR2(100);
   l_job_count NUMBER;

BEGIN

     htp.p('{"code":"alert","value":false}');
END;
/
SHOW ERR;