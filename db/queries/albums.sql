-- name: ListAlbums :many
SELECT *
FROM albums;

-- name: GetAlbum :one
SELECT *
FROM albums
WHERE id = $1 LIMIT 1;

-- name: CreateAlbum :one
Insert INTO albums (id, title, artist, price)
VALUES ($1, $2, $3, $4)
RETURNING *;

-- name: DeleteAlbum :exec
DELETE FROM albums
WHERE id = $1;

-- name: UpdateAlbum :exec
Update albums
SET title = $2, artist = $3, price = $4
WHERE id = $1;
