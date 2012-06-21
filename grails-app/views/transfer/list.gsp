
<%@ page import="carmob.carma.Reservation" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'reservation.label', default: 'Reservation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row-fluid">
			<div class="span12">
                                <div class="row-fluid">
                                      <div class="span3 ">
                                        
                                        <div class="well">
                                          <h3>Route:</h3>
                                          Von <b>${direction.from}</b> nach <b>${direction.to}</b></div>
                                      </div>
                                      <div class="span3">
                                          <g:link action="select_direction" class="btn"><i class="icon-repeat"></i> Ändern</g:link>
                                      </div>
                                </div>
				<div class="page-header">
					<h2>Wähle deine Verbindung</h2>
				</div>

				<g:if test="${flash.message}">
				<bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
				</g:if>
                             
                                <div class="accordion" id="transfers">
                                  <g:each in="${transferList}" var="transferInstance">
                                     
                                  <div class="accordion-group">
                                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse${transferInstance.id}">
                                     
                                    <ul class="accordion-heading breadcrumb">
                                      
                                        <li><i class="icon-time"></i> <g:if test="${transferListTomorrow.contains(transferInstance)}"> Morgen um </g:if> ${transferInstance.departure()}<span class="divider"> | </span></li><li><i class="icon-arrow-right"></i> <em>${fieldValue(bean: transferInstance, field: "ice")}</em><span class="divider"> | </span></li><li><i class="icon-share"></i> ${transferInstance.numOpenReservations()}/${transferInstance.numReservations()}</li>
                                    </ul>
                                     </a>

                                    <div id="collapse${transferInstance.id}" class="accordion-body collapse" style="height: 0px; ">
                                      <div class="accordion-inner">
                                        <dl>
                                          <dt>Ankunft: </dt><dd><i class="icon-time"></i> ${transferInstance.arrival()}</dd>
                                        </dl>
                                        <g:link action="show" id="${transferInstance.id}" class="btn btn-small">Auswählen</g:link>
                                      </div>
                                    </div>
                                  </div>
                                  </g:each>
                                </div>
                                <div class="pagination">
					<bootstrap:paginate total="${10}" />
				</div>
                               

                          
			</div>

		</div>
	</body>
</html>
