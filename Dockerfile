ARG FROM_IMAGE
FROM ${FROM_IMAGE}


RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    apt-get update ; \
    apt-get upgrade -y ; \
    apt-get install -y --no-install-recommends ninja-build build-essential cmake libclblast-dev libopenblas-dev

COPY --link . /koboldcpp
WORKDIR /koboldcpp
ARG MAKE_ARGS=
RUN ${MAKE_ARGS} make

# ENV PATH="PATH=$PATH:/llama.cpp/build/bin"

ENTRYPOINT ["python3", "koboldcpp.py"]
