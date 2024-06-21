---
slug: setting-up-database-process
title: Setting up database process
authors:
  name: Sarvsav Sharma
  title: Go Starter Template Core Team
  url: https://github.com/sarvsav
  image_url: https://github.com/sarvsav.png
tags: [database, sqlc, goose]
---

Let us understand on how to set up the things that will help to connect and perform the crud operations with database.

## Requirements

We will use postgres for our development, and below are the list of tools that needs to be installed and setup in the environment PATH. Use the installation script from [scripts](./scripts/shell/install.sh) directory for installation of tools.

- [goose](https://github.com/pressly/goose)
- [sqlc](https://github.com/sqlc-dev/sqlc)

## Creating migration

First step, is to create a table inside the database to store data. To create a table, use the command `migrate-table` from `make` file. For demonstration purpose, let's use the [albums example](https://go.dev/doc/tutorial/web-service-gin).

```shell
$ make migrate-table
Enter the table name: album
goose -dir db/migrations create create_album sql
2024/06/21 20:02:01 Created new file: db/migrations/20240621180201_create_album.sql
```

It will create a new file inside folder `db/migrations` with date_create__varname__.sql, with default queries. Next, we need to add a create table syntax that will run when we use `goose up` and drop table syntax on running `goose down`.

This is the content of the file.

```sql
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
```

## Writing queries

Next step is to write the sql queries for **CRUD** operations in `sqlc` format inside folder named `db/queries`. These sql queries would be used to generate the `go` code with help of `sqlc`. The filename should be same as of the table name. Follow the naming convention for your function names.

- CreatResource
- GetResource
- ListResources
- UpdateResource
- DeleteResource

## Writing sqlc configuration file

Create a file named in `sqlc.yaml` in your project root. This file defines the configuration for sqlc. It is used to generate Go code from SQL queries.

```yaml
## Filename: sqlc.yaml
version: "2"
cloud:
    organization: "Go Starter Template"
    project: "GoStarterTemplate"
    hostname: "go-starter-template.com"
sql:
    - engine: "postgresql"
      queries: "./db/queries/"
      schema: "./db/migrations/"
      gen:
        go:
          package: "db"
          out: "./db/sqlc"
overrides:
    go: null
plugins: []
rules: []
options: {}
```

## Generating Go code

The go code now can simply be generated using the `sqlc` command.

```shell
sqlc generate
```

It will generate the files inside `db/sqlc` directory. Please _DO NOT EDIT_ them as they get overwritten by sqlc.

The above process will setup the things to work with database using Go.
