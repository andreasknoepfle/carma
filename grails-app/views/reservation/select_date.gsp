<%@ page import="carmob.carma.Reservation" %>
<!doctype html>
<html>
  <head>
    <meta name="layout" content="main">
  <g:set var="entityName" value="${message(code: 'reservation.label', default: 'Reservation')}" />
  <title><g:message code="default.create.label" args="[entityName]" /></title>
</head>
<body>
  <div class="row-fluid">
    <div class="span12">
      <div class="page-header">
        <h1>Sitzplatzreservierung abgeben</h1>
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
        <g:form class="form-horizontal" action="select_date" >
          <fieldset>
            <f:with bean="reservationInstance">
              <f:field property="date" label="Datum"/>
            </f:with>
            <div class="fieldcontain required">
              <label for="direction">Richtung:
                <span class="required-indicator">*</span>
              </label>
              <g:select name="direction"
                        from="${directionList}"
                        optionKey="id" id="direction"/>
            </div>



            <div class="form-actions">
              <button type="submit" class="btn btn-primary">
                <i class="icon-ok icon-white"></i>
                Weiter
              </button>
            </div>
          </fieldset>
        </g:form>
      </fieldset>

    </div>

  </div>
</body>
</html>
