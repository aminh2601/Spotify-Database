USE spotify;

-- Fictional sample data for demonstration.
-- Run once after creating the schema, while the tables are empty.

START TRANSACTION;

-- 1. Artists
INSERT INTO artists (
    artist_id, artist_name, ranking, monthly_listeners,
    total_stream, total_followers
)
VALUES
    (1, 'Luna Grey',    1, 850000, 2200000, 320000),
    (2, 'Noah Rivers',  2, 620000, 1500000, 210000),
    (3, 'The Skylines', 3, 410000,  900000, 150000),
    (4, 'Maya Bloom',   4, 280000,  750000,  95000);

-- 2. Albums
-- Quiet Hours has no songs yet.
INSERT INTO albums (
    album_id, album_name, release_date, total_stream
)
VALUES
    (1, 'Midnight Letters', '2025-03-14', 2200000),
    (2, 'Open Roads',       '2024-09-20', 1100000),
    (3, 'City Lights',      '2025-06-06',  900000),
    (4, 'Quiet Hours',      '2026-01-16',       0);

-- 3. Songs
-- Bloom Again has no assigned album.
INSERT INTO songs (
    song_id, album_id, song_name, genre,
    release_date, total_stream
)
VALUES
    (1, 1,    'After Midnight', 'Pop',        '2025-03-14', 900000),
    (2, 1,    'Paper Hearts',   'Pop',        '2025-03-14', 650000),
    (3, 1,    'Stay Awhile',    'Pop',        '2025-03-14', 400000),
    (4, 1,    'Last Train',     'Pop',        '2025-03-14', 250000),
    (5, 2,    'Homebound',      'Indie Folk', '2024-09-20', 700000),
    (6, 2,    'Slow Morning',   'Indie Folk', '2024-09-20', 400000),
    (7, 3,    'Neon Streets',   'Rock',       '2025-06-06', 450000),
    (8, 3,    'Summer Static',  'Rock',       '2025-06-06', 300000),
    (9, 3,    'Window Seat',    'Rock',       '2025-06-06', 150000),
    (10, NULL, 'Bloom Again',   'R&B',        '2026-02-13', 750000);

-- 4. Artist credits
-- Stay Awhile is a collaboration between Luna Grey and Noah Rivers.
INSERT INTO song_artists (song_id, artist_id)
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (3, 2),
    (4, 1),
    (5, 2),
    (6, 2),
    (7, 3),
    (8, 3),
    (9, 3),
    (10, 4);

-- Artist totals here count each credited song's streams in full.
-- Collaboration streams therefore count toward both artists.

-- 5. Playlists
-- New Discoveries is an empty playlist.
INSERT INTO playlists (
    playlist_id, playlist_name, hours_listened, total_saved
)
VALUES
    (1, 'Daily Mix',       125.50, 350),
    (2, 'Study Session',    86.25, 220),
    (3, 'Weekend Drive',    64.75, 180),
    (4, 'New Discoveries',   0.00,   0);

-- 6. Playlist contents
-- Positions are unique within each playlist.
INSERT INTO playlist_songs (
    playlist_id, song_id, position, date_added
)
VALUES
    (1, 1,  1, '2026-03-01'),
    (1, 3,  2, '2026-03-01'),
    (1, 5,  3, '2026-03-02'),
    (1, 7,  4, '2026-03-02'),
    (1, 10, 5, '2026-03-03'),

    (2, 2,  1, '2026-03-04'),
    (2, 6,  2, '2026-03-04'),
    (2, 9,  3, '2026-03-05'),

    (3, 7,  1, '2026-03-06'),
    (3, 8,  2, '2026-03-06'),
    (3, 4,  3, '2026-03-07'),
    (3, 5,  4, '2026-03-07');

-- 7. Podcasts
INSERT INTO podcasts (
    podcast_id, podcast_name, host_name,
    genre, release_date, total_stream
)
VALUES
    (1, 'Data After Class', 'Alex Morgan',
     'Technology', '2024-01-15', 180000),

    (2, 'Small Steps', 'Jamie Chen',
     'Education', '2023-08-10', 240000),

    (3, 'Weekend Stories', 'Sam Parker',
     'Culture', '2025-02-21', 95000);

COMMIT;
