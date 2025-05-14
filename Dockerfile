FROM alpine AS download-zig 

ARG ZIG_VERSION="0.15.0-dev.532+a3693aae3"
ARG OPTIONS=-Doptimize=ReleaseSafe
ARG ARCH="x86_64"

RUN apk update && apk add curl tar xz

RUN curl -f https://ziglang.org/builds/zig-linux-${ARCH}-${ZIG_VERSION}.tar.xz -O && \
    tar -xf *.tar.xz && \
    mv zig-linux-${ARCH}-${ZIG_VERSION} /zig

FROM alpine AS final
COPY --from=download-zig /zig /zig
ENV PATH=/zig:$PATH
