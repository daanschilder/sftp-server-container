# sftp-server-container
modify the variables in .env as required and run:
> podman compose up --build

or:

> docker compose up --build

SFTP server should be available at ${your container-IP}:${SFTP_PORT}
i.e., on my macbook it defaults to 0.0.0.0:2222