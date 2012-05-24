<!doctype html>
<html>
  <head>
    <meta name="layout" content="main"/>
    <title>Carmeq GmbH | Carmob | Projekt Carma</title>
  </head>

  <body>
    <auth:ifNotLoggedIn>
      <g:if test="${flash.authenticationFailure}">
        <div class="alert alert-error">
          <a class="close" data-dismiss="alert" href="#">×</a>
          <h4 class="alert-heading">Warnung</h4>
          <li>Der von ihnen eingegebene Benutzer existiert nicht.</li>
        </div>
      </g:if>
      
      <h2>Log in</h2>
      <auth:form authAction="login" 
                 success="[controller:'index', action:'login']" 
                 error="[ controller:'index', action:'login']" class="form-horizontal">
        <fieldset>
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
          <div class="form-actions">
            <g:actionSubmit value="Log in" class="btn btn-primary"/> 
          </div>
           <g:link controller="Index" action="signup">Registrieren</g:link>
        </fieldset>
      </auth:form>
    </auth:ifNotLoggedIn>
  </body>
</html>