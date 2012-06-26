<%@ page import="carmob.carma.Reservation" %>
<!doctype html>
<html>
  <head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'reservation.label', default: 'Reservation')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
  </head>
  <body>
    <div class="row-fluid">
      <div class="span12">
        <div class="page-header">
          <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
        </div>
        <g:if test="${flash.message}">
          <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
        </g:if>
        <g:hasErrors bean="${reservationInstance}">
          <bootstrap:alert class="alert-error">
            <ul>
              <g:eachError bean="${reservationInstance}" var="error">
              <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
              </g:eachError>
            </ul>
          </bootstrap:alert>
        </g:hasErrors>
        <fieldset>
          <g:form class="form-horizontal" action="edit" id="${reservationInstance?.id}" >
            <g:hiddenField name="version" value="${reservationInstance?.version}" />
            <fieldset>
              <f:with bean="reservationInstance">
                <f:field property="orderNumber"/>
                <f:field property="wagon"/>
                <f:field property="seat"/>
              </f:with>
              <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                  <i class="icon-ok icon-white"></i>
                  <g:message code="default.button.update.label" default="Update" />
                </button>
                <button type="submit" class="btn btn-danger" name="_action_delete" formnovalidate>
                  <i class="icon-trash icon-white"></i>
                  <g:message code="default.button.delete.label" default="Delete" />
                </button>
              </div>
            </fieldset>
          </g:form>
        </fieldset>
      </div>
    </div>
  </body>
</html>
