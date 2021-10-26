SELECT id, username, admin_id, role_id
FROM ums.admin
         JOIN ums.admin_role_relation
              ON ums.admin.id = ums.admin_role_relation.admin_id;

SELECT *
FROM ums.admin;


SELECT P.*
FROM ums.admin_role_relation ar
         LEFT JOIN ums.role r ON ar.role_id = r.ID
         LEFT JOIN ums.role_permission_relation rp ON r.ID = rp.role_id
         LEFT JOIN ums.permission P ON rp.permission_id = P.ID
WHERE ar.admin_id = 1
  AND P.ID IS NOT NULL
  AND P.ID NOT IN (
    SELECT P.ID
    FROM ums.admin_permission_relation pr
             LEFT JOIN ums.permission P ON pr.permission_id = P.ID
    WHERE pr.TYPE = - 1
      AND pr.admin_id = 1
)
UNION
SELECT P.*
FROM ums.admin_permission_relation pr
         LEFT JOIN ums.permission P ON pr.permission_id = P.ID
WHERE pr.TYPE = 1
  AND pr.admin_id = 1;


CREATE OR REPLACE FUNCTION get_permission(1 INT)
    RETURNS TABLE
(
    name  TEXT,
    value TEXT
)
LANGUAGE plpgsql
AS
$$
DECLARE
-- variable declaration
--     a INT;

BEGIN
    -- logic

    SELECT P.*
    FROM ums.admin_role_relation ar
             LEFT JOIN ums.role r ON ar.role_id = r.ID
             LEFT JOIN ums.role_permission_relation rp ON r.ID = rp.role_id
             LEFT JOIN ums.permission P ON rp.permission_id = P.ID
    WHERE ar.admin_id = 1
      AND P.ID IS NOT NULL
      AND P.ID NOT IN (
        SELECT P.ID
        FROM ums.admin_permission_relation pr
                 LEFT JOIN ums.permission P ON pr.permission_id = P.ID
        WHERE pr.TYPE = - 1
          AND pr.admin_id = 1
    )
    UNION
    SELECT P.*
    FROM ums.admin_permission_relation pr
             LEFT JOIN ums.permission P ON pr.permission_id = P.ID
    WHERE pr.TYPE = 1
      AND pr.admin_id = 1;

END;
$$



CREATE OR REPLACE FUNCTION get_admin()
    RETURNS TABLE
            (
                username TEXT,
                password TEXT
            )
    LANGUAGE plpgsql
AS
$$
DECLARE
-- variable declaration
--     a INT;

BEGIN
    -- logic
    SELECT * FROM ums.admin;

END;
$$



