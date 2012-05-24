
<%@ page import="carmob.carma.Transfer" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bootstrap">
		<g:set var="entityName" value="${message(code: 'transfer.label', default: 'Transfer')}" />
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
						
							<g:sortableColumn property="active" title="${message(code: 'transfer.active.label', default: 'Active')}" />
						
							<g:sortableColumn property="arrival" title="${message(code: 'transfer.arrival.label', default: 'Arrival')}" />
						
							<g:sortableColumn property="departure" title="${message(code: 'transfer.departure.label', default: 'Departure')}" />
						
							<th class="header"><g:message code="transfer.dirId.label" default="Dir Id" /></th>
						
							<g:sortableColumn property="ice" title="${message(code: 'transfer.ice.label', default: 'Ice')}" />
						
							<g:sortableColumn property="weekday" title="${message(code: 'transfer.weekday.label', default: 'Weekday')}" />
						
							<th></th>
						</tr>
					</thead>
					<tbody>
					<g:each in="${transferInstanceList}" var="transferInstance">
						<tr>
						
							<td><g:formatBoolean boolean="${transferInstance.active}" /></td>
						
							<td>${fieldValue(bean: transferInstance, field: "arrival")}</td>
						
							<td>${fieldValue(bean: transferInstance, field: "departure")}</td>
						
							<td>${fieldValue(bean: transferInstance, field: "dirId")}</td>
						
							<td>${fieldValue(bean: transferInstance, field: "ice")}</td>
						
							<td>${fieldValue(bean: transferInstance, field: "weekday")}</td>
						
							<td class="link">
								<g:link action="show" id="${transferInstance.id}" class="btn btn-small">Show &raquo;</g:link>
							</td>
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<bootstrap:paginate total="${transferInstanceTotal}" />
				</div>
			</div>

		</div>
	</body>
</html>
