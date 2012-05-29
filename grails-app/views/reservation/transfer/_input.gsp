
<table class="fieldcontain table table-striped">
  <thead>
    <tr>

  <g:sortableColumn property="arrival" title="${message(code: 'transfer.arrival.label', default: 'Arrival')}" />

  <g:sortableColumn property="departure" title="${message(code: 'transfer.departure.label', default: 'Departure')}" />

  <th class="header"><g:message code="transfer.dirId.label" default="Dir Id" /></th>

<g:sortableColumn property="ice" title="${message(code: 'transfer.ice.label', default: 'Ice')}" />

<g:sortableColumn property="weekday" title="${message(code: 'transfer.weekday.label', default: 'Weekday')}" />

<th></th>
</tr>
</thead>
<tbody>
<g:each in="${transferList}" var="transferInstance">
  <tr>
    <td><g:radio name="${property}" value="${transferInstance.id}" checked="${value==transferInstance}"/></td>
    <td>${fieldValue(bean: transferInstance, field: "arrival")}</td>

    <td>${fieldValue(bean: transferInstance, field: "departure")}</td>

    <td>${fieldValue(bean: transferInstance, field: "ice")}</td>

    <td>${fieldValue(bean: transferInstance, field: "weekday")}</td>

   
  </tr>
</g:each>
</tbody>
</table>