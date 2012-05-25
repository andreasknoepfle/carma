
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
				<div class="page-header">
					<h1>Select your Transfer</h1>
				</div>

				<g:if test="${flash.message}">
				<bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
				</g:if>
				
				<table class="table table-striped">
					<thead>
						<tr>
						
							<g:sortableColumn property="arrival" title="${message(code: 'transfer.arrival.label', default: 'Arrival')}" />
						
							<g:sortableColumn property="departure" title="${message(code: 'transfer.departure.label', default: 'Departure')}" />
						
							<th class="header"><g:message code="transfer.dirId.label" default="Dir Id" /></th>
						
							<g:sortableColumn property="ice" title="${message(code: 'transfer.ice.label', default: 'Ice')}" />
						
							<g:sortableColumn property="weekday" title="${message(code: 'transfer.weekday.label', default: 'Weekday')}" />
                                                        
							<th></th>
						</tr>
					</thead>
					<tbody>
                                        <g:each in="${transferList}" var="transferInstance">
						<tr>
                                                        <td>${fieldValue(bean: transferInstance, field: "arrival")}</td>
						
							<td>${fieldValue(bean: transferInstance, field: "departure")}</td>
						
							<td>${fieldValue(bean: transferInstance, field: "ice")}</td>
						
							<td>${fieldValue(bean: transferInstance, field: "weekday")}</td>
						
							<td class="link">
								<g:link action="list" controller="reservation" params="[transfer: transferInstance.id]" class="btn btn-small">Select &raquo;</g:link>
							</td>
						</tr>
					</g:each>
					</tbody>
				</table>
				
			</div>

		</div>
	</body>
</html>
