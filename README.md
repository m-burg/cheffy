# Cheffy

Run a PostgreSQL container:

``` sh
podman run -p 5432:5432  -e POSTGRES_PASSWORD=postgres postgres
```

Setup

``` sh
mix deps.get
```

Trigger the bug

``` sh
mix test
```

