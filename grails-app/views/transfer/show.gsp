<!doctype html>
<html>
  <head>
    <meta name="layout" content="main">
  <g:set var="entityName" value="${message(code: 'transfer.label', default: 'Transfer')}" />
  <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
  <div class="row-fluid">
    <div class="span12">
      <div class="page-header">
        <h2>${transferInstance.departure()} ${transferInstance.ice}</h2>
        <h3>${transferInstance.dirId.toItString()}</h3>
      </div>
      <g:if test="${flash.message}">
        <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
      </g:if>
      <div class="row">
        <fieldset
          <form><input type="button"  class="btn" value="Zurück" onClick="history.go(-1);return true;"/></form>
          <a href="javascript:window.print()" class="btn" >Drucken</a>
  
            <g:if test="${((transferInstance.weekday==(carma_day+1)%7)&&(transferInstance.departureHours>=(carma_hours-24)))||((transferInstance.departureHours >carma_hours) && (transferInstance.weekday == carma_day))}">                      
            <p class="alert alert-info">Du hast zu wenig <b>CARMA</b>-Punkte um dir jetzt schon eine Reservierung für diesen Zug zu holen. <br/>Sammle mehr <b>Carma</b>-Punkte um dir früher eine Reservierung holen zu können

              </p>
         </g:if>         

        </fieldset>
        <div class="span6 well">
          <h3> Übersicht</h3>
          <table class="table table-condensed table-bordered">
            <tr>
              <td>Abfahrt:</th>
              <td>${transferInstance?.departure()}</td>
            </tr>
            <tr>
              <td>Ankunft:</th>
              <td> ${transferInstance.arrival()}</td>
            </tr>
            <tr>
              <td>Anzahl offene Reservierungen:</th>
              <td>${transferInstance.numOpenReservations()}</td>
            </tr>
            <tr>
              <td>Anzahl Reservierungen insgesamt:</th>
              <td>${transferInstance.numReservations()}</td>
            </tr>
            <tr>
              <td>Anzahl Mitfahrer:</th>
              <td>${transferInstance.numReservations()-transferInstance.numOpenReservations()} </td>
            </tr>
          </table>
        </div>
      </div>
      <g:if test="${myReservation}">
        <div class="row">
          <div class="span6 well">
            <h3>Meine Sitzplatzreservierung</h3>
            <table class="table table-condensed table-bordered">
              <tr>
                <td>Auftragsnummer:</th>
                <td>${myReservation?.orderNumber}</td>
              </tr>
              <tr>
                <td>Wagen:</th>
                <td> ${myReservation?.wagon}</td>
              </tr>
              <tr>
                <td>Platz:</th>
                <td>${myReservation?.seat}</td>
              </tr>
              <tr>
                <td rowspan="2">Von:</th>
                <td>${myReservation.provider.login}</td>
              </tr>
              <tr>
                <td>
                  <g:if test="${myReservation.provider.avatar}">
                    <img class="avatar" src="${createLink(controller:'user', action:'avatar_image' , id: myReservation.provider.id)}" width="70" height="70" />
                  </g:if>
                  <g:else>
                    <g:img  class="avatar" uri="/images/default-avatar.png" width="70" height="70"/>
                  </g:else>
                </td>
              </tr>
            </table>
          <g:link controller="reservation" action="return_reservation" id="${myReservation.id}" class="btn btn-small">Zurückgeben</g:link>
          </div>
        </div>
      </g:if>
      <g:else>
        <div class="row">
          <div class="span6 well">
            <h3>Verfügbare Reservierungen</h3>
            <ul class="thumbnails">
              <g:each in="${openReservations}" var="reservation">
                  <li> 
                    <div align="center">  
                    <g:if test="${reservation.provider.avatar}">
                      <img class="avatar" src="${createLink(controller:'user', action:'avatar_image' , id: reservation.provider.id)}" width="70" height="70" />
                    </g:if>
                    <g:else>
                      <g:img  class="avatar" uri="/images/default-avatar.png" width="70" height="70"/>
                    </g:else>
                    </div>
                    <div class="caption" align="center"> 
                      <b>${reservation.provider.login}</b><br/>
                      <small>Wagen: ${reservation.wagon}</small><br/>
                      <g:if test="${((transferInstance.weekday==(carma_day+1)%7)&&(transferInstance.departureHours>=(carma_hours-24)))||((transferInstance.departureHours >carma_hours) && (transferInstance.weekday == carma_day))}">    
                         <g:link controller="reservation" action="observe_reservation" id="${reservation.id}" class="btn btn-small">Beobachten</g:link>
                      </g:if>
                      <g:else>   
                         <g:link controller="reservation" action="get_reservation" id="${reservation.id}" class="btn btn-small">Holen</g:link>
                      </g:else>
                    </div>
                  </li>
          
              </g:each>
            </ul>
          </div>
        </div>
      </g:else>
      <g:if test="${passengers.size()>0}">
      <div class="row">
        <div class="span6 well">
          <h3>Mitfahrer</h3>
          <ul class="thumbnails">
            <g:each in="${passengers}" var="passenger">
             
                <li>
                  <g:if test="${passenger.user.avatar}">
                    <img class="avatar" src="${createLink(controller:'user', action:'avatar_image' , id: passenger.user.id)}" width="70" height="70" />
                  </g:if>
                  <g:else>
                    <g:img  class="avatar" uri="/images/default-avatar.png" width="70" height="70"/>
                  </g:else>
                  <div class="caption" align="center"> 
                    <b>${passenger.user.login}</b><br/>
                         <small>Wagen: ${passenger.wagon}</small><br/>
                  </div>
                </li>
             
            </g:each>
          </ul>
        </div>
      </div>
        </g:if>
    </div>
  </body>
</html>
