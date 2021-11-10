# TP Docker_3_Images - Ynov DevOps B3

## Exercice 1 : Faites parler votre container

### Créer un nouveau dossier `cowsay`

Par convention, il faut créer un nouveau dossier pour chaque application. De plus il faut mettre le Dockerfile à la racine de notre projet. 
Cette bonne pratique s'explique par l'utilisation des repository distant (Github/Gitlab/Jenkins) pour l'intégration continue. 
Pour builder une application, il est nécessaire d'avoir toutes les informations, à savoir *code, dockerfile, ressources statiques*, au même endroit. 


### Créer un Dockerfile qui permet de :
  - docker run --rm cowsay Hello_World !
  - docker run --rm cowsay -f stegosaurus Ynov B3

![Dockerfile](https://i.imgur.com/cuVFoz6.png)

Le Dockerfile est basé sur une image Ubuntu car le paquet **Cowsay** est présent dans les dépôts de paquet officiel.
Pour optimiser le build nous aurions pu utiliser une image de base plus légère.

Une image Docker est composé de layer ou de couche. Chaques instructions rajoute une couche à l'image, c'est pourquoi il faut quand c'est possible optimiser les commandes et réduire le nombre d'instructions. Cela réduira le temps de build.

Lors de l'installation de paquet pour personnaliser notre image, il faut absolument rendre les commandes non interactives car nous n'avons pas la main pour renseigner des paramètres (Par exemple : *yes* pour l'installation de paquet) lors du build. 

Pour cela nous rajoutons le flag **-y** qui permet d'auto-valider les paquets lors de l'installation. 

Nous aurions aussi pu rajouter une variable d'environnement ajouté avant la commandne `apt` : ` DEBIAN_FRONTEND=noninteractive`.

Extrait du man `debconf`: 

      noninteractive  
          This is the anti-frontend. It never interacts with you  at  all,
          and  makes  the  default  answers  be used for all questions. It
          might mail error messages to root, but that's it;  otherwise  it
          is  completely  silent  and  unobtrusive, a perfect frontend for
          automatic installs. If you are using this front-end, and require
          non-default  answers  to questions, you will need to preseed the
          debconf database; see the section below  on  Unattended  Package
          Installation for more details.
          
Lors de la commande docker build, le Dockerfile est envoyé comme une archive au daemon docker. Dans notre cas il est présent sur notre machine, mais il existe des cas ou le daemon docker (Le service docker) est sur un serveur remote. Cela permet d'avoir une machine dédiée au build d'image et de libérer de la bande passante sur les postes des développeurs ou des Ops. 
 
 Lors du build nous voyons des ID apparaitre : 
 
 ```bash
Step 1/5 : FROM ubuntu
 ---> ba6acccedd29
Step 2/5 : RUN apt-get update
 ---> Using cache
 ---> f4ead90947e3
 ...
 ---> Running in 9a2cd7624ea5                                                                  
Removing intermediate container 9a2cd7624ea5                                                   
 ---> e02f21d509d8                                                                             
Step 5/5 : ENTRYPOINT [ "cowsay"]                                                              
 ---> Running in cc226b9d7dfc                                                                  
Removing intermediate container cc226b9d7dfc                                                   
 ---> 99ef5b94553a                     
Successfully built 99ef5b94553a                                                                
Successfully tagged cowsay:latest   
```

Chaque ** Step** représente un layer. 

A chaque step un container est créer et les instructions sont executés dans ce container. Le container est ensuite commité pour créer une nouvelle image puis supprimé.

Dans notre exemple :
- un container `ba6acccedd29` est créer à partir de l'image de base **Ubuntu**.
- L'instruction `ENTRYPOINT` est exécutée dans le container `cc226b9d7dfc` puis commitée dans `99ef5b94553a` puis supprimé.

### Faut-il utiliser **CMD** ou **ENTRYPOINT** ? 

Dans notre DockerFile nous utilisons `ENTRYPOINT` car nous souhaitons fournir des arguments à la commande lancée en tant que PID 1.
Pour rappel : Docker utilise la commande précisé dans l'instructions CMD/ENTRYPOINT comme PID 1 au sein du container. 



## Exercice 2 : Dockerfile WordSmith

Le but de l'exercice est d'écrire les Dockerfiles pour les 3 containers.

### web

C'est un serveur web en Go. Pour compiler du Go, on peut utiliser l'image `golang`, ou bien installer les paquetages Go dans n'importe quelle image de base.

Tout le code est contenu dans un fichier source unique (`dispatcher.go`), et se compile de la manière suivante :

```
go build dispatcher.go
```

Cela produit un exécutable appelé `dispatcher`, qui se lance comme suit :

```
./dispatcher
Listening on port 80
```

Le répertoire appelé `static` doit être dans le répertoire courant
lors du lancement du serveur.

Informations supplémentaires :

- le serveur écoute sur le port 80
- le compilateur go n'est plus nécessaire une fois le programme compilé


### words

C'est un serveur API REST en Java. Il se compile avec maven.

Sur une distribution Debian/Ubuntu, on peut installer Java et maven comme suit :

```
apt-get install maven openjdk-8-jdk
```

Voici la commande qui permet d'invoquer maven pour compiler le programme :

```
mvn verify
```

Le résultat est un fichier appelé `words.jar` placé dans le répertoire `target`.

Le serveur se lance ensuite avec la commande suivante :
```
java -Xmx8m -Xms8m -jar words.jar
```

(En se plaçant dans le répertoire où se trouve `words.jar`.)

Informations supplémentaires :

- le serveur écoute sur le port 8080
- pour la compilation il faut les paquetages maven et openjdk-8-jdk
- pour l'exécution il faut le paquetage openjdk-8-jdk (maven n'est pas nécessaire)


### db

C'est une base de données PostgreSQL.

La base de donnée doit être initialisée avec le schéma (création de
la base et des tables) et les données (utilisées par l'application).

Le fichier `words.sql` contient les commandes SQL nécessaires.

```
# cat words.sql
CREATE TABLE nouns (word TEXT NOT NULL);
CREATE TABLE verbs (word TEXT NOT NULL);
CREATE TABLE adjectives (word TEXT NOT NULL);

INSERT INTO nouns(word) VALUES
  ('cloud'),
  ('elephant'),
  ('gø language'),
  ('laptøp'),
  ('cøntainer'),
  ('micrø-service'),
  ('turtle'),
  ('whale'),
  ('gøpher'),
  ('møby døck'),
  ('server'),
  ('bicycle'),
  ('viking'),
  ('mermaid'),
  ('fjørd'),
  ('legø'),
  ('flødebolle'),
  ('smørrebrød');

INSERT INTO verbs(word) VALUES
  ('will drink'),
  ('smashes'),
  ('smøkes'),
  ('eats'),
  ('walks tøwards'),
  ('løves'),
  ('helps'),
  ('pushes'),
  ('debugs'),
  ('invites'),
  ('hides'),
  ('will ship');

INSERT INTO adjectives(word) VALUES
  ('the exquisite'),
  ('a pink'),
  ('the røtten'),
  ('a red'),
  ('the serverless'),
  ('a brøken'),
  ('a shiny'),
  ('the pretty'),
  ('the impressive'),
  ('an awesøme'),
  ('the famøus'),
  ('a gigantic'),
  ('the gløriøus'),
  ('the nørdic'),
  ('the welcøming'),
  ('the deliciøus');
```

Informations supplémentaires :

- il est fortement conseillé d'utiliser l'image officielle PostgreSQL qui se trouve sur le Docker Hub (elle s'appelle `postgres`)
- sur la [page de l'image officielle](https://hub.docker.com/_/postgres) sur le Docker Hub, vous trouverez une documentation abondante; la section "Initialization scripts" est particulièrement utile pour comprendre comment charger le fichier `words.sql`
- il est conseillé de protéger l'accès à la base avec un mot de passe, mais dans le cas présent, on acceptera de se simplifier la vie en autorisant toutes les connexions (en positionnant la variable `POSTGRES_HOST_AUTH_METHOD=trust`)


## Exercice 3: Run Flask App 

-  Créer le Dockerfile dans le dossier microblog qui va permettre de faire tourner l'application Flask : 
  -  Utilisez l'image `python:3-alpine` ou une image de base `Ubuntu`et installer Python
  -  Flask utilise une variable d'environnement `FLASK_APP`avec le nom du fichier Python de l'application. 
  -  Installer flask dans votre container : `requirements.txt`. Pensez à utiliser la fonction de cache de Docker
  -  Exposer le port 5000
  -  Liser le fichier `boot.sh` et faites tourner l'application Flask en PROD. 
  -  Lancez l'app avec le fichier `boot.sh`
- Construire l'image  
- Lancer le container en publiant un port de votre hôte.  
- Accéder à http://localhost:5000

### Exercice 3.5 FALCULTATIF :

- Construisez un second Dockerfile pour une nouvelle application microblog (Dupliquer le dossier microblog)
  - Remplacer le script de boot par  : 
```sh
#!/bin/bash

# cette partie permet de faire varier l'environnement du container
set -e
if [ "$APP_ENVIRONMENT" == 'DEV' ]; then
    echo "Running Development Server"
    FLASK_ENV=development exec flask run -h 0.0.0.0
else
    echo "Running Production Server"
    exec gunicorn -b :5000 --access-logfile - --error-logfile - microblog:app
fi
```
- Déclarer la variable d'environnement `APP_ENVIRONMENT` à `PROD`par défault
- Construisez l'image
- Déployer **2** containers. Un de PROD et un de DEV sur un port différent. 

## Exercice 4 : Healthcheck 

- Créer un nouveau dossier `Healthcheck`
- Créer un Dockerfile pour déployer l'application `app.py`
  - Lancez l'application avec `python app.py`
- Rajouter un `HEALTHCHECK` dans le Dockerfile pour monitorer l'état de santé du container
  - Voici la commande du HEALTHCHECK `curl --fail http://localhost:5000/health || exit 1`  
- Expliquer le code Python ainsi que le lien avec l'instruction HEALTHCHECK de votre Dockerfile


