# Documentação

## Utilizando Docker Compose:

Execute the command 

 - Development: `docker compose up application-development --build`
 - Production: `docker compose up application-production --build`

Adicione a flag `--build` para reconstruir a imagem Docker. Se a flag não for adicionada, a imagem antiga será utilizada.