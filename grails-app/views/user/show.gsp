
<%@ page import="carmob.carma.User" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <title><g:message code="user.show" default="Show User" /></title>
  </head>
  <body>
    <div class="row-fluid">
      <div class="page-header">
        <h2>Benutzerprofil:</h2>
      </div>
      <g:if test="${ownProfile}">
        <g:if test="${carma == 0}">
          <div class="alert alert-block">
            <a class="close" data-dismiss="alert" href="#">×</a>
            <h4 class="alert-heading">Das kann noch besser werden! Sammle mehr Carma Punkte!</h4>
        </g:if>
        <g:if test="${carma != 0}">
          <div class="alert alert-success">
            <a class="close" data-dismiss="alert" href="#">×</a>
            <h4 class="alert-heading">Herzlichen Glückwunsch!</h4>
        </g:if>
        Du besitzt ${carma} Carma Punkte! Sammle mehr Carma-Punkte um Reservierungen vor allen anderen buchen zu können.
    </div>
  </g:if>
<g:form>
  <g:hiddenField name="id" value="${userInstance?.id}" />
  <div class="dialog">
    <table>
      <tbody>
        <tr align="center">
      <g:if test="${userInstance?.avatar}">
        <img class="avatar" src="${createLink(controller:'user', action:'avatar_image', id:userInstance.id)}" width="128" height="128" />
      </g:if>
      <g:else>
        <g:img  class="avatar" uri="/images/default-avatar.png"/>
      </g:else>
      </tr>
      <tr class="prop">
        <td valign="top" class="name"><g:message code="user.login" default="Login" />:</td>
      <td valign="top" class="value">${fieldValue(bean: userInstance, field: "login")}</td>
      </tr>
      <tr class="prop">
        <td valign="top" class="name"><g:message code="user.email" default="E-Mail" />:</td>
      <td valign="top" class="value">${fieldValue(bean: userInstance, field: "email")}</td>
      </tr>
      <tr class="prop">
        <td valign="top" class="name"><g:message code="user.phone" default="Telefon" />:</td>
      <td valign="top" class="value">${fieldValue(bean: userInstance, field: "phone")}</td>
      </tr>
      </tbody>
    </table>
  </div><br/>
  <g:if test="${ownProfile}">
    <div class="buttons">
      <span class="button">
        <g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" />
      </span>
    </div>
  </g:if>
</g:form>
</div>
          <g:if test="${ownProfile}">
<h3>Letzte Aktivitäten</h3>
<table class="table table-striped">
  <thead>
    <tr>
      <th>Datum</th>
      <th>Aktivität</th>
      <th>Carma</th>
    </tr>
  </thead>
  <tbody>
  <g:each in="${historyInstanceList}" var="historyInstance">
    <tr>
      <td><g:formatDate format="dd.MM.yyyy" date="${historyInstance.date}"/></td>
      <td> <g:if test="${historyInstance.reservation}">
        <a href="${createLink(controller:'reservation', action:'show', id: historyInstance.reservation.id)}">${fieldValue(bean: historyInstance, field: "type")}</a>
         </g:if>
          <g:else>
            ${fieldValue(bean: historyInstance, field: "type")}
          </g:else>
      </td>
      <td>${fieldValue(bean: historyInstance, field: "carma")} (${fieldValue(bean: historyInstance, field: "carmachange")})</td>
    </tr>
  </g:each>
</tbody>
</table>
        <div class="pagination">
          <bootstrap:paginate total="${historyInstanceTotal}"/>
        </div>
</g:if>
</body>
</html>
