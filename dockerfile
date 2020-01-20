FROM python:3.7

RUN useradd -ms /bin/bash worker

# copy only the files needed for pip install
RUN pip install --upgrade pip
RUN pip install Cython

COPY requirements.txt /home/worker/requirements.txt
RUN pip install -r /home/worker/requirements.txt

COPY requirements-worker.txt /home/worker/requirements-worker.txt
RUN pip install -r /home/worker/requirements-worker.txt

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -yq default-jdk
RUN apt-get install -yq gcc g++ cmake autoconf libtool git libboost-all-dev libc6-dev
RUN apt-get install -yq nano

USER worker

# user requested
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/home/worker/.cargo/bin:${PATH}"
RUN rustup install nightly
RUN cargo install just
RUN cargo install cargo-build-deps bitflags rand itertools approx clap
RUN cargo build --offline -p bitflags -p rand -p itertools -p approx -p clap || true
RUN cargo build --offline --release -p bitflags -p rand -p itertools -p approx -p clap || true

# copy the rest of the app
COPY --chown=worker ./scrimmage /home/worker/scrimmage
WORKDIR /home/worker/scrimmage

CMD ["python3", "engine.py"]
