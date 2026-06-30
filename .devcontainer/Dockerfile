FROM ghcr.io/tkpegatron/opsdev:rolling

# -{ ENV: Consume VSCode Environment variables }
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG TZ=America/Detroit

# -{ MOD: Configure userspace environment }
RUN \
    # Set the container's timezone \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone; \
    # Add local user account inside container \
    adduser --shell /bin/zsh --disabled-password $USERNAME

# Drop to non-root
USER $USERNAME

# Add ~/.local/bin to path (mainly pip but lots of other things)
ENV PATH="$PATH:/home/$USERNAME/.local/bin"

# Install Python Dependencies
COPY ./requirements.txt /opt/requirements.txt
RUN pip install -r /opt/requirements.txt --break-system-packages

# Install Ansible Depenedencies
COPY ./requirements.yml /opt/requirements.yml
RUN ansible-galaxy install -r /opt/requirements.yml
