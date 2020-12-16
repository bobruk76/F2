#!/bin/sh
python3 manage.py migrate
#python3 manage.py loaddata fixtures.json
#python3 manage.py collectstatic
exec "$@"
