
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
				<dl>
				
					<g:if test="${reservationInstance?.orderNumber}">
						<dt>Buchungsnummer:</dt><dd><g:fieldValue bean="${reservationInstance}" field="orderNumber"/></dd>
						
					</g:if>
                                        <g:if test="${reservationInstance?.wagon}">
						<dt>Wagen:</dt><dd><g:fieldValue bean="${reservationInstance}" field="wagon"/></dd>
						
					</g:if>
					<g:if test="${reservationInstance?.seat}">
						<dt>Platz:</dt><dd><g:fieldValue bean="${reservationInstance}" field="seat"/></dd>
						
					</g:if>
                                       
						<dt>Ankunft:</dt><dd>${reservationInstance.transfer.arrival()}</dd>
						
                                                <dt>Richtung:</dt><dd>${reservationInstance.transfer.dirId.toEmString()}</dd>
					
				
				</dl>

				<g:form>
					<g:hiddenField name="id" value="${reservationInstance?.id}" />
					<div class="form-actions">
						<g:link class="btn" action="edit" id="${reservationInstance?.id}">
							<i class="icon-pencil"></i>
							<g:message code="default.button.edit.label" default="Edit" />
						</g:link>
						<button class="btn btn-danger" type="submit" name="_action_delete">
							<i class="icon-trash icon-white"></i>
							<g:message code="default.button.delete.label" default="Delete" />
						</button>
					</div>
				</g:form>

			</div>

		</div>
	</body>
</html>
