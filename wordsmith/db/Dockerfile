FROM postgres


#L'image Postgre a un entrypoint par défault
#qui permet d'executer automatiquement tout les
#scripts .sql présent dans le dossier ci-dessous
COPY words.sql /docker-entrypoint-initdb.d/words.sql

#Permet de se logger sans mot de passe
#L'image Postgre demande une methode d'auth
ENV POSTGRES_HOST_AUTH_METHOD=trust
