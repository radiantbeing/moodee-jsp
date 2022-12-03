CREATE TABLE IF NOT EXISTS playlist(
	id int NOT NULL AUTO_INCREMENT,
	title VARCHAR(500) NOT NULL,
	description TEXT,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS song(
	videoId VARCHAR(500) NOT NULL,
	title VARCHAR(100) NOT NULL,
	artist VARCHAR(100) NOT NULL,
	thumbnailUrl VARCHAR(1000) NOT NULL,
	playlist int NOT NULL,
	PRIMARY KEY (videoId)
);

CREATE TABLE IF NOT EXISTS post(
	date TIMESTAMP NOT NULL,
	videoId VARCHAR(500),
	songTitle VARCHAR(100),
	artist VARCHAR(100),
	article TEXT,
	PRIMARY KEY (date)
);
