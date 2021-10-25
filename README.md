# TP Docker_3_Images - Ynov DevOps B3


## **Rendu :** Un fichier MD : DEVOPS_DOCKER3_[NOM]\_[PRENOM].md

Vous avez un template de rendu dans le repo. 
Pour chaque étape, documenter vos actions : 

        Screenshot commande + output
        Explication d'une ou 2 ligne sur ce que fait la commande
        
A chaque exercice rajouter un titre et le nom de l'exercice. La syntaxe ainsi que l'upload de l'image sont décrit dans des liens en haut du template.

:bangbang::bangbang: Pensez à renommer le fichier avec votre **Nom** et **Prénom**

:sparkles: Une fois le TP et le rendu terminé commitez et pushez le dans le repo. :sparkles:
  
### Tips   
Si vous avez des problèmes sur une command utilisez `docker [command] --help`.

:raising_hand: Si vous avez des soucis n'hésitez pas à m'appeler. 


## Avant exercice 

_**Assurez vous bien de pouvoir joindre google.com depuis votre container**_

`docker run --rm busybox nslookup google.com`
 
 
## Exercice 1 : Faites parler votre container

Cowsay man : `https://debian-facile.org/doc:jeux:cowsay`
Cowsay s'installe dans `/usr/games/cowsay`

- Créer un nouveau dossoier `cowsay`
- Créer un Dockerfile qui permet de :
  - docker run --rm cowsay Hello_World !
  - docker run --rm cowsay -f stegosaurus Ynov B3
- Faut-il utiliser **CMD** ou **ENTRYPOINT** ? 


## Exercice 2: Run Flask App 

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

### Exercice 2.5 FALCULTATIF :
- Construisez un second Dockerfile pour une nouvelle application microblog.
  - Utilisez ce script de boot : 
```sh
#!/bin/bash

# ...

set -e
if [ "$APP_ENVIRONMENT" = 'DEV' ]; then
    echo "Running Development Server"
    exec flask run -h 0.0.0.0
else
    echo "Running Production Server"
    exec gunicorn -b :5000 --access-logfile - --error-logfile - app_name:app
fi
```
- Déclarer la variable d'environnement `APP_ENVIRONMENT` à `PROD`par défault
- Construisez l'image
- Déployer **2** containers. Un de PROD et un de DEV sur un port différent. 

## Exercice 3 : Healthcheck 

- Créer un nouveau dossier `Healthcheck`
- Créer un Dockerfile pour déployer l'application `app.py`
  - Lancez l'application avec `python app.py`
- Rajouter un `HEALTHCHECK` dans le Dockerfile pour monitorer l'état de santé du container
  - Voici la commande du HEALTHCHECK `curl --fail http://localhost:5000/health || exit 1`  
- Expliquer le code Python ainsi que le lien avec l'instruction HEALTHCHECK de votre Dockerfile


