<%@ page import="carmob.carma.Direction" %>
<!doctype html>
<html>
  <head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'direction.label', default: 'Direction')}" />
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
          <g:if test="${directionInstance?.from}">
            <dt><g:message code="direction.from.label" default="From" /></dt>
            <dd><g:link controller="city" action="show" id="${directionInstance?.from?.id}">${directionInstance?.from?.encodeAsHTML()}</g:link></dd>
          </g:if>
          <g:if test="${directionInstance?.to}">
            <dt><g:message code="direction.to.label" default="To" /></dt>
            <dd><g:link controller="city" action="show" id="${directionInstance?.to?.id}">${directionInstance?.to?.encodeAsHTML()}</g:link></dd>
          </g:if>
        </dl>
        <g:form>
          <g:hiddenField name="id" value="${directionInstance?.id}" />
          <div class="form-actions">
            <g:link class="btn" action="edit" id="${directionInstance?.id}">
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
