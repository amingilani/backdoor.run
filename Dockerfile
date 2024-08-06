FROM python:3.12-bookworm AS builder

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1
WORKDIR /backdoor

RUN pip install poetry
RUN poetry config virtualenvs.in-project true
COPY pyproject.toml poetry.lock ./
RUN poetry install
FROM python:3.12-slim-bookworm
WORKDIR /backdoor
COPY --from=builder /backdoor/.venv .venv/
COPY . .
CMD ["/backdoor/.venv/bin/gunicorn", "backdoor:app", "--bind", "0.0.0.0:8080"]
