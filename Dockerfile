FROM debian:buster-slim
LABEL maintainer "Kazunori Sakamoto <exkazuu@gmail.com>"

WORKDIR /app

COPY eval.c /app/eval.c
COPY decode_cigar.py /app/decode_cigar.py
COPY sample_solver.py /app/sample_solver.py

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-suggests --no-install-recommends gcc libc6-dev python3 \
    && gcc -O3 -o eval eval.c \
    && rm -f eval.c \
    && apt-get purge -y gcc \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
