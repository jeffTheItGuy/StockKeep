# Use the official .NET SDK 8.0 image as the base image
FROM mcr.microsoft.com/dotnet/sdk:8.0

# Set environment variables for non-interactive apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y git sudo

# Create a group with the same GID as the host user
ARG HOST_GROUP_ID=1000
RUN groupadd -g ${HOST_GROUP_ID} hostgroup

# Create user jefftheitguy with sudo permissions and add to the host group
ARG HOST_USER_ID=1000
RUN useradd -m -s /bin/bash -u ${HOST_USER_ID} -g ${HOST_GROUP_ID} -G sudo jefftheitguy && \
    echo "jefftheitguy ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set the working directory
WORKDIR /home/jefftheitguy

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch to the new user
USER jefftheitguy

# Expose default port
EXPOSE 8080

# Start bash
CMD ["bash"]








