# TP Docker_1 - Ynov DevOps B3


## **Rendu :** Un fichier MD : DEVOPS_DOCKER1_[NOM]\_[PRENOM].md

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
 
## Exercice 1: Running container

- Lancer un container Ubuntu en *background* (mode détaché) qui affiche la date toutes les 2 secondes.

<details>
  <summary>Hint</summary>
  
  
  ```bash
  while true; do date; sleep 2; done
  ```
  
</details>

- Regarder les logs en temps réel depuis l'hôte
- Rentrer dans le container et afficher les processus
- Installer le paquet ` figlet`dans le container
- Sortir gracieusement du container
- Afficher la différences avec l'image de base
- Transformer votre container en image
- Ajouter lui un tag de version **figlet**


## Exercice 3 : AutoClean Container

- En **une** commande il faut : 
  - Lancer un container ubuntu avec la commande d'affichage de l'heure toutes les 2
  - Afficher les logs sur l'hôte
  - Supprimer le container lorsqu'on exit le process

## Exercice 2 : Clean Container

- Afficher tout les containers de votre hôte
  - Running
  - Stopped
  - Exited
- Supprimer tout les containers stoppés

## Exercice 4 : Serveur HTTPD

- Lancer un container Serveur web (httpd)
- Depuis l'hôte lancer un `curl localhost`
  - Exliquez le résultat
- Récupérer l'adresse ip du container
- Lancer `curl <adresse container httpd>`
- Créer un nouveau container Debian/Ubuntu
- Exécuter le `curl <adresse container httpd>` après avoir installé l'outils
  - Exliquez le résultat 

## Bonus : Exercice 5 : Serveur HTTPD

- Lancer un container Serveur web (Apache,nginx) en **mode détaché**
  - Rendre le container accessible depuis le LAN d'Ynov
  - Faire tourner le serveur web sur le port 8080
  - Modifier la page d'accueil `index.html` depuis votre host.

