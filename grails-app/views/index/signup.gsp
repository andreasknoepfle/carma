<!doctype html>
<html>
  <head>
    <meta name="layout" content="main"/>
    <title>Carmeq GmbH | Carmob | Projekt Carma</title>
  </head>

  <body>
    <auth:ifNotLoggedIn>
      <h2>Registrieren</h2>
      <auth:form authAction="signup" success="[controller:'index', action:'index']" error="[controller:'index', action:'index']" class="form-horizontal">
        <fieldset> 
          <div class="control-group">
            <label class="control-label" for="login">Benutzername:</label>
            <div class="controls">
              <g:textField name="login" value="${flash.signupForm?.login?.encodeAsHTML()}" class="span3"/>
              <span class="help-block"">
                    <g:hasErrors bean="${flash.signupFormErrors}" field="login">
                  <g:renderErrors bean="${flash.signupFormErrors}" as="list" field="login"/>
                </g:hasErrors>
              </span>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="email">Email:</label>
            <div class="controls">
              <g:textField name="email" value="${flash.signupForm?.email?.encodeAsHTML()}" class="span3"/>
              <span class="help-block">
                <g:hasErrors bean="${flash.signupFormErrors}" field="email">
                  <g:renderErrors bean="${flash.signupFormErrors}" as="list" field="email"/>
                </g:hasErrors>
              </span>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label"  for="password">Passwort:</label>
            <div class="controls">
              <input name="password" value="" type="password" class="span3"/>
              <span class="help-block">
                <g:hasErrors bean="${flash.signupFormErrors}" field="password">
                  <g:renderErrors bean="${flash.signupFormErrors}" as="list" field="password"/>
                </g:hasErrors>
              </span>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label"  for="passwordConfirm">Passwort wiederholen:</label>
            <div class="controls">
              <input name="passwordConfirm" value="" type="password" class="span3"/>
              <span class="help-block">
                <g:hasErrors bean="${flash.signupFormErrors}" field="passwordConfirm">
                  <g:renderErrors bean="${flash.signupFormErrors}" as="list" field="passwordConfirm"/>
                </g:hasErrors>
              </span>
            </div>
          </div>
          <div class="form-actions">
          <g:actionSubmit value="Sign up" class="btn btn-primary"/>
          </div>
        </fieldset>
      </auth:form>
    </auth:ifNotLoggedIn>
  </body>
</html>
