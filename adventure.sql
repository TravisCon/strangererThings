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

CREATE TABLE consequence
(
  id          SERIAL PRIMARY KEY,
  trigger_group_id  INT NOT NULL REFERENCES choice_group(id),
  description       TEXT
);

CREATE TABLE choice
(
  id          SERIAL PRIMARY KEY,
  group_id    INT NOT NULL REFERENCES choice_group(id),
  consequence_id   INT NOT NULL REFERENCES consequence(id),
  description TEXT
);

INSERT INTO setting(name, photo_url, notes)
VALUES
('lake', 'lake1.jpg', 'Beginning spot'),
('dock', 'dock1.jpg', 'When the user chooses to swim'),
('underwater', 'underwater_cave.jpg', 'User opens chest with scuba gear'),
('dead', 'you_died.jpg', 'Just in case the user dies');

INSERT INTO choice_group(setting_id, name)
VALUES
((SELECT id FROM setting WHERE name = 'lake'), 'begin'),
((SELECT id FROM setting WHERE name = 'lake'), 'chest'),
((SELECT id FROM setting WHERE name = 'dock'), 'dock1'),
((SELECT id FROM setting WHERE name = 'underwater'), 'underwater1'),
((SELECT id FROM setting WHERE name = 'dead'), 'dead');

INSERT INTO consequence(trigger_group_id, description)
VALUES
((SELECT id FROM choice_group WHERE name = 'dead'),
 'You have died! Sorry'),
((SELECT id FROM choice_group WHERE name = 'dead'),
 'You have still died! Sorry'),
((SELECT id FROM choice_group WHERE name = 'dead'),
 'Once again, you died'),
 ((SELECT id FROM choice_group WHERE name = 'begin'),
  'You wake up on a raft in the middle of nowhere');

INSERT INTO choice(group_id, consequence_id, description)
VALUES
((1), )
((SELECT id FROM choice_group WHERE name='begin'), 1, 'Swim to shore'),
((SELECT id FROM choice_group WHERE name='begin'), 2, 'Swim to treasure chest'),
((SELECT id FROM choice_group WHERE name='begin'), 3, 'Swim to pirate ship'),
((SELECT id FROM choice_group WHERE name='dead'), 4, 'Restart');

SELECT s.photo_url, c1.description as group_description, c2.description as consequence_description, c2.consequence_id, c2.id as choice_id
  FROM consequence c1 
  JOIN choice_group cg  ON cg.id = c1.trigger_group_id
  JOIN choice c2        ON cg.id = c2.group_id
  JOIN setting s        ON s.id = cg.setting_id
  WHERE c1.id = something

#DROP SCHEMA public CASCADE;
#CREATE SCHEMA public;
#cat .\adventure.sql | heroku pg:psql