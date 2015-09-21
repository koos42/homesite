CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255) DEFAULT '' NOT NULL, "encrypted_password" varchar(128) DEFAULT '' NOT NULL, "reset_password_token" varchar(255), "remember_token" varchar(255), "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "created_at" datetime, "updated_at" datetime, "username" varchar(255), "is_author" boolean);
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE TABLE "comics" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "date" date, "publish" boolean, "blurb" text, "created_at" datetime, "updated_at" datetime, "photo_file_name" varchar(255), "photo_content_type" varchar(255), "photo_file_size" integer, "thumbnail_file_name" varchar(255), "thumbnail_content_type" varchar(255), "thumbnail_file_size" integer, "slug" varchar(255));
CREATE TABLE "goodies" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "desc" varchar(255), "created_at" datetime, "updated_at" datetime, "goody_file_file_name" varchar(255), "goody_file_file_size" integer, "goody_file_content_type" varchar(255));
CREATE UNIQUE INDEX "index_comics_on_slug" ON "comics" ("slug");
CREATE TABLE "tags" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "tag" varchar(255));
CREATE TABLE "comic_tags" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "comic_id" integer, "tag_id" integer);
INSERT INTO schema_migrations (version) VALUES ('20110313232002');

INSERT INTO schema_migrations (version) VALUES ('20110313232503');

INSERT INTO schema_migrations (version) VALUES ('20110314032634');

INSERT INTO schema_migrations (version) VALUES ('20110315200919');

INSERT INTO schema_migrations (version) VALUES ('20110315213909');

INSERT INTO schema_migrations (version) VALUES ('20110410170840');

INSERT INTO schema_migrations (version) VALUES ('20110410181652');

INSERT INTO schema_migrations (version) VALUES ('20120331205443');

INSERT INTO schema_migrations (version) VALUES ('20120725235433');

INSERT INTO schema_migrations (version) VALUES ('20120726001342');

INSERT INTO schema_migrations (version) VALUES ('20121006211341');

INSERT INTO schema_migrations (version) VALUES ('20150908224446');