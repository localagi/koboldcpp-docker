ARG FROM_IMAGE
FROM ${FROM_IMAGE}


RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    apt-get update ; \
    apt-get upgrade -y ; \
    apt-get install -y --no-install-recommends ninja-build build-essential cmake libclblast-dev libopenblas-dev python3 python3-pip
    
    
COPY requirements.txt .
RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    pip install -U pip && \
    pip install -r requirements.txt

COPY --link . /koboldcpp
WORKDIR /koboldcpp
ARG MAKE_ARGS=
RUN export ${MAKE_ARGS} && make

# ENV PATH="PATH=$PATH:/llama.cpp/build/bin"

ENTRYPOINT ["python3"]
