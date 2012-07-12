carma
=====

Carmob Team 3

Installationsanleitung: 
========================
Vorraussetzungen:
# Groovy 
# Grails 2.0 oder 2.1 www.grails.org
(# Heroku Toolbelt https://toolbelt.heroku.com/) 

Installation:
=============
Applikation mit git clonen:
git clone https://github.com/andreasknoepfle/carma.git

Applikation starten: 
grails run-app 

Deployment auf Heroku:
======================
# In heroku einloggen
# heroku create

jetzt kann mit einem git push zum heroku repository ein deploy erreicht werden:

git push heroku master

Verbindungen importieren
=========================
Auf die Seite /carma/admin/ wechseln und warten (Seite kann auch geschlossen werden alledings nur einmal aufrufen!)

Alle Importierten Verbindungen löschen
================================
Wie import, nur mit /carma/admin/delete
