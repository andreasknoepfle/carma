
<%@ page import="carmob.carma.Transfer" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'transfer.label', default: 'Transfer')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row-fluid">
			
			<div class="span3">
				<div class="well">
					<ul class="nav nav-list">
						<li class="nav-header">${entityName}</li>
						<li>
							<g:link class="list" action="list">
								<i class="icon-list"></i>
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
					<h1><g:message code="default.show.label" args="[entityName]" /></h1>
				</div>

				<g:if test="${flash.message}">
				<bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
				</g:if>

				<dl>
				
					<g:if test="${transferInstance?.active}">
						<dt><g:message code="transfer.active.label" default="Active" /></dt>
						
							<dd><g:formatBoolean boolean="${transferInstance?.active}" /></dd>
						
					</g:if>
				
					<g:if test="${transferInstance?.arrival}">
						<dt><g:message code="transfer.arrival.label" default="Arrival" /></dt>
						
							<dd><g:fieldValue bean="${transferInstance}" field="arrival"/></dd>
						
					</g:if>
				
					<g:if test="${transferInstance?.departure}">
						<dt><g:message code="transfer.departure.label" default="Departure" /></dt>
						
							<dd><g:fieldValue bean="${transferInstance}" field="departure"/></dd>
						
					</g:if>
				
					<g:if test="${transferInstance?.dirId}">
						<dt><g:message code="transfer.dirId.label" default="Dir Id" /></dt>
						
							<dd><g:link controller="direction" action="show" id="${transferInstance?.dirId?.id}">${transferInstance?.dirId?.encodeAsHTML()}</g:link></dd>
						
					</g:if>
				
					<g:if test="${transferInstance?.ice}">
						<dt><g:message code="transfer.ice.label" default="Ice" /></dt>
						
							<dd><g:fieldValue bean="${transferInstance}" field="ice"/></dd>
						
					</g:if>
				
					<g:if test="${transferInstance?.weekday}">
						<dt><g:message code="transfer.weekday.label" default="Weekday" /></dt>
						
							<dd><g:fieldValue bean="${transferInstance}" field="weekday"/></dd>
						
					</g:if>
				
				</dl>

				<g:form>
					<g:hiddenField name="id" value="${transferInstance?.id}" />
					<div class="form-actions">
						<g:link class="btn" action="edit" id="${transferInstance?.id}">
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
