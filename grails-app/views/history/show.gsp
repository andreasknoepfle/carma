
<%@ page import="carmob.carma.History" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="history.show" default="Show History" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="history.list" default="History List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="history.new" default="New History" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="history.show" default="Show History" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${historyInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="history.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: historyInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="history.carma" default="Carma" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: historyInstance, field: "carma")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="history.carmachange" default="Carmachange" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: historyInstance, field: "carmachange")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="history.date" default="Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${historyInstance?.date}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="history.reservation" default="Reservation" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="reservation" action="show" id="${historyInstance?.reservation?.id}">${historyInstance?.reservation?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="history.type" default="Type" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: historyInstance, field: "type")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="history.user" default="User" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="user" action="show" id="${historyInstance?.user?.id}">${historyInstance?.user?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
