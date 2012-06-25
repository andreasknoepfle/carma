<!doctype html>
<html>
  <head>
    <meta name="layout" content="main"/>
    <title>Carmeq GmbH | Carmob | Projekt Carma</title>
  </head>
  <body>
    <auth:ifLoggedIn>
      <div class="well">
        <h2>Hallo, <auth:user/>!</h2><br/>
        <g:link controller="transfer" action="select_direction" class="btn-danger btn btn-large">
          <img src="images/holen01_w.png" alt="Reservierung holen"/><br/>Möchtest du eine Reservierung holen?
        </g:link>
        &nbsp;
        <g:link class="btn-success btn btn-large" controller="reservation" action="create" >
          <img src="images/abgeben01_w.png" alt="Reservierung abgeben"/><br/>Möchtest du eine Reservierung abgeben?
        </g:link>
      </div>
      <div class="well">
        <h2><g:img dir="images" file="podium.png" alt="Podium"/> CARMA Topliste</h2>
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
                    <img class="avatar" src="${createLink(controller:'user', action:'avatar_image', id: userInstance.id)}" width="32" height="32"/>
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
