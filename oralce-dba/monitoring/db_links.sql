-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/monitoring/db_links.sql
-- Author       : DR Timothy S Hall
-- Description  : Displays information on all database links.
-- Requirements : Access to the DBA views.
-- Call Syntax  : @db_links
-- Last Modified: 11/05/2007
-- -----------------------------------------------------------------------------------
SET LINESIZE 150

COLUMN db_link FORMAT A30
COLUMN host FORMAT A30

SELECT owner,
       db_link,
       username,
       host
FROM   dba_db_links
ORDER BY owner, db_link;
