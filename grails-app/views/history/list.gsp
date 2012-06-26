
<%@ page import="carmob.carma.History" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="history.list" default="History List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="history.new" default="New History" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="history.list" default="History List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="history.id" />
                        
                   	    <g:sortableColumn property="carma" title="Carma" titleKey="history.carma" />
                        
                   	    <g:sortableColumn property="carmachange" title="Carmachange" titleKey="history.carmachange" />
                        
                   	    <g:sortableColumn property="date" title="Date" titleKey="history.date" />
                        
                   	    <th><g:message code="history.reservation" default="Reservation" /></th>
                   	    
                   	    <g:sortableColumn property="type" title="Type" titleKey="history.type" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${historyInstanceList}" status="i" var="historyInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${historyInstance.id}">${fieldValue(bean: historyInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: historyInstance, field: "carma")}</td>
                        
                            <td>${fieldValue(bean: historyInstance, field: "carmachange")}</td>
                        
                            <td><g:formatDate date="${historyInstance.date}" /></td>
                        
                            <td>${fieldValue(bean: historyInstance, field: "reservation")}</td>
                        
                            <td>${fieldValue(bean: historyInstance, field: "type")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${historyInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
