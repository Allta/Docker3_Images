FROM python:alpine

RUN apk add curl
RUN pip install flask==0.10.1

ADD /app.py /app/app.py
WORKDIR /app

# L'instruction healthcheck permet de définir
# une commande qui va checker l'état de notre container
# pour le renvoyer au daemon docker qui le spécifiera
# dans les commande docker ("docker ps" par exemple)
HEALTHCHECK CMD curl --fail http://localhost:5000/health || exit 1

CMD python app.py
