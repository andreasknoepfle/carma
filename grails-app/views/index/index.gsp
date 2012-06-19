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
        <h4>Du willst ...</h4>
        <fieldset>
          <g:form class="form-horizontal" controller="transfer" action="select_direction" >
            <g:actionSubmit action="select_direction" value="... eine Reservierung holen." class="btn-danger btn"/>
          </g:form>
          <g:form class="form-horizontal" controller="reservation" action="create" >
            <g:actionSubmit action="create" value="... eine Reservierung abgeben." class="btn-success btn"/>
          </g:form>
        </fieldset>
      </div>
      <div class="well">
        <h2>CARMA Topliste</h2>
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
