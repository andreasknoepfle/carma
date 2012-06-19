<!doctype html>
<html>
  <head>
    <meta name="layout" content="main"/>
    <title>Carmeq GmbH | Carmob | Projekt Carma</title>
  </head>

  <body>
    <auth:ifNotLoggedIn>
      <h2>Registrieren</h2>
      <auth:form authAction="signup" 
                 success="[controller:'index', action:'signup']" 
                 error="[controller:'index', action:'signup']" class="form-horizontal">
        <div class="control-group">
          <label class="control-label" for="login">Benutzername:</label>
          <div class="controls">
            <g:textField name="login" value="${flash.signupForm?.login?.encodeAsHTML()}" class="span3"/>
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="email">E-Mail:</label>
          <div class="controls">
            <g:textField name="email" value="${flash.signupForm?.email?.encodeAsHTML()}" class="span3"/>
          </div>
        </div>
        <div class="control-group">
          <label class="control-label"  for="password">Passwort:</label>
          <div class="controls">
            <input name="password" value="" type="password" class="span3"/>
          </div>
        </div>
        <div class="control-group">
          <label class="control-label"  for="passwordConfirm">Passwort wiederholen:</label>
          <div class="controls">
            <input name="passwordConfirm" value="" type="password" class="span3"/>
          </div>
        </div>
        <div class="control-group">
          <div class="controls">
            <g:actionSubmit action="Sign up" value="Registrieren" class="btn btn-primary"/>
          </div>
        </div>
      </auth:form>
    </auth:ifNotLoggedIn>
  </body>
</html>
