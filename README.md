# Spotify Music and Podcast Database

A MySQL database for organizing Spotify artists, albums, songs,
playlists, and podcasts, with queries for exploring their popularity
and relationships.

This project was created as my final project for CS50 SQL.

## Project Files

- `schema.sql`: Creates the database, tables, and constraints.
- `queries.sql`: Contains example queries for exploring the database.
- `README.md`: Explains the design and how to use the project.
- `diagram.png`: Shows the entity relationship diagram.

## Features

- Store artist rankings, monthly listeners, streams, and followers.
- Organize songs by album, genre, and release date.
- Support songs with multiple artists.
- Create playlists and record song order and dates added.
- Store basic podcast information.
- Find popular content and count songs in albums and playlists.

## Database Design

The database contains seven tables:

| Table | Purpose |
|---|---|
| `artists` | Stores artist information and popularity statistics |
| `albums` | Stores album names, release dates, and stream counts |
| `songs` | Stores song information and optional album associations |
| `song_artists` | Connects songs to their credited artists |
| `playlists` | Stores playlist names, listening hours, and save counts |
| `playlist_songs` | Connects playlists to songs and records their positions |
| `podcasts` | Stores podcast names, hosts, genres, and statistics |

### Entity Relationship Diagram

![Entity Relationship Diagram](diagram.png)

An album can contain many songs, while a song can belong to at most
one album. Songs without an assigned album have a `NULL` album ID.

Songs and artists have a many-to-many relationship through
`song_artists`. This allows collaborations without repeating song
records.

Songs and playlists also have a many-to-many relationship through
`playlist_songs`. Each entry records the song's position and the date
it was added. The same song can appear in different playlists, but
only once in each playlist.

Podcasts are stored independently, without individual episode records.

### Constraints

Primary keys identify records, and foreign keys ensure that references
point to existing rows. Composite primary keys prevent duplicate
artist credits and duplicate songs within a playlist.

Check constraints require nonnegative listening hours and playlist
positions of at least 1.

Deleting an album sets its songs' album IDs to `NULL`, preserving the
songs. Deleting a playlist removes its playlist entries without deleting
the songs themselves.

## Getting Started

### Requirements

- MySQL 8.0.16 or later, so `CHECK` constraints are enforced
- A MySQL client, such as MySQL Workbench or the command-line client

### Create the Database

Run `schema.sql` in MySQL Workbench, or use the command line:

```bash
mysql -u root -p < schema.sql
