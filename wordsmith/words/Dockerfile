FROM ubuntu

# Installation du JDK et Maven dans la même RUN
# Pour amméliorer la vitesse de build
RUN apt-get update
RUN apt-get install maven openjdk-8-jdk -y

# Copie des fichiers de dépendances avant de copier le projet
# Cela permet d'utiliser la fonction de cache de Docker build
COPY pom.xml .

# Installation des dépendances
RUN mvn verify

# Copie des sources
# On précise le dossier src sur le container plutot que 
# COPY src . 
# qui va copier le contenu du dossier src dans le WORKDIR
# Plutot que de créer un sous dossier src dans le container
COPY src src

# Build l'application 
# Cela va créer un dossier target avec un fichier words.jar
RUN mvn verify

# On execute la commande java
# pour lancer le programme en PID 1
# CMD plutot qu'entrypoint car on est sur un service
# On ne souhaite pas rajouter des arguments à notre commande

# Pour être sur que le PID 1 soit le programme Java 
# On utilise la syntaxe exec
# Cette syntace peut être écrite en mode json ou en 
# rajoutant la commande exec
CMD exec java -Xmx8m -Xms8m -jar target/words.jar


