FROM python:3.11

LABEL org.opencontainers.image.source=https://github.com/onestay/wf-test

RUN pip install poetry==1.6.1

ENV POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

WORKDIR /app

COPY pyproject.toml poetry.lock ./
RUN poetry install --no-root --no-dev && rm -rf $POETRY_CACHE_DIR

COPY wf_test ./wf_test

EXPOSE 80
CMD [ "poetry", "run", "uvicorn", "wf_test.main:app", "--host", "0.0.0.0", "--port", "80" ]

