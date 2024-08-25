# Usar uma imagem base oficial do Node.js
FROM node:18-alpine

# Instalar dependências do sistema, incluindo curl e bash
RUN apk add --no-cache git python3 make g++ curl bash

# Definir o diretório de trabalho
WORKDIR /usr/src/app

# Clonar o repositório do GitHub
RUN git clone https://github.com/openstatusHQ/openstatus.git .

# Instalar pnpm globalmente
RUN npm install -g pnpm

# Instalar o bun
RUN curl -fsSL https://bun.sh/install | bash

# Adicionar bun ao PATH
ENV PATH="/root/.bun/bin:$PATH"

# Instalar as dependências do projeto
RUN pnpm install

# Compilar a aplicação
RUN pnpm build

# Expor a porta que a aplicação irá rodar
EXPOSE 3000

# Comando para rodar a aplicação
CMD ["pnpm", "start"]