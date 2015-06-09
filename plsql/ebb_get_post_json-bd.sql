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
   l_priority_ctr               NUMBER(2) := 0;
   l_bydate_ctr                 NUMBER(3) := 0;
   l_comma                      VARCHAR2(1);

   CURSOR ebb_jobs_priority_cur IS
      SELECT *
        FROM ebb_jobs
       WHERE doc_filename is not null
       ORDER BY priority_no ASC;

   CURSOR ebb_jobs_bydate_cur IS
      SELECT *
        FROM ebb_jobs
       WHERE doc_filename is not null
       ORDER BY approved_date DESC;

BEGIN
   owa_util.mime_header('application/json');

/*
0:image
1:title
2:description
3:isPriority
*/

   htp.p('{"rows":[');
      FOR i IN ebb_jobs_priority_cur LOOP
         l_row_count := l_row_count + 1;
         htp.p(l_comma || ' {"row":["ebb_job_doc_download?p_type=D&p_job_id=' || i.job_id  || '","'  || i.title || '",true] }');
         l_comma := ',';
      END LOOP;
      FOR i IN ebb_jobs_bydate_cur LOOP
         l_row_count := l_row_count + 1;
         --htp.p(l_comma || ' {"row":["ebb_job_doc_download?p_type=D&p_job_id=' || i.job_id  || '","'  || i.title || '",false] }');
         htp.p(l_comma || '{"row":["ebb_job_doc_download?p_type=D&p_job_id=' || i.job_id  || '","'  || i.title || '",false] }');
         l_comma := ',';
      END LOOP;

   htp.p('], "page_no":"'|| p_page_no ||'","page_rows":"'|| l_rows ||'","row_count":"' || l_row_count || '"}');

END;
/
SHOW ERR;


