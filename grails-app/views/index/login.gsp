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
              <div class="well hidden-phone">
                <h1>Herzlichen Willkommen bei CARMA</h1><br/>
                <p class="lead">Holen Sie sich in sekundenschnelle eine neue Reservierung.
                Wenn Sie mal eine Reservierung nicht wahrnehmen können, so verfällt
                diese nicht mehr. Sie stellen die Reservierung anderen zur Verfügung
                ohne dabei viel Zeit zu verlieren.</p>
                <p class="lead">Alles ganz einfach!<br/>Mit dem neuen CARMA-System von Team 3</p>
              </div>
              <div class="well">
                <h1>Log in</h1><br/>
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
            </div>
            <div class="span6">
              <div class="hidden-phone">
                <div id="myCarousel" class="carousel slide">
                  <div class="carousel-inner">
                    <div class="active item">
                      <g:img dir="images" file="res_holen.jpg" alt="Reservierung holen"/>
                      <div class="carousel-caption">
                        <h4>Jederzeit Reservierungen holen</h4>
                        <p>Sie haben keine Reservierung? Greifen Sie zu. Mit wenigen Klicks erhalten Sie eine Reservierung!</p>
                      </div>
                    </div>
                    <div class="item">
                      <g:img dir="images" file="res_abgeben.jpg" alt="Reservierung abgeben"/>
                      <div class="carousel-caption">
                        <h4>Sie brauchen Ihre Reservierung nicht mehr?</h4>
                        <p>Geben Sie die Reservierung an Kollegen ab und gewinnen Sie CARMA!</p>
                      </div>
                    </div>
                    <div class="item">
                      <g:img dir="images" file="carma_sammeln.jpg" alt="Reservierung holen"/>
                      <div class="carousel-caption">
                        <h4>CARMA-Punkte</h4>
                        <p>Sammeln Sie CARMA und sichern Sie sich einen Platz ganz oben in der Topliste.<p>
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