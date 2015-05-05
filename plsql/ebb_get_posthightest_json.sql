SET SCAN OFF
CREATE OR REPLACE 
PROCEDURE ebb_get_posthightest_json 
(
  p_rows         IN NUMBER default NULL,
  p_page_no      IN NUMBER default 1,
  p_rt                 IN VARCHAR2 default NULL
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

   htp.p('{"rows":['); 
      htp.p(' {"row":["/apps/ebb/images/data/post1.jpg","High Priority #1"] }');
      htp.p(',{"row":["/apps/ebb/images/data/post2.jpg","High Priority #2"] }');
      htp.p(',{"row":["/apps/ebb/images/data/post3.jpg","High Priority #3"] }');
      htp.p(',{"row":["/apps/ebb/images/data/post4.jpg","High Priority #4"] }');
      htp.p(',{"row":["/apps/ebb/images/data/post5.jpg","High Priority #5"] }');

   htp.p('], "page_no":"'|| p_page_no ||'","page_rows":"'|| l_rows ||'","row_count":"' || l_row_count || '"}');

END;
/
SHOW ERR;


 