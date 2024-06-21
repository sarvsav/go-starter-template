-- +goose Up
-- +goose StatementBegin
SELECT 'up SQL query';
-- +goose StatementEnd
CREATE TABLE albums (
    ID     uuid PRIMARY KEY,
    Title  TEXT NOT NULL,
    Artist TEXT NOT NULL,
    Price  NUMERIC(10,2) NOT NULL
);

-- +goose Down
-- +goose StatementBegin
SELECT 'down SQL query';
-- +goose StatementEnd
drop table albums;
