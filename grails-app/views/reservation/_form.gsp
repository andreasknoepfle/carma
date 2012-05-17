<%@ page import="carmob.carma.Reservation" %>



<div class="fieldcontain ${hasErrors(bean: reservationInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="reservation.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${reservationInstance?.date}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: reservationInstance, field: 'orderNumber', 'error')} ">
	<label for="orderNumber">
		<g:message code="reservation.orderNumber.label" default="Order Number" />
		
	</label>
	<g:textField name="orderNumber" value="${reservationInstance?.orderNumber}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: reservationInstance, field: 'seat', 'error')} required">
	<label for="seat">
		<g:message code="reservation.seat.label" default="Seat" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="seat" required="" value="${fieldValue(bean: reservationInstance, field: 'seat')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: reservationInstance, field: 'wagon', 'error')} required">
	<label for="wagon">
		<g:message code="reservation.wagon.label" default="Wagon" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="wagon" required="" value="${fieldValue(bean: reservationInstance, field: 'wagon')}"/>
</div>

