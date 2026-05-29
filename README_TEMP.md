# Documentação

## Criando Imagens e Containers:

Para criar imagens:

Development: docker build --target development -t my-application .
Production: docker build --target production -t my-application .

Para executar o container: 

docker run -p 3000:3000 -p 5173:5173 -p 9229:9229 my-application

##  Using Docker Compose:

Execute the command 

Development: docker compose up application-development --build
Production: docker compose up application-production --build

Adicione a flag --buil para reconstruir a imagem Docker. Se a flag não for adicionada, 
a imagem antiga será utilizada.