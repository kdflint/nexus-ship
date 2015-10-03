-- Database

-- first, double check no video tether values in event.type. Then:

UPDATE pg_enum e SET enumlabel = 'video link' WHERE enumlabel = 'video tether';

-- Query returned successfully: one row affected, 41 ms execution time.

-- Other

-- 1. move room config files to config folder