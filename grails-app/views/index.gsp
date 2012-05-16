<!doctype html>
<html>
  <head>
    <meta name="layout" content="main"/>
    <title>Carmeq GmbH | Carmob | Projekt Carma</title>
  </head>
  <body>
    <auth:ifLoggedIn>
      Sie sind derzeit eingeloggt als: <auth:user/>
      <h2>Logout</h2>
      <auth:form authAction="logout" success="[controller:'authentication', action:'index']" error="[controller:'authentication', action:'index']">
        <g:actionSubmit value="Log out"/> 
      </auth:form>
    </auth:ifLoggedIn>
    
    <auth:ifUnconfirmed>
      Um die Registrierung abzuschließen, bestätigen Sie Ihre E-Mail Adresse.
      <g:link action="reconfirm">Senden Sie mir bitte eine weitere Bestätigungsmail.</g:link>
    </auth:ifUnconfirmed>
    
    <auth:ifNotLoggedIn>
    <g:if test="${flash.authenticationFailure}">
      Ihr Login/Registrierung ist fehlgeschlagen:
      <g:message code="authentication.failure.${flash.authenticationFailure.result}"/><br/>
    </g:if>

    <p>Sie sind nicht eingeloggt. Bitte loggen Sie sich ein:</p>
    <h2>Log in</h2>
    <auth:form authAction="login" success="[controller:'authentication', action:'index']" error="[controller:'authentication', action:'index']">
      Benutzername:
      <g:textField name="login" value="${flash.loginForm?.login?.encodeAsHTML()}"/><br/>
      <g:hasErrors bean="${flash.loginFormErrors}" field="login">
        <g:renderErrors bean="${flash.loginFormErrors}" as="list" field="login"/>
      </g:hasErrors>
      Passwort:
      <input name="password" value="" type="password"/><br/>
      <g:hasErrors bean="${flash.loginFormErrors}" field="password">
        <g:renderErrors bean="${flash.loginFormErrors}" as="list" field="password"/>
      </g:hasErrors>
    <g:actionSubmit value="Log in"/> 
    </auth:form>

    <h2>Registrieren</h2>
    <auth:form authAction="signup" success="[controller:'authentication', action:'index']" error="[controller:'authentication', action:'index']">
        Benutzername:
        <g:textField name="login" value="${flash.signupForm?.login?.encodeAsHTML()}"/><br/>
        <g:hasErrors bean="${flash.signupFormErrors}" field="login">
          <g:renderErrors bean="${flash.signupFormErrors}" as="list" field="login"/>
        </g:hasErrors>
        Email:
        <g:textField name="email" value="${flash.signupForm?.email?.encodeAsHTML()}"/><br/>
        <g:hasErrors bean="${flash.signupFormErrors}" field="email">
          <g:renderErrors bean="${flash.signupFormErrors}" as="list" field="email"/>
        </g:hasErrors>
        Passwort:
        <input name="password" value="" type="password"/><br/>
        <g:hasErrors bean="${flash.signupFormErrors}" field="password">
          <g:renderErrors bean="${flash.signupFormErrors}" as="list" field="password"/>
        </g:hasErrors>
        Passwort wiederholen:
        <input name="passwordConfirm" value="" type="password"/><br/>
        <g:hasErrors bean="${flash.signupFormErrors}" field="passwordConfirm">
          <g:renderErrors bean="${flash.signupFormErrors}" as="list" field="passwordConfirm"/>
        </g:hasErrors>
        <g:actionSubmit value="Sign up"/>
    </auth:form>
    </auth:ifNotLoggedIn>
  </body>
</html>