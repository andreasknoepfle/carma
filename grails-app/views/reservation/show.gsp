
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
				

				<g:if test="${flash.message}">
				<bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
				</g:if>
                          
                                <div class="page-header">
					<h2>Sitzplatzreservierung</h2>
				</div>
                                <h3>Um ${reservationInstance.transfer.departure()} mit ${reservationInstance.transfer.ice}</h3>
				
                                 <table class="table table-condensed table-bordered">
                                          <tr>
                                            <th align="right">Buchungsnummer:</th>
                                            <td>${reservationInstance?.orderNumber}</td>
                                          </tr>
                                          <tr>
                                            <th align="right">Wagen:</th>
                                            <td> ${reservationInstance?.wagon}</td>
                                          </tr>
                                          <tr>
                                            <th align="right">Platz:</th>
                                            <td>${reservationInstance?.seat}</td>
                                          </tr>
                                          <tr>
                                            <th align="right">Ankunft:</th>
                                            <td>${reservationInstance.transfer.arrival()}</td>
                                          </tr>
                                          <tr><th align="right">Richtung:</th>
                                            <td>${reservationInstance.transfer.dirId.toEmString()}</td>
                                          </tr>
                                          <tr>
                                            <th align="right" rowspan="2">Von:</th>
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
                                  <th align="right" rowspan="2">Mitfahrer:</th>
                                  <td>${reservationInstance.user.login}</td>
                                </tr>
                                <tr>
                                  <td>
                                      <g:if test="${reservationInstance.provider.avatar}">
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
	</body>
</html>
