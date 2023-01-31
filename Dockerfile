FROM swift:latest

RUN mkdir -p /home/user/app

WORKDIR /home/user/app

COPY . /home/user/app

RUN apt update && \
    apt upgrade -y && \
    apt install -y build-essential \
    git

RUN make release

ENV PATH="${PATH}:/home/user/app/aloha/aloha/.build/release"

CMD ["aloha"]
