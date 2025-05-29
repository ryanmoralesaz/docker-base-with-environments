# zig.Dockerfile
FROM myproject/base:latest

# Install Zig
RUN wget -q https://ziglang.org/download/0.12.0/zig-linux-x86_64-0.12.0.tar.xz \
    && tar -xf zig-linux-x86_64-0.12.0.tar.xz \
    && mv zig-linux-x86_64-0.12.0 /opt/zig \
    && ln -s /opt/zig/zig /usr/local/bin/zig \
    && rm zig-linux-x86_64-0.12.0.tar.xz

# Create a directory for Zig projects
RUN mkdir -p /workspace/zig-projects

CMD ["zsh"]