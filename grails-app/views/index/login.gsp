<!doctype html>
<html>
  <head>
    <meta name="layout" content="main"/>
    <title>Carmeq GmbH | Carmob | Projekt Carma</title>
  </head>

  <body>
    <auth:ifNotLoggedIn>
      <g:if test="${flash.authenticationFailure}">
        Ihr Login/Registrierung ist fehlgeschlagen:
        <g:message code="authentication.failure.${flash.authenticationFailure.result}"/><br/>
      </g:if>
      
      <h2>Log in</h2>
      <auth:form authAction="login" success="[controller:'index', action:'index']" error="[ controller:'index', action:'index']" class="form-horizontal">
        <fieldset>
          <div class="control-group">
            <label class="control-label" for="login">Benutzername:</label>
            <div class="controls">
              <g:textField name="login" value="${flash.loginForm?.login?.encodeAsHTML()}" class="span3"/>
              <span class="help-block"">
                <g:hasErrors bean="${flash.loginFormErrors}" field="login">
                  <g:renderErrors bean="${flash.loginFormErrors}" as="list" field="login"/>
                </g:hasErrors>
              </span>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="password">Passwort:</label>
            <div class="controls">
              <input name="password" value="" type="password" class="span3"/>
              <span class="help-block"">
                <g:hasErrors bean="${flash.loginFormErrors}" field="password">
                  <g:renderErrors bean="${flash.loginFormErrors}" as="list" field="password"/>
                </g:hasErrors>
              </span>
            </div>
          </div>
          <div class="form-actions">
            <g:actionSubmit value="Log in" class="btn btn-primary"/> 
          </div>
        </fieldset>
      </auth:form>
      <g:link controller="Index" action="signup">Registrieren</g:link>
    </auth:ifNotLoggedIn>
  </body>
</html>