# Menggunakan image dasar Ubuntu 22.04
FROM ubuntu:22.04

# Set environment variables untuk mencegah interaksi selama instalasi
ENV DEBIAN_FRONTEND=noninteractive

# Update dan install dependensi yang diperlukan
RUN apt-get update && \
    apt-get install -y \
    curl \
    socat \
    supervisor \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Install acme.sh
RUN curl https://get.acme.sh | sh

# Menambahkan skrip ke dalam container
COPY ssl_script.sh /usr/local/bin/ssl_script.sh

# Memberikan hak eksekusi pada skrip
RUN chmod +x /usr/local/bin/ssl_script.sh

# Mengatur working directory
WORKDIR /root

# Menjalankan skrip untuk mendapatkan SSL
CMD ["/usr/local/bin/ssl_script.sh"]
