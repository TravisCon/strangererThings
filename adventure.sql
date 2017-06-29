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
  id                SERIAL PRIMARY KEY,
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
 'Once again, you died');

INSERT INTO choice(group_id, consequence_id, description)
VALUES
((SELECT id FROM choice_group WHERE name='begin'), 1, 'Swim to shore'),
((SELECT id FROM choice_group WHERE name='begin'), 2, 'Swim to treasure chest'),
((SELECT id FROM choice_group WHERE name='begin'), 3, 'Swim to pirate ship');

SELECT c1.description, c2.description, c2.consequence_id FROM consequence c1 
  JOIN choice_group cg  ON cg.id = c1.trigger_group_id
  JOIN choice c2        ON cg.id = c2.group_id
  #JOIN setting s        ON s.id = cg.setting_id
  #WHERE c1.id = (SELECT consequence_id FROM choice WHERE #description = 'Swim to treasure chest');
  #s.photo_url,

#DROP SCHEMA public CASCADE;
#CREATE SCHEMA public;
#cat .\recipes.sql | heroku pg:psql
#select * from consequence c1 join choice c2 on (c1.id = c2.consequence_id) WHERE c2.group_id = 1;