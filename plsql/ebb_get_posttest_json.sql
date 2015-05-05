SET SCAN OFF
CREATE OR REPLACE 
PROCEDURE ebb_get_posttest_json 
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

/*
0:image
1:title
2:isPriority
*/

   htp.p('{"rows":['); 
      htp.p(' {"row":["/apps/ebb/images/data/post6.jpg","When future programmers read...",true] }');
      htp.p(',{"row":["/apps/ebb/images/data/post7.jpg","Well if anyone comes along...",true] }');
      htp.p(',{"row":["/apps/ebb/images/data/post8.jpg","Use data attributes to easily control...",true] }');
      htp.p(',{"row":["/apps/ebb/images/data/post9.jpg","Cycles through the carousel...",true] }');
      htp.p(',{"row":["/apps/ebb/images/data/post10.jpg","Actual event namespace for slide...",true] }');
      htp.p(',{"row":["/apps/ebb/images/data/post1.jpg","It is even more compressed, and if expanded...",false] }');
      htp.p(',{"row":["/apps/ebb/images/data/post2.jpg","It is been clearly put, although opinion none the less...",false] }');
      htp.p(',{"row":["/apps/ebb/images/data/post3.jpg","The way you can used in pl/sql...",false] }');
      htp.p(',{"row":["/apps/ebb/images/data/post4.jpg","Omitting braces harms readability.",false] }');
      htp.p(',{"row":["/apps/ebb/images/data/post5.jpg","It is not commonly used in cases...",false] }');

   htp.p('], "page_no":"'|| p_page_no ||'","page_rows":"'|| l_rows ||'","row_count":"' || l_row_count || '"}');

END;
/
SHOW ERR;


 