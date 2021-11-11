# Flask étant une API Python on aurait pu utiliser l'image Python 
# On utilise donc Ubuntu comme image de base
# et on install Python
FROM ubuntu

RUN apt-get -y update 
RUN apt-get install -y python pip

# Copie des dépendances avant le dossier pour
# amméliorer le cache de l'image
COPY requirements.txt .

# Installation des dépendances
RUN pip install -qr requirements.txt

# Ajout d'une variable d'environment
# nécessaire à l'utilisation de Flask
ENV FLASK_APP microblog.py

# Copie du projet séparé des dépendances
# pour ne pas réinstaller toutes les dépendances
# lors de la modification du code du projet
COPY ./ /microblog

# L'instruction Workdir permet de se déplacer dans un dossier
# dans le container. Si le dossier n'existe pas il sera crée
WORKDIR /microblog

ENV CONTEXT PROD

# L'instruction EXPOSE permet d'informer Docker
# que le container ecoute sur le réseau spécifié
# Par défaut le port renseigné va être en TCP
# L'instruction EXPOSE ne va pas publier le port
# Pour le publier il faut le renseigner dans le docker run avec -p ou -P
# Cette instruction est plus une forme de documentation
# On peut publier tout les ports exposés avec un -P 
# Le port sera exposé en TCP et en UDP à l'aide un port éphémère 
EXPOSE 5000

CMD ["./boot.sh"]
