SET SCAN OFF
CREATE OR REPLACE
PROCEDURE ebb_job_doc_download (p_job_id IN NUMBER,
                                p_type   IN  VARCHAR2) AS
   /*
   ========================================================================
   *
   * Copyright (c) 2014 ZettaSolution, Inc.  All rights reserved.
   *
   * Redistribution and use in source and binary forms, with or without
   * modification is strictly prohibited.
   *
   ========================================================================
   Modification History
   Date       By    History
   ---------  ----  -------------------------------------------------------
   03-MAY-15  BD    New.
  */

   l_name                ebb_docs.name%TYPE;
   l_mime_type           ebb_docs.mime_type%TYPE;
   l_blob_content        ebb_docs.blob_content%TYPE;
   l_length              ebb_docs.doc_size%TYPE;
   l_sql                 VARCHAR2(1024);
   doc_cur               SYS_REFCURSOR;
BEGIN

   BEGIN

      IF p_job_id IS NOT NULL AND p_type IS NOT NULL THEN

         IF p_type = 'D' THEN -- Document
            l_sql := 'SELECT b.mime_type, b.blob_content, b.name, b.doc_size '
                  || ' FROM ebb_jobs a, ebb_docs b '
                  || ' WHERE a.doc_filename = b.name  '
                  || '   AND a.job_id = ' || p_job_id;
         ELSIF p_type = 'T' THEN -- Thumbnail
            l_sql := 'SELECT b.mime_type, b.blob_content, b.name, b.doc_size '
                  || ' FROM ebb_jobs a, ebb_docs b '
                  || ' WHERE a.thumb_filename = b.name  '
                  || '   AND a.job_id = ' || p_job_id;
         END IF;

         OPEN doc_cur FOR l_sql;
         FETCH doc_cur INTO l_mime_type, l_blob_content, l_name, l_length;
         CLOSE doc_cur;

         /* Set up HTTP Header */
         owa_util.mime_header(NVL(l_mime_type, 'application/octet'), FALSE);

         /* Set the size to indicate the browser how much to download */
         htp.p('Content-length: ' || l_length);

         /* The filename will be used by the browser if the users does a "Save As" */
         htp.p('Content-Type: ' || l_mime_type);
   --    htp.p('Content-Type: application/download');
         htp.p('Content-Disposition: filename="' || zsi_lib.GetBaseName(l_name) || '"');

         /* Close the Headers */
         owa_util.http_header_close;

         /* Download the BLOB content */
         wpg_docload.download_file(l_blob_content);

      END IF;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         htp.bold('Unable to find any document for this filename ' || zsi_lib.GetBaseName(l_name) || '. Please contact the Administrator');
         RETURN;
   END;
END;
/
SHOW ERRORS