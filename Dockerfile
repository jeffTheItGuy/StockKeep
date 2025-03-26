FROM mcr.microsoft.com/dotnet/sdk:8.0

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y git sudo

ARG HOST_GROUP_ID=1000
RUN groupadd -g ${HOST_GROUP_ID} hostgroup

ARG HOST_USER_ID=1000
RUN useradd -m -s /bin/bash -u ${HOST_USER_ID} -g ${HOST_GROUP_ID} -G sudo jefftheitguy && \
    echo "jefftheitguy ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /home/jefftheitguy

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

USER jefftheitguy

EXPOSE 8080

CMD ["bash"]








