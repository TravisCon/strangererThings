CREATE TABLE setting
(
  id         SERIAL PRIMARY KEY,
  name       VARCHAR(128) NOT NULL,
  photo_url  VARCHAR(512) NOT NULL,
  notes      TEXT
);

CREATE TABLE choice_group
(
  id          SERIAL PRIMARY KEY,
  setting_id  INT NOT NULL REFERENCES setting(id),
  name        VARCHAR(128)
);

CREATE TABLE result
(
  id                SERIAL PRIMARY KEY,
  trigger_group_id  INT NOT NULL REFERENCES choice_group(id),
  description       TEXT
);

CREATE TABLE choice
(
  id          SERIAL PRIMARY KEY,
  group_id    INT NOT NULL REFERENCES choice_group(id),
  result_id   INT NOT NULL REFERENCES result(id),
  description TEXT
);

INSERT INTO setting(name, photo_url, notes)
VALUES
('lake', 'lake1.jpg', 'Beginning spot'),
('dock', 'dock1.jpg', 'When the user chooses to swim'),
('underwater', 'underwater_cave.jpg', "User opens chest with scuba gear"),
('dead', 'you_died.jpg', 'Just in case the user dies');

INSERT INTO choice_group(setting_id, name)
VALUES
((SELECT id FROM setting WHERE name = 'lake'), 'begin'),
((SELECT id FROM setting WHERE name = 'lake'), 'chest'),
((SELECT id FROM setting WHERE name = 'dock'), 'dock1'),
((SELECT id FROM setting WHERE name = 'underwater'), 'underwater1'),
((SELECT id FROM setting WHERE name = 'dead'), 'dead');



INSERT INTO choice(group_id, result_id, description)
VALUES
(1, 1, "Pickup Sticks");
#DROP SCHEMA public CASCADE;
#CREATE SCHEMA public;
#cat .\recipes.sql | heroku pg:psql