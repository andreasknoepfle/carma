
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
      <g:form>
      <g:hiddenField name="id" value="${userInstance?.id}" />
      <div class="dialog">
        <table>
          <tbody>
            <tr align="center">
              <g:if test="${userInstance?.avatar}">
                <img class="avatar" src="${createLink(controller:'user', action:'avatar_image')}" width="128" height="128" />
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
              <td valign="top" class="name"><g:message code="user.email" default="Email" />:</td>
              <td valign="top" class="value">${fieldValue(bean: userInstance, field: "email")}</td>
            </tr>
            <tr class="prop">
              <td valign="top" class="name"><g:message code="user.phone" default="Telefon" />:</td>
              <td valign="top" class="value">${fieldValue(bean: userInstance, field: "phone")}</td>
            </tr>
          </tbody>
        </table>
      </div>
      <g:if test="${ownProfile}">
        <div class="buttons">
          <span class="button">
            <g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" />
          </span>
        </div>
      </g:if>
    </g:form>
    </div>
  </body>
</html>
