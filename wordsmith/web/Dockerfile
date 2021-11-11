#Image de base Golang pour éviter de devoir installer
#Go sur Ubuntu/Alpine -- On pourrait utiliser golang:alpine
FROM golang

#On copie séparément le code de l'application go 
#Et les ressources statiques pour éviter la perte
#de temps lors du build
COPY dispatcher.go .

#COPY d'un dossier copie vraiment le contenu du dossier
#Si on utilisé COPY static . toutes les ressources 
#statiques seront poussées dans le workdir
COPY static static

# Compiler l'app Go
RUN go build dispatcher.go

# On relance une image de base pour repartir sur une base saine sans le compilateur Go
# On appelle ça un build multi-stage
# Les stages sont identifiés par des numéros 
# partant de 0 en comptant le nombre d'instructions FROM
FROM ubuntu

# On copie le programme compilé dans le stage 0 
# dans notre nouvelle image de base
COPY --from=0 /go/dispatcher .

# En utilisant la syntax exec on s'assure que
# "./dispatcher" sera PID 1
CMD ["./dispatcher"]
