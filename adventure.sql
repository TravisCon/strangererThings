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
('pirateship','pirateship.png','a ship full of blood thirst pirates');

INSERT INTO choice_group(setting_id, name)
VALUES
((SELECT id FROM setting WHERE name = 'lake'), 'begin'),
((SELECT id FROM setting WHERE name = 'lake'), 'chest'),
((SELECT id FROM setting WHERE name = 'dock'), 'dock1'),
((SELECT id FROM setting WHERE name = 'underwater'), 'underwater1'),
((SELECT id FROM setting WHERE name = 'dead'), 'dead'),
((SELECT id FROM setting WHERE name = 'pirateship'), 'pirateship');

INSERT INTO consequence(trigger_group_id, description)
VALUES
((SELECT id FROM choice_group WHERE name = 'dock1'),
 'You start swimming to the shore. As you swim, chills fill your spine. You see two figures on the shore stairing at you. It''s too late to turn back now.'),
((SELECT id FROM choice_group WHERE name = 'chest'),
 'You open the treasure chest. Inside you find some scuba gear.'),
((SELECT id FROM choice_group WHERE name = 'pirateship'),
 'You swim to the pirate ship, the odor of smelly sea dogs fills your nostrils. Despite your fears, you climb abord.'),
 ((SELECT id FROM choice_group WHERE name = 'begin'),
  'You wake up on a raft in the middle of nowhere');

INSERT INTO choice(group_id, consequence_id, description)
VALUES
((1), )
((SELECT id FROM choice_group WHERE name='begin'), 1, 'Swim to shore'),
((SELECT id FROM choice_group WHERE name='begin'), 2, 'Swim to treasure chest'),
((SELECT id FROM choice_group WHERE name='begin'), 3, 'Swim to pirate ship'),
((SELECT id FROM choice_group WHERE name='dead'), 4, 'Restart');

#DROP SCHEMA public CASCADE;
#CREATE SCHEMA public;
#cat .\adventure.sql | heroku pg:psql