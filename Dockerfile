# Étape 1 : Construction de l'application
FROM node:18 AS builder

# Définit le répertoire de travail
WORKDIR /src

# Copie les fichiers de package
COPY package*.json ./

# Installe les dépendances
RUN npm install

# Copie le reste des fichiers de l'application
COPY . .

# Construire l'application
RUN npm run build

# Étape 2 : Exécution de l'application
FROM node:18

# Définit le répertoire de travail
WORKDIR /src

# Copie les fichiers construits depuis l'étape de construction
COPY --from=builder /dist /usr/src/app

# Expose le port 3000 (ou tout autre port que votre app utilise)
EXPOSE 3000

# Commande pour démarrer votre application
CMD ["npm", "run", "start"]
