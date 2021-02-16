# PostgreSQL locks analyze
Current locks
```SQL
select
  lock.locktype,
  lock.relation::regclass,
  lock.mode,
  lock.transactionid as tid,
  lock.virtualtransaction as vtid,
  lock.pid,
  lock.granted
from pg_catalog.pg_locks lock
  left join pg_catalog.pg_database db
    on db.oid = lock.database
where (db.datname = current_database() or db.datname is null)
  and not lock.pid = pg_backend_pid()
order by lock.pid;
```

Current queries
```SQL
select *
from pg_stat_activity
where datname = current_database()
  and not (state = 'idle' or pid = pg_backend_pid());
```

Queries duration
```SQL
select pid, wait_event, wait_event_type, query, now() - query_start as waiting_duration
from pg_catalog.pg_stat_activity
where datname = current_database()
  and  pid <> pg_backend_pid();
```

Who blocks whom
```SQL	    
select
  coalesce(bgl.relation::regclass::text, bgl.locktype) as locked_item,
  now() - bda.query_start as waiting_duration,
  bda.pid as blocked_pid,
  bda.query as blocked_query,
  bdl.mode as blocked_mode,
  bga.pid as blocking_pid,
  bga.query as blocking_query,
  bgl.mode as blocking_mode
from pg_catalog.pg_locks bdl
  join pg_stat_activity bda
    on bda.pid = bdl.pid
  join pg_catalog.pg_locks bgl
    on bgl.pid != bdl.pid
    and (bgl.transactionid = bdl.transactionid
      or bgl.relation = bdl.relation and bgl.locktype = bdl.locktype)
  join pg_stat_activity bga
    on bga.pid = bgl.pid
    and bga.datid = bda.datid
where not bdl.granted
  and bga.datname = current_database();
```  