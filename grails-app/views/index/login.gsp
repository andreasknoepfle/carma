<!doctype html>
<html>
  <head>
    <meta name="layout" content="main"/>
    <title>Carmeq GmbH | Carmob | Projekt Carma</title>
  </head>
  <body>
    <auth:ifNotLoggedIn>
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
    </auth:ifNotLoggedIn>
  </body>
</html>