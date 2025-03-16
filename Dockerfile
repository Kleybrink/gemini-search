# Verwende ein offizielles Node.js-Image für ARM64
FROM node:18-bullseye

# Setze das Arbeitsverzeichnis
WORKDIR /app

# Kopiere package.json und package-lock.json
COPY package*.json ./

# Installiere Abhängigkeiten sauber und erzwinge die ARM64-Version von esbuild
RUN npm ci --no-cache && npm install --force esbuild@latest --platform=linux --arch=arm64

# Kopiere den restlichen Anwendungscode
COPY . .

RUN ./node_modules/.bin/esbuild --version && uname -m

# Baue die Anwendung
RUN npm run build

# Öffne den Port, auf dem die App läuft (passe ihn bei Bedarf an)
EXPOSE 3000

# Starte die Anwendung
CMD ["npm", "run", "start"]
