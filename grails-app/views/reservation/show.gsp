
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
			<div class="span9">
				<div class="page-header">
					<h1><g:message code="default.show.label" args="[entityName]" /></h1>
				</div>

				<g:if test="${flash.message}">
				<bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
				</g:if>

				<dl>
				
					<g:if test="${reservationInstance?.date}">
						<dt><g:message code="reservation.date.label" default="Date" /></dt>
						
							<dd><g:formatDate date="${reservationInstance?.date}" /></dd>
						
					</g:if>
				
					<g:if test="${reservationInstance?.orderNumber}">
						<dt><g:message code="reservation.orderNumber.label" default="Order Number" /></dt>
						
							<dd><g:fieldValue bean="${reservationInstance}" field="orderNumber"/></dd>
						
					</g:if>
				
					<g:if test="${reservationInstance?.seat}">
						<dt><g:message code="reservation.seat.label" default="Seat" /></dt>
						
							<dd><g:fieldValue bean="${reservationInstance}" field="seat"/></dd>
						
					</g:if>
				
					<g:if test="${reservationInstance?.wagon}">
						<dt><g:message code="reservation.wagon.label" default="Wagon" /></dt>
						
							<dd><g:fieldValue bean="${reservationInstance}" field="wagon"/></dd>
						
					</g:if>
				
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
