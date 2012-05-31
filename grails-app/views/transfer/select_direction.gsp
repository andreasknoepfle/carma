
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
					<h2>Wählen deine Route:</h2>
				</div>
               
                                <g:each in="${directionList}" var="directionInstance">
                                  <div>
						<g:link action="list" params="[direction: directionInstance.id]" class="btn btn-small">${directionInstance.toEmString()}</g:link>
                                  </div></br>
                                </g:each>
					
				
			

		</div>
	</body>
</html>
