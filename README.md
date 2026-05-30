# Como rodar o projeto

## Em modo Development:
  `docker compose up application-development --build`
  
Frontend com hot reload. Acesso a UI na porta `5173`


## Em modo Production:
  `docker compose up application-production --build`

Acesso a UI na porta `8080`

Utilize a flag `--build` para reconstruir a imagem Docker. Caso a flag não seja adicionada, a ultima imagem construida será utilizada.