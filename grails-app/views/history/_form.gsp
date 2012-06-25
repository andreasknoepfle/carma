<%@ page import="carmob.carma.History" %>



<div class="fieldcontain ${hasErrors(bean: historyInstance, field: 'carma', 'error')} required">
	<label for="carma">
		<g:message code="history.carma.label" default="Carma" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="carma" value="${fieldValue(bean: historyInstance, field: 'carma')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: historyInstance, field: 'carmachange', 'error')} required">
	<label for="carmachange">
		<g:message code="history.carmachange.label" default="Carmachange" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="carmachange" value="${fieldValue(bean: historyInstance, field: 'carmachange')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: historyInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="history.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" value="${historyInstance?.date}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: historyInstance, field: 'reservation', 'error')} required">
	<label for="reservation">
		<g:message code="history.reservation.label" default="Reservation" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="reservation.id" from="${carmob.carma.Reservation.list()}" optionKey="id" value="${historyInstance?.reservation?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: historyInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="history.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${fieldValue(bean: historyInstance, field: 'type')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: historyInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="history.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="user.id" from="${carmob.carma.User.list()}" optionKey="id" value="${historyInstance?.user?.id}"  />

</div>

