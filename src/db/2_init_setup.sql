USE dice_and_die;
-- Create Ranks:
INSERT INTO ranks (name) VALUES ('stone');
INSERT INTO ranks (name) VALUES ('iron');
INSERT INTO ranks (name) VALUES ('bronze');
INSERT INTO ranks (name) VALUES ('silver');
INSERT INTO ranks (name) VALUES ('gold');
INSERT INTO ranks (name) VALUES ('platinum');
INSERT INTO ranks (name) VALUES ('diamond');


INSERT INTO users (user_id,email, password) VALUES ("I007","fake_user1@gmail.com", "FAKE_PASSWORD");
INSERT INTO users_levels (user_id, exp_points, next_level_points) VALUES ("I007", 0, 50);
INSERT INTO bank_accounts (user_id) VALUES ("I007");

INSERT INTO users (user_id,email, password) VALUES ("I008","fake_user2@gmail.com", "FAKE_PASSWORD");
INSERT INTO users_levels (user_id, exp_points, next_level_points) VALUES ("I008", 0, 50);
INSERT INTO bank_accounts (user_id) VALUES ("I008");

INSERT INTO users (user_id,email, password) VALUES ("I009","fake_user3@gmail.com", "FAKE_PASSWORD");
INSERT INTO users_levels (user_id, exp_points, next_level_points) VALUES ("I009", 0, 50);
INSERT INTO bank_accounts (user_id) VALUES ("I009");






