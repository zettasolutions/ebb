SET SCAN OFF
CREATE OR REPLACE 
PROCEDURE ebb_get_post_json 
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
2:description
3:isPriority
*/

   htp.p('{"rows":['); 
      htp.p(' {"row":["/apps/ebb/images/data/post6.jpg","When future programmers read the codes.","Fusce hendrerit est quis mauris sodales tincidunt. Morbi neque arcu, auctor ac tellus nec, tempor egestas enim. Duis dapibus, velit non posuere pretium, nibh mi blandit ex, non cursus ipsum nisl pellentesque odio. Sed eleifend mi et urna euismod pellentesque. Phasellus non libero quam",true] }');
      htp.p(',{"row":["/apps/ebb/images/data/post7.jpg","Well if anyone comes along","Mauris vel est vel nisl tincidunt tristique non eu tellus. Etiam consequat tincidunt lacinia. Quisque convallis lorem a faucibus ultricies. Mauris vitae dictum eros. Phasellus sollicitudin dui sed feugiat egestas. Vivamus fringilla a felis in finibus. Aliquam bibendum neque id magna rutrum. ",true] }');
      htp.p(',{"row":["/apps/ebb/images/data/post8.jpg","Use data attributes to easily control","Proin sit amet erat consequat, dapibus felis eu, fermentum neque. Vestibulum auctor nec nulla vitae molestie. Curabitur non ipsum condimentum, tristique arcu a, ullamcorper nisi. Nunc suscipit felis dolor, at vulputate urna aliquet sit amet. Nullam finibus libero a enim mollis, et tempus libero dictum.",true] }');
      htp.p(',{"row":["/apps/ebb/images/data/post9.jpg","Cycles through the carousel","Ut laoreet, elit nec tincidunt fringilla, nunc mi varius felis, quis dignissim justo quam in purus. Cras eu libero eu purus lobortis venenatis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Suspendisse aliquet purus in lacus venenatis lacinia",true] }');
      htp.p(',{"row":["/apps/ebb/images/data/post10.jpg","Actual event namespace for slide","Cras nec ligula eu tellus mollis eleifend. Suspendisse et posuere dui. Aenean vehicula gravida turpis non euismod. Sed risus erat, auctor laoreet tellus vitae, tempus facilisis purus. Vivamus ut tortor eget neque molestie euismod. Nunc et ligula non risus hendrerit dictum eleifend sed magna. Aliquam erat volutpat",true] }');
      htp.p(',{"row":["/apps/ebb/images/data/post1.jpg","It is even more compressed, and if expanded","Ut dapibus eu urna ac condimentum. In vestibulum, odio nec cursus vulputate, sapien justo consectetur felis, non cursus augue risus quis nisl. Proin blandit tellus dui, sit amet posuere orci dapibus ac.",false] }');
      htp.p(',{"row":["/apps/ebb/images/data/post2.jpg","It is been clearly put, although opinion none the less","Duis ut nisi diam. Quisque congue, nisl eu consequat consectetur, mauris sapien rutrum erat, dignissim egestas tellus nunc eget neque. Fusce in mattis purus. Nunc volutpat magna ac ex semper, sit amet feugiat nibh elementum. ",false] }');
      htp.p(',{"row":["/apps/ebb/images/data/post3.jpg","The way you can used in pl/sql","Phasellus sit amet risus et ex placerat pharetra non sit amet enim. Nam vel consequat arcu. Maecenas sodales sapien non tortor congue, semper venenatis tellus aliquam. Nunc sit amet bibendum leo. Morbi augue eros, fermentum id tortor non, tincidunt suscipit urna. Proin egestas mi sit amet elit finibus ornare non sit amet nunc. ",false] }');
      htp.p(',{"row":["/apps/ebb/images/data/post4.jpg","Omitting braces harms readability.","Vestibulum auctor nec nulla vitae molestie. Curabitur non ipsum condimentum, tristique arcu a, ullamcorper nisi. Nunc suscipit felis dolor, at vulputate urna aliquet sit amet. Nullam finibus libero a enim mollis, et tempus libero dictum. ",false] }');
      htp.p(',{"row":["/apps/ebb/images/data/post5.jpg","It is not commonly used in cases","Morbi neque arcu, auctor ac tellus nec, tempor egestas enim. Duis dapibus, velit non posuere pretium, nibh mi blandit ex, non cursus ipsum nisl pellentesque odio. Sed eleifend mi et urna euismod pellentesque. Phasellus non libero quam. Mauris vel est vel nisl tincidunt tristique non eu tellus.",false] }');

   htp.p('], "page_no":"'|| p_page_no ||'","page_rows":"'|| l_rows ||'","row_count":"' || l_row_count || '"}');

END;
/
SHOW ERR;


 