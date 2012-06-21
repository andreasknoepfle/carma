
<%@ page import="carmob.carma.User" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <title><g:message code="user.edit" default="Edit User" /></title>
  </head>
  <body>
    <div class="row-fluid">
      <div class="page-header">
        <h2>Benutzerprofil editieren:</h2>
      </div>
      <g:form method="post"  enctype="multipart/form-data">
        <g:hiddenField name="id" value="${userInstance?.id}" />
        <g:hiddenField name="version" value="${userInstance?.version}" />
        <div class="dialog">
          <table>
            <tbody>
              <tr class="prop">
                <g:if test="${userInstance?.avatar}">
                  <img class="avatar" src="${createLink(controller:'user', action:'avatar_image' ,id: userInstance.id)}" width="128" height="128"/>
                </g:if>
                <g:else>
                  <g:img class="avatar" uri="/images/default-avatar.png"/>
                </g:else>
              </tr>
              <tr class="prop">
                <td valign="top" class="name">
                  <label for="login"><g:message code="user.login" default="Name" />:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'login', 'errors')}">
                  <g:textField name="login" value="${fieldValue(bean: userInstance, field: 'login')}" />
                </td>
              </tr>
              <tr class="prop">
                <td valign="top" class="name">
                  <label for="email"><g:message code="user.email" default="E-Mail" />:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'email', 'errors')}">
                  <g:textField name="email" value="${fieldValue(bean: userInstance, field: 'email')}" />
                </td>
              </tr>
              <tr class="prop">
                <td valign="top" class="name">
                  <label for="phone"><g:message code="user.phone" default="Phone" />:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'phone', 'errors')}">
                  <g:textField name="phone" value="${fieldValue(bean: userInstance, field: 'phone')}" />
                </td>
              </tr>
              <tr class="prop">
                <td valign="top" class="name">
                  <label for="avatar"><g:message code="user.avatar" default="Avatar" />:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'avatar', 'errors')}">
                  <input type="file" id="avatar" name="avatar" />
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <div class="buttons">
          <span class="button">
            <g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}" />
          </span>
        </div>
      </g:form>
    </div>
  </body>
</html>
