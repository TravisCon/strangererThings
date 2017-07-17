DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

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
('dead', 'you_died.jpg', 'Just in case the user dies'),
('end', 'end.jpg', 'Because we''re lazy'),
('pirateship', 'pirateship.png', 'a ship full of blood thirst pirates');

INSERT INTO choice_group(setting_id, name)
VALUES
((SELECT id FROM setting WHERE name = 'lake'), 'begin'),
((SELECT id FROM setting WHERE name = 'lake'), 'chest'),
((SELECT id FROM setting WHERE name = 'dock'), 'dock1'),
((SELECT id FROM setting WHERE name = 'underwater'), 'underwater1'),
((SELECT id FROM setting WHERE name = 'dead'), 'dead'),
((SELECT id FROM setting WHERE name = 'end'), 'end'),
((SELECT id FROM setting WHERE name = 'pirateship'), 'pirateship');

INSERT INTO consequence(trigger_group_id, description)
VALUES
((SELECT id FROM choice_group WHERE name = 'dock1'),
 'You start swimming to the shore. As you swim, chills fill your spine. You see two figures on the shore stairing at you. It''s too late to turn back now. You reach the dock and come face to face with a pair of pale twins.'),
((SELECT id FROM choice_group WHERE name = 'chest'),
 'You open the treasure chest. Inside you find some scuba gear.'),
((SELECT id FROM choice_group WHERE name = 'pirateship'),
 'You swim to the pirate ship, the odor of smelly sea dogs fills your nostrils. Despite your fears, you climb abord. The pirates are actually very friendly. The most offensive thing about them was their body odor.'),
((SELECT id FROM choice_group WHERE name = 'begin'),
 'You wake up on a raft in the middle of nowhere. Off in the distance you see a large pirateship to your left. Nearby you see a treasure chest. On your right you see a shoreline with a wooden dock.'),
((SELECT id FROM choice_group WHERE name = 'end'),
 'The smelly group of pirates escorts you to their captain. You approach a well-mannered bloke dressed in khakis. He turns around. He introduces himself as Captain Burton, the notorious websurfer of ancient legends. He wants you to usurp him as Captain of the ship. You life happily ever after as a Captain of a pirate ship which you name the Squanchy. Also, he gives you 400 points for your final project.'),
((SELECT id FROM choice_group WHERE name = 'dead'),
 'You jump the plank, and drown an ignominious death. However, in heaven you are compensated with 400 points on your final project in CS313'),
((SELECT id FROM choice_group WHERE name = 'underwater1'),
 'You put on the scuba gear and dive. You swim deeper and deeper. The algae and plants seem to clear away for you. You sink deeper until you find an underwater cavern filled with flora and fauna that seems out of this world. You look up and see a light above the water. It''s different than the sunlight, but still radiates light.'),
 ((SELECT id FROM choice_group WHERE name = 'end'),
 'You swim up to a ethereal cavern. You emerge in an underwater airpocket. The light came from a glowing underwater city. You''ve found the lost city of Atlantis. You are hailed as the new king of Atlantis. They reward you with sushi and full credit on your final web engineering project.'),
 ((SELECT id FROM choice_group WHERE name = 'dead'),
 'Just as the water closes in around you, the hopelessness of finals overcomes your body. You are overwhelmed by the pressure of the project and die.'),
((SELECT id FROM choice_group WHERE name = 'end'),
 'They explain through socially awkward conversation that they are software engineers, and are experts in programming. That would explain the pasty white skin. They have a study session on the dock and help you finish your final project. You get full credit on your final project and exam.'),
 ((SELECT id FROM choice_group WHERE name = 'dead'),
 'They quickly tear you apart. They take turns beating you up. They leave you on the dock battered and bruised. It turns out they prefer Linux, and everything else is heresy.');

INSERT INTO choice(group_id, consequence_id, description)
VALUES
((SELECT id FROM choice_group WHERE name='begin'), 1, 'Swim to shore'),
((SELECT id FROM choice_group WHERE name='begin'), 2, 'Swim to treasure chest'),
((SELECT id FROM choice_group WHERE name='begin'), 3, 'Swim to pirate ship'),
((SELECT id FROM choice_group WHERE name='dead'), 4, 'Restart'),
((SELECT id FROM choice_group WHERE name='end'), 4, 'Restart'),
((SELECT id FROM choice_group WHERE name='pirateship'), 5, 'Ask to meet the captain of the ship'),
((SELECT id FROM choice_group WHERE name='pirateship'), 6, 'Save your nose, walk the plank'),
((SELECT id FROM choice_group WHERE name='chest'), 7, 'Put the scuba gear on, and dive'),
((SELECT id FROM choice_group WHERE name='underwater1'), 8, 'Swim towards the light'),
((SELECT id FROM choice_group WHERE name='underwater1'), 9, 'Try to get an A on the final project'),
((SELECT id FROM choice_group WHERE name='dock1'), 10, 'Ask them "How do I get an A of this final?"'),
((SELECT id FROM choice_group WHERE name='dock1'), 11, 'Ask them whether they prefer Windows or Mac');

#DROP SCHEMA public CASCADE;
#CREATE SCHEMA public;
#cat .\adventure.sql | heroku pg:psql