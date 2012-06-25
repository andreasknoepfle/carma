
<%@ page import="carmob.carma.History" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="history.create" default="Create History" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="history.list" default="History List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="history.create" default="Create History" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${historyInstance}">
            <div class="errors">
                <g:renderErrors bean="${historyInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="carma"><g:message code="history.carma" default="Carma" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: historyInstance, field: 'carma', 'errors')}">
                                    <g:textField name="carma" value="${fieldValue(bean: historyInstance, field: 'carma')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="carmachange"><g:message code="history.carmachange" default="Carmachange" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: historyInstance, field: 'carmachange', 'errors')}">
                                    <g:textField name="carmachange" value="${fieldValue(bean: historyInstance, field: 'carmachange')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="date"><g:message code="history.date" default="Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: historyInstance, field: 'date', 'errors')}">
                                    <g:datePicker name="date" value="${historyInstance?.date}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reservation"><g:message code="history.reservation" default="Reservation" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: historyInstance, field: 'reservation', 'errors')}">
                                    <g:select name="reservation.id" from="${carmob.carma.Reservation.list()}" optionKey="id" value="${historyInstance?.reservation?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="history.type" default="Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: historyInstance, field: 'type', 'errors')}">
                                    <g:textField name="type" value="${fieldValue(bean: historyInstance, field: 'type')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="user"><g:message code="history.user" default="User" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: historyInstance, field: 'user', 'errors')}">
                                    <g:select name="user.id" from="${carmob.carma.User.list()}" optionKey="id" value="${historyInstance?.user?.id}"  />

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
