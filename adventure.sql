DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE TABLE setting
(
  id         SERIAL PRIMARY KEY,
  photo_url  VARCHAR(512) NOT NULL,
  notes      TEXT
);

\d setting;

CREATE TABLE choice_group
(
  id          SERIAL PRIMARY KEY,
  setting_id   INT NOT NULL REFERENCES setting(id)
);

\d choice_group;

CREATE TABLE result
(
  id                SERIAL PRIMARY KEY,
  trigger_group_id  INT NOT NULL REFERENCES choice_group(id),
  description       TEXT
);

\d result;

CREATE TABLE choice
(
  id          SERIAL PRIMARY KEY,
  group_id    INT NOT NULL REFERENCES choice_group(id),
  result_id   INT NOT NULL REFERENCES result(id),
  description TEXT
);

\d choice;

INSERT INTO setting(photo_url, notes)
VALUES
('test.jpg', 'This is a test setting');

#cat .\recipes.sql | heroku pg:psql