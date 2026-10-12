USE spotify;

-- 1. Show artists from highest to lowest monthly listeners.
SELECT artist_name, monthly_listeners
FROM artists
ORDER BY monthly_listeners DESC;

-- 2. Show the top 10 most streamed songs.
SELECT song_name, total_stream
FROM songs
ORDER BY total_stream DESC
LIMIT 10;

-- 3. Show the top 10 most streamed albums.
SELECT album_name, total_stream
FROM albums
ORDER BY total_stream DESC
LIMIT 10;

-- 4. Show songs with their album names.
-- Songs without an album are also included.
SELECT songs.song_name, albums.album_name
FROM songs
LEFT JOIN albums
    ON songs.album_id = albums.album_id;

-- 5. Show songs and their artists.
-- A song with multiple artists appears once per artist.
SELECT songs.song_name, artists.artist_name
FROM songs
JOIN song_artists
    ON songs.song_id = song_artists.song_id
JOIN artists
    ON song_artists.artist_id = artists.artist_id
ORDER BY songs.song_name, artists.artist_name;

-- 6. Find all songs by Luna Grey.
SELECT songs.song_name, songs.release_date, songs.total_stream
FROM songs
JOIN song_artists
    ON songs.song_id = song_artists.song_id
JOIN artists
    ON song_artists.artist_id = artists.artist_id
WHERE artists.artist_name = 'Luna Grey'
ORDER BY songs.total_stream DESC;

-- 7. Count the songs in each album, including empty albums.
SELECT albums.album_id, albums.album_name,
       COUNT(songs.song_id) AS number_of_songs
FROM albums
LEFT JOIN songs
    ON albums.album_id = songs.album_id
GROUP BY albums.album_id, albums.album_name
ORDER BY number_of_songs DESC;

-- 8. Count the songs credited to each artist.
SELECT artists.artist_id, artists.artist_name,
       COUNT(song_artists.song_id) AS number_of_songs
FROM artists
LEFT JOIN song_artists
    ON artists.artist_id = song_artists.artist_id
GROUP BY artists.artist_id, artists.artist_name
ORDER BY number_of_songs DESC;

-- 9. Count distinct albums containing each artist's songs.
SELECT artists.artist_id, artists.artist_name,
       COUNT(DISTINCT songs.album_id) AS number_of_albums
FROM artists
LEFT JOIN song_artists
    ON artists.artist_id = song_artists.artist_id
LEFT JOIN songs
    ON song_artists.song_id = songs.song_id
GROUP BY artists.artist_id, artists.artist_name
ORDER BY number_of_albums DESC;

-- 10. Show songs in playlist 1 in their playlist order.
-- Replace 1 with the playlist_id you want.
SELECT playlist_songs.position, songs.song_name,
       playlist_songs.date_added
FROM playlist_songs
JOIN songs
    ON playlist_songs.song_id = songs.song_id
WHERE playlist_songs.playlist_id = 1
ORDER BY playlist_songs.position;

-- 11. Count songs in each playlist, including empty playlists.
SELECT playlists.playlist_id, playlists.playlist_name,
       COUNT(playlist_songs.song_id) AS number_of_songs
FROM playlists
LEFT JOIN playlist_songs
    ON playlists.playlist_id = playlist_songs.playlist_id
GROUP BY playlists.playlist_id, playlists.playlist_name
ORDER BY number_of_songs DESC;

-- 12. Show the most saved playlists.
SELECT playlist_name, total_saved, hours_listened
FROM playlists
ORDER BY total_saved DESC;

-- 13. Find songs in a particular genre.
SELECT song_name, total_stream
FROM songs
WHERE genre = 'Pop'
ORDER BY total_stream DESC;

-- 14. Find songs released in 2025.
SELECT song_name, release_date
FROM songs
WHERE release_date >= '2025-01-01'
  AND release_date < '2026-01-01'
ORDER BY release_date;

-- 15. Show podcasts from highest to lowest total streams.
SELECT podcast_name, host_name, genre, total_stream
FROM podcasts
ORDER BY total_stream DESC;
