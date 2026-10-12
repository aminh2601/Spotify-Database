CREATE DATABASE IF NOT EXISTS spotify;
USE spotify;

-- 1. Artists
CREATE TABLE `artists` (
    `artist_id` INT UNSIGNED AUTO_INCREMENT,
    `artist_name` VARCHAR(200) NOT NULL,
    `ranking` INT UNSIGNED NOT NULL,
    `monthly_listeners` INT UNSIGNED NOT NULL DEFAULT 0,
    `total_stream` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `total_followers` INT UNSIGNED NOT NULL DEFAULT 0,

    PRIMARY KEY (`artist_id`)
);

-- 2. Albums
CREATE TABLE `albums` (
    `album_id` INT UNSIGNED AUTO_INCREMENT,
    `album_name` VARCHAR(200) NOT NULL,
    `release_date` DATE NOT NULL,
    `total_stream` BIGINT UNSIGNED NOT NULL DEFAULT 0,

    PRIMARY KEY (`album_id`)
);

-- 3. Songs
-- album_id can be NULL for songs without an album.
CREATE TABLE `songs` (
    `song_id` INT UNSIGNED AUTO_INCREMENT,
    `album_id` INT UNSIGNED,
    `song_name` VARCHAR(200) NOT NULL,
    `genre` VARCHAR(200) NOT NULL,
    `release_date` DATE NOT NULL,
    `total_stream` BIGINT UNSIGNED NOT NULL DEFAULT 0,

    PRIMARY KEY (`song_id`),

    FOREIGN KEY (`album_id`)
        REFERENCES `albums` (`album_id`)
        ON DELETE SET NULL
);

-- 4. Connect songs with their artists.
CREATE TABLE `song_artists` (
    `song_id` INT UNSIGNED NOT NULL,
    `artist_id` INT UNSIGNED NOT NULL,

    PRIMARY KEY (`song_id`, `artist_id`),

    FOREIGN KEY (`song_id`)
        REFERENCES `songs` (`song_id`)
        ON DELETE CASCADE,

    FOREIGN KEY (`artist_id`)
        REFERENCES `artists` (`artist_id`)
        ON DELETE CASCADE
);

-- 5. Playlists
CREATE TABLE `playlists` (
    `playlist_id` INT UNSIGNED AUTO_INCREMENT,
    `playlist_name` VARCHAR(200) NOT NULL,
    `hours_listened` DECIMAL(10, 2) NOT NULL DEFAULT 0,
    `total_saved` INT UNSIGNED NOT NULL DEFAULT 0,

    PRIMARY KEY (`playlist_id`),

    CHECK (`hours_listened` >= 0)
);

-- 6. Connect playlists with their songs.
CREATE TABLE `playlist_songs` (
    `playlist_id` INT UNSIGNED NOT NULL,
    `song_id` INT UNSIGNED NOT NULL,
    `position` INT UNSIGNED NOT NULL,
    `date_added` DATE NOT NULL,

    PRIMARY KEY (`playlist_id`, `song_id`),
    UNIQUE (`playlist_id`, `position`),

    FOREIGN KEY (`playlist_id`)
        REFERENCES `playlists` (`playlist_id`)
        ON DELETE CASCADE,

    FOREIGN KEY (`song_id`)
        REFERENCES `songs` (`song_id`)
        ON DELETE CASCADE,

    CHECK (`position` >= 1)
);

-- 7. Podcasts
CREATE TABLE `podcasts` (
    `podcast_id` INT UNSIGNED AUTO_INCREMENT,
    `podcast_name` VARCHAR(200) NOT NULL,
    `host_name` VARCHAR(150) NOT NULL,
    `genre` VARCHAR(100) NOT NULL,
    `release_date` DATE NOT NULL,
    `total_stream` BIGINT UNSIGNED NOT NULL DEFAULT 0,

    PRIMARY KEY (`podcast_id`)
);
