SET SCAN OFF
CREATE OR REPLACE 
PROCEDURE ebb_groups_json (
                              p_group_name      IN NUMBER default NULL,
                              p_group_desc      IN VARCHAR2 default NULL,
                              p_rows            IN NUMBER default NULL,
                              p_page_no         IN NUMBER default 1,
                              p_rt              IN VARCHAR2 default NULL
                           ) IS
/*
========================================================================
*
* Copyright (c) 2014 ZettaSolution, Inc.  All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification is strictly prohibited.
*
========================================================================
*/
/* Modification History
   Date       By    History
   ---------  ----  ---------------------------------------------------------------------
   07-NOV-14  GT    New
*/
--DECLARATION SECTION
l_select                     VARCHAR2(3000);
l_from                       VARCHAR2(1000);
l_where                      VARCHAR2(4000);
l_sql                        VARCHAR2(8000);
l_sql_count                  VARCHAR2(3000);
l_json                       VARCHAR2(8000);
l_chkdel                     VARCHAR2(8000);
l_link                       VARCHAR2(8000);
l_date_format                VARCHAR2(20):= zsi_lib.DefaultDateFormat;
TYPE l_cur IS REF CURSOR;
l_ref          l_cur;
l_group_id                   ebb_groups.group_id%TYPE;  
l_group_name                 ebb_groups.group_name%TYPE; 
l_group_desc                 ebb_groups.group_desc%TYPE; 
l_group_level                ebb_groups.group_level%TYPE;
l_group_ws_count             NUMBER(10) := 0;
l_row_no                     NUMBER(10);
l_rows                       NUMBER(10);
l_max_rows                   NUMBER(10) := zsi_lib.MaxRowsInList;
l_row_count                  NUMBER(10) := 0;
l_total_rows                 NUMBER(10);
l_module_id                  s004_modules.module_id%TYPE := zsi_lib.GetModuleID('EBB Group_list');



BEGIN
   check_login;
   owa_util.mime_header('application/json');

   l_select := 'SELECT group_id,group_name,group_desc,group_level, group_ws_count';
   l_from   := '  FROM ebb_groups_v ';
   l_where  := ' WHERE 1=1 ';

   IF p_group_name IS NOT NULL THEN
      l_where := l_where ||' AND UPPER(group_name) LIKE '|| '''' || '%' ||  UPPER(p_group_name) || '%' || '''' || ' ';
   END IF;

   IF p_group_desc IS NOT NULL THEN
      l_where := l_where ||' AND UPPER(group_desc) LIKE '|| '''' || '%' ||  UPPER(p_group_desc) || '%' || '''' || ' ';
   END IF;

   IF p_page_no = 1 AND p_rows IS NULL THEN
   l_sql := 'SELECT COUNT(*) ' || l_from || l_where;
   OPEN l_ref FOR l_sql;
      LOOP
         FETCH l_ref INTO l_rows;
         EXIT WHEN l_ref%NOTFOUND;
      END LOOP;
   CLOSE l_ref;
   ELSE
   l_rows := p_rows;
   END IF;

   l_sql := l_select ||', row_number() OVER (ORDER BY group_id) rn ' || l_from || l_where;
   l_sql := 'SELECT * FROM ( ' || l_sql || ') ' || zsi_lib.GeneratePagingWhere(p_page_no);

   /* Get Total Rows */
   l_sql_count := 'SELECT count(*) as total_rows FROM ( SELECT  row_number() OVER (ORDER BY group_id) rn ' || l_from || l_where || ')' || zsi_lib.GeneratePagingWhere(p_page_no);
   OPEN l_ref FOR l_sql_count;
   LOOP
       FETCH l_ref INTO l_total_rows;
       EXIT WHEN l_ref%NOTFOUND;
   END LOOP;
   /*----------------*/   htp.p('{"rows":[');
   OPEN l_ref FOR l_sql;
   LOOP
      FETCH l_ref INTO l_group_id, l_group_name, l_group_desc, l_group_level, l_group_ws_count, l_row_no;
      EXIT WHEN l_ref%NOTFOUND;
      l_row_count := l_row_count + 1;
      l_link :='<a href=\"javascript:void(0)\" TITLE=\"Click here to Edit EBB Group\" onClick=\"parent.attachURL(''ebb_groups_form?p_module_id=' || l_module_id || '&p_group_id='|| l_group_id || ''',''Edit EBB Group &raquo' || l_group_id || ''', 800, 200);\">' || l_group_id ||'</a>';
      l_chkdel:='<input type=\"checkbox\" name=\"p_cb\" onclick=\"zsi.table.setCheckBox(this,' || l_group_id || ');\"> <input type=\"hidden\" name=\"p_del_c\" >';
      l_json:= '{ "id":'|| l_row_count ||', "data":["' 
                                                   || l_link          || '","'
                                                   || l_group_name    || '","'
                                                   || l_group_desc    || '","'
                                                   || l_group_level   || '","'
                                                   || l_chkdel        || '"'
         ||']}';
      IF (l_row_count != l_total_rows ) THEN
         l_json:= l_json || ',';
      END IF;

      htp.p(l_json);
END LOOP;

htp.p('], "page_no":"'|| p_page_no ||'","page_rows":"'|| l_rows ||'","row_count":"' || l_row_count || '"}');

END;
/
SHOW ERR;