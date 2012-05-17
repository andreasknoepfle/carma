
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
			
			<div class="span3">
				<div class="well">
					<ul class="nav nav-list">
						<li class="nav-header">${entityName}</li>
						<li class="active">
							<g:link class="list" action="list">
								<i class="icon-list icon-white"></i>
								<g:message code="default.list.label" args="[entityName]" />
							</g:link>
						</li>
						<li>
							<g:link class="create" action="create">
								<i class="icon-plus"></i>
								<g:message code="default.create.label" args="[entityName]" />
							</g:link>
						</li>
					</ul>
				</div>
			</div>

			<div class="span9">
				
				<div class="page-header">
					<h1><g:message code="default.list.label" args="[entityName]" /></h1>
				</div>

				<g:if test="${flash.message}">
				<bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
				</g:if>
				
				<table class="table table-striped">
					<thead>
						<tr>
						
							<g:sortableColumn property="date" title="${message(code: 'reservation.date.label', default: 'Date')}" />
						
							<g:sortableColumn property="orderNumber" title="${message(code: 'reservation.orderNumber.label', default: 'Order Number')}" />
						
							<g:sortableColumn property="seat" title="${message(code: 'reservation.seat.label', default: 'Seat')}" />
						
							<g:sortableColumn property="wagon" title="${message(code: 'reservation.wagon.label', default: 'Wagon')}" />
						
							<th></th>
						</tr>
					</thead>
					<tbody>
					<g:each in="${reservationInstanceList}" var="reservationInstance">
						<tr>
						
							<td><g:formatDate date="${reservationInstance.date}" /></td>
						
							<td>${fieldValue(bean: reservationInstance, field: "orderNumber")}</td>
						
							<td>${fieldValue(bean: reservationInstance, field: "seat")}</td>
						
							<td>${fieldValue(bean: reservationInstance, field: "wagon")}</td>
						
							<td class="link">
								<g:link action="show" id="${reservationInstance.id}" class="btn btn-small">Show &raquo;</g:link>
							</td>
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<bootstrap:paginate total="${reservationInstanceTotal}" />
				</div>
			</div>

		</div>
	</body>
</html>
