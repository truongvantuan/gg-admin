CREATE SCHEMA IF NOT EXISTS ums;
CREATE TABLE IF NOT EXISTS ums.admin
(
    id          BIGSERIAL                     NOT NULL,
    username    TEXT,
    password    TEXT,
    email       TEXT,
    icon        TEXT,
    nick_name   TEXT,
    note        TEXT,
    create_time TIMESTAMP WITHOUT TIME ZONE   NOT NULL,
    login_time  TIMESTAMP WITHOUT TIME ZONE   NOT NULL,
    status      INT CHECK ( status IN (1, 2)) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS ums.role
(
    id          BIGSERIAL                               NOT NULL,
    name        TEXT                                    NOT NULL,
    description TEXT,
    admin_count INT                                     NOT NULL,
    create_time TIMESTAMP WITHOUT TIME ZONE             NOT NULL,
    status      INT DEFAULT 1 CHECK ( status IN (0, 1)) NOT NULL,
    sort        INT DEFAULT 0,
    PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS ums.admin_role_relation
(
    admin_id BIGINT NOT NULL REFERENCES ums.admin (id),
    role_id  BIGINT NOT NULL REFERENCES ums.role (id),
    PRIMARY KEY (admin_id, role_id)
);


DROP TABLE IF EXISTS ums.permission;
CREATE TABLE IF NOT EXISTS ums.permission
(
    id          BIGSERIAL                                NOT NULL,
    pid         BIGINT REFERENCES ums.permission (id),
    name        TEXT                           DEFAULT NULL,
    value       TEXT                           DEFAULT NULL,
    icon        TEXT                           DEFAULT NULL,
    type        INT CHECK ( type IN (0, 1, 2)) DEFAULT NULL,
    uri         TEXT                           DEFAULT NULL,
    status      INT CHECK ( status IN (0, 1) ) DEFAULT 1 NOT NULL,
    create_time TIMESTAMP                                NOT NULL,
    sort        INT                            DEFAULT NULL,
    PRIMARY KEY (id)
);


DROP TABLE IF EXISTS ums.role_permission_relation;
CREATE TABLE IF NOT EXISTS ums.role_permission_relation
(
    role_id       BIGINT REFERENCES ums.role (id),
    permission_id BIGINT REFERENCES ums.permission (id),
    PRIMARY KEY (permission_id, role_id)
);


CREATE TABLE IF NOT EXISTS ums.admin_permission_relation
(
    admin_id      BIGINT DEFAULT NULL REFERENCES ums.admin (id),
    permission_id BIGINT DEFAULT NULL REFERENCES ums.permission (id),
    type          INT    DEFAULT NULL,
    PRIMARY KEY (admin_id, permission_id)
);
