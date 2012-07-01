<!doctype html>
<html>
  <head>
    <meta name="layout" content="main"/>
    <title>Carmeq GmbH | Carmob | Projekt Carma</title>
  </head>
  <body>
    <auth:ifNotLoggedIn>
      <div class="row-fluid">
        <div class="span12">
          <div class="row-fluid">
            <div class="span6">
              <div class="hidden-phone">
                <h2>Herzlichen Willkommen bei CARMA</h2><br/>
                Stellen Sie sich vor, Sie stehen am Bahnsteig, der Zug fährt ein und
                Sie merken, dass Sie noch keine Reservierung haben. Sie müssen also
                die gesamte Fahrt stehen.
                <br/><br/>
                <b>Ein wahrer Albtraum, nicht wahr?</b><br/><br/>

                Das dachten auch wir von Team 3 und haben eine Tauschbörse entwickelt,
                in der Sie auch noch <b>kurz vor der Reise</b> mit wenigen Klicks an Ihre
                Reservierung kommen.<br/><br/>

                Wenn Sie mal eine Reservierung nicht wahrnehmen können, so verfällt
                diese nicht mehr. Sie stellen die Reservierung anderen zur Verfügung
                ohne dabei viel Zeit zu verlieren.<br/><br/>

                Alles ganz einfach. Mit dem neuen CARMA-System von Team 3.
              </div><br/><br/>
              <h2>Log in</h2>
              <auth:form authAction="login" 
                 success="[controller:'index', action:'login']" 
                 error="[ controller:'index', action:'login']" class="form-horizontal">
                <div class="control-group">
                  <label class="control-label" for="login">Benutzername:</label>
                  <div class="controls">
                    <g:textField name="login" value="${flash.loginForm?.login?.encodeAsHTML()}" class="span3"/>
                  </div>
                </div>
                <div class="control-group">
                  <label class="control-label" for="password">Passwort:</label>
                  <div class="controls">
                    <input name="password" value="" type="password" class="span3"/>
                  </div>
                </div>
                <div class="control-group">
                  <div class="controls">
                    <g:actionSubmit value="Login" class="btn btn-primary"/>
                  </div>
                </div>
                <div class="control-group">
                  <div class="controls">
                    <g:link controller="Index" action="signup">Registrieren</g:link>
                  </div>
                </div>
              </auth:form>
            </div>
            <div class="span6">
              <div class="hidden-phone">
                <div id="myCarousel" class="carousel slide">
                  <div class="carousel-inner">
                    <div class="active item">
                      <g:img dir="images" file="res_holen.jpg" alt="Reservierung holen"/>
                      <div class="carousel-caption">
                        <h4>Jederzeit Reservierungen holen</h4>
                        <p>Sie haben keine Reservierung? Greifen Sie zu!</p>
                      </div>
                    </div>
                    <div class="item">
                      <g:img dir="images" file="res_holen.jpg" alt="Reservierung abgeben"/>
                      <div class="carousel-caption">
                        <h4>Sie brauchen Ihre Reservierung nicht mehr?</h4>
                        <p>Geben Sie die Reservierung an Kollegen ab.</p>
                      </div>
                    </div>
                    <div class="item">
                      <g:img dir="images" file="res_holen.jpg" alt="Reservierung holen"/>
                      <div class="carousel-caption">
                        <h4>CARMA-Punkte</h4>
                        <p>Sammeln Sie CARMA und sichern Sie sich einen Platz ganz oben.<p>
                      </div>
                    </div>
                  </div>
                  <a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
                  <a class="carousel-control right" href="#myCarousel" data-slide="next">&rsaquo;</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </auth:ifNotLoggedIn>
  </body>
</html>