#!/bin/sh

# cette partie permet de faire varier l'environnement du container
set -e
if [ "$CONTEXT" = 'DEV' ]; then
    echo "Running Development Server"
    FLASK_ENV=development exec flask run -h 0.0.0.0
else
    echo "Running Production Server"
    exec gunicorn -b :5000 --access-logfile - --error-logfile - microblog:app
fi
