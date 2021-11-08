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

# En utilisant la syntax exec on s'assure que
# "./dispatcher" sera PID 1

CMD ["./dispatcher"]
