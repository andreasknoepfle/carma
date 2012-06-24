<%@ page import="carmob.carma.Reservation" %>
<!doctype html>
<html>
  <head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'reservation.label', default: 'Reservation')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
    <g:javascript library="jquery" />
  </head>
  <body>
    <div class="row-fluid">
      <div class="span12">
        <div class="page-header">
          <h2>Sitzplatzreservierung abgeben</h2>
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
        <g:form class="form-inline" action="select_date" >
          <div class="fieldcontain required">
            <label for="date">Datum:
              <span class="required-indicator">*</span>
            </label>
            <input type="text" id="datepicker" name="date" value="${new Date().format("dd.MM.yyyy")}" autocomplete="off" />
          </div>
          <div class="fieldcontain required">
            <label for="direction">Richtung:
              <span class="required-indicator">*</span>
            </label>
            <g:select name="direction" from="${directionList}" optionKey="id" id="direction"/>
          </div>
          <div class="form-actions">
            <button type="submit" class="btn btn-primary">
              Weiter <i class="icon-chevron-right icon-white"></i>
            </button>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>
