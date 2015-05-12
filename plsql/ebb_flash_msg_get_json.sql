SET SCAN OFF
CREATE OR REPLACE 
PROCEDURE ebb_flash_msg_get_json 
(
  p_ws_id         IN NUMBER default NULL,
  p_rt           IN VARCHAR2 default NULL
) 

IS 
   l_select                     VARCHAR2(2000);
   l_from                       VARCHAR2(1000);
   l_where                      VARCHAR2(2000);
   l_sql                        VARCHAR2(8000);
   l_json                       VARCHAR2(8000):='';
   l_sql_count                  VARCHAR2(8000);   
   l_total_rows                 NUMBER(10); 
   
   TYPE l_cur IS REF CURSOR;
   l_ref          l_cur;
   
   
   l_row_no                     NUMBER(10);
   l_rows                       NUMBER(10);
   l_max_rows                   NUMBER(10) := zsi_lib.MaxRowsInList;
   l_row_count                  NUMBER(10) := 0;
   l_dhtmlx_sort                VARCHAR2(1024);
   l_dhtmlx_filter              VARCHAR2(4096);
   


BEGIN
   owa_util.mime_header('application/json'); 

   htp.p('{"value":"You can use all Bootstrap plugins purely through the markup API without writing a single line of JavaScript. This is Bootstrap''s first-class API and should be your first consideration when using a plugin"}'); 

END;
/
SHOW ERR;


 