FROM postgres:16

ENV POSTGRES_USER=${POSTGRES_USER}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
ENV POSTGRES_DB=${POSTGRES_DB}
ENV PG_MAJOR=16
ENV CARGO_PGRX_VERSION=0.16.1

RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    llvm \
    git \
    curl \
    pkg-config \
    libssl-dev \
    postgresql-server-dev-${PG_MAJOR} \
    && rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sh -s -- -y

ENV PATH="/root/.cargo/bin:${PATH}"

RUN cargo install --force --locked cargo-pgrx@${CARGO_PGRX_VERSION}

WORKDIR /build
RUN git clone https://github.com/CrunchyData/pg_parquet.git

WORKDIR /build/pg_parquet
RUN cargo pgrx init --pg${PG_MAJOR} /usr/bin/pg_config

RUN cargo pgrx install --release --features pg${PG_MAJOR}

RUN echo "shared_preload_libraries = 'pg_parquet'" \
    >> /usr/share/postgresql/postgresql.conf.sample

EXPOSE 5432

