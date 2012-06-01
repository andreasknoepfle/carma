
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
			
			
			<div class="span12">

				<div class="page-header">
					<h1><g:message code="default.show.label" args="[entityName]" /></h1>
				</div>

				<g:if test="${flash.message}">
				<bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
				</g:if>

				<dl>
				
					<g:if test="${transferInstance?.arrival()}">
						<dt><g:message code="transfer.arrival.label" default="Arrival" /></dt>
						
							<dd>${transferInstance.arrival()}</dd>
						
					</g:if>
				
					<g:if test="${transferInstance?.departure()}">
						<dt><g:message code="transfer.departure.label" default="Departure" /></dt>
						
							<dd>${transferInstance.departure()}</dd>
						
					</g:if>
				
					<g:if test="${transferInstance?.dirId}">
						<dt><g:message code="transfer.dirId.label" default="Route" /></dt>
						
							<dd>${transferInstance.dirId}</dd>
						
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


			</div>

		</div>
	</body>
</html>
