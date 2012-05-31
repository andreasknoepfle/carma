
<%@ page import="carmob.carma.Direction" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'direction.label', default: 'Direction')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row-fluid">
			
			

			
				
				<div class="page-header">
					<h1>Wähle deine Richtung:</h1>
				</div>

				<g:if test="${flash.message}">
				<bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
				</g:if>
				
				<table class="table table-striped">
					
					<tbody>
					<g:each in="${directionList}" var="directionInstance">
						<tr>
                                                        <td class="link"><g:link action="select_transfer" params="[direction: directionInstance.id]" class="btn btn-small">${directionInstance}</g:link></td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				
			

		</div>
	</body>
</html>
