# Documentação

##  Using Docker Compose:

Execute the command 

Development: docker compose up application-development --build
Production: docker compose up application-production --build

Adicione a flag --buil para reconstruir a imagem Docker. Se a flag não for adicionada, 
a imagem antiga será utilizada.