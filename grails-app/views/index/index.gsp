<!doctype html>
<html>
  <head>
    <meta name="layout" content="main"/>
    <title>Carmeq GmbH | Carmob | Projekt Carma</title>
  </head>
  <body>
    <auth:ifLoggedIn>
      <div class="hero-unit">
        <h1>Hallo, <auth:user/>!</h1><br/>
        <div class="row">
          <div class="span6">
            <div class="row">
              <div class="span3">
                <g:form class="navbar-form" controller="transfer" action="select_direction" >
                  <button type="submit" class="btn-danger btn-large">
                    <i class="icon-minus icon-white"></i> <br/>Möchtest du eine Reservierung holen?
                  </button>
                </g:form>
              </div>
              <div class="span3">
                <g:form class="navbar-form" controller="reservation" action="create" >
                  <button type="submit" class="btn-success btn-large">
                    <i class="icon-plus icon-white"></i> <br/>Möchtest du eine Reservierung abgeben?
                  </button>
                </g:form>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="well">
        <h2>CARMA Topliste</h2>
        <h4>Du befindest dich derzeit auf dem ${currentUserPlace}. Platz. Die Top 3 sind:</h4><br/>
        <table class="table table-striped">
          <thead>
            <tr>
              <th></th>
              <th>Benutzer</th>
              <th>Punktzahl</th>
            </tr>
          </thead>
          <tbody>
          <g:each in="${userInstanceList}" var="userInstance">
            <tr>
              <td>
                <g:link controller="user" action="show" id="${userInstance.id}">
                  <g:if test="${userInstance?.avatar}">
                    <img class="avatar" src="${createLink(controller:'user', action:'avatar_image')}" width="32" height="32"/>
                  </g:if>
                  <g:else>
                    <g:img  class="avatar" uri="/images/default-avatar.png" width="32" height="32"/>
                  </g:else>
                </g:link>
              </td>
              <td>
                <g:link controller="user" action="show" id="${userInstance.id}">
                  ${fieldValue(bean: userInstance, field: "login")}
                </g:link>
              </td>
              <td>${fieldValue(bean: userInstance, field: "carma")}</td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>
    </auth:ifLoggedIn>
    <auth:ifUnconfirmed>
      Um die Registrierung abzuschließen, bestätigen Sie Ihre E-Mail Adresse.
      <g:link action="reconfirm">Senden Sie mir bitte eine weitere Bestätigungsmail.</g:link>
    </auth:ifUnconfirmed>
  </body>
</html>
