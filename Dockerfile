FROM alpine AS download-zig 

ARG ZIG_VERSION="0.15.0-dev.769+4d7980645"
ARG OPTIONS=-Doptimize=ReleaseSafe
ARG ARCH="x86_64"

RUN apk update && apk add curl tar xz

RUN curl -f https://ziglang.org/builds/zig-${ARCH}-linux-${ZIG_VERSION}.tar.xz -O && \
    tar -xf *.tar.xz && \
    mv zig-${ARCH}-linux-${ZIG_VERSION} /zig

FROM alpine AS final
COPY --from=download-zig /zig /zig
ENV PATH=/zig:$PATH
