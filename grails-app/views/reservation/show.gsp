
<%@ page import="carmob.carma.Reservation" %>
<!doctype html>
<html>
  <head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'reservation.label', default: 'Reservation')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
  </head>
  <body>
    <div class="row-fluid">
      <div class="span12">
        <div class="page-header">
          <h2>Sitzplatzreservierung</h2>
          <h3>Um ${reservationInstance.transfer.departure()} mit ${reservationInstance.transfer.ice}</h3>
        </div>
        <p>
          <a href="javascript:window.print()" class="btn" >Drucken</a>
          <g:if test="${flash.message}">
        </p>
          <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
        </g:if>
        <div class="row">
         
          <div class="span6 well">
            
            <h3> Übersicht</h3>
            <table class="table table-condensed table-bordered">
              <tr>
                <td>Auftragsnummer:</th>
                <td>${reservationInstance?.orderNumber}</td>
              </tr>
              <tr>
                <td>Wagen:</th>
                <td> ${reservationInstance?.wagon}</td>
              </tr>
              <tr>
                <td>Platz:</th>
                <td>${reservationInstance?.seat}</td>
              </tr>
              <tr>
                <td>Ankunft:</th>
                <td>${reservationInstance.transfer.arrival()}</td>
              </tr>
              <tr><td>Richtung:</th>
                <td>${reservationInstance.transfer.dirId.toEmString()}</td>
              </tr>
              <tr>
                <td rowspan="2">Von:</th>
                <td>${reservationInstance.provider.login}</td>
              </tr>
              <tr>
                <td>
                  <g:if test="${reservationInstance.provider.avatar}">
                    <img class="avatar" src="${createLink(controller:'user', action:'avatar_image' , id: reservationInstance.provider.id)}" width="70" height="70" />
                  </g:if>
                  <g:else>
                    <g:img  class="avatar" uri="/images/default-avatar.png" width="70" height="70"/>
                  </g:else>
                </td>
              </tr>
              <g:if test="${reservationInstance.user}">
                <tr>
                  <td rowspan="2">Mitfahrer:</th>
                  <td>${reservationInstance.user.login}</td>
                </tr>
                <tr>
                  <td>
                    <g:if test="${reservationInstance.user.avatar}">
                      <img class="avatar" src="${createLink(controller:'user', action:'avatar_image' , id: reservationInstance.user.id)}" width="70" height="70" />
                    </g:if>
                    <g:else>
                      <g:img  class="avatar" uri="/images/default-avatar.png" width="70" height="70"/>
                    </g:else>
                  </td>
                </tr>
              </g:if>
            </table>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
