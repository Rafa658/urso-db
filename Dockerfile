# Usa a imagem oficial do Postgres 16
FROM postgres:16

# Definir variáveis de ambiente padrão (opcional, podem ser sobrescritas no docker-compose)
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=123
ENV POSTGRES_DB=postgres

# Copia qualquer script de inicialização para o diretório padrão
# OBS: isso é opcional; você pode montar via volumes no Compose
# COPY init.sql /docker-entrypoint-initdb.d/

# Expõe a porta padrão do Postgres
EXPOSE 5432

