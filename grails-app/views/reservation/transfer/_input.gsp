
<table class="fieldcontain table table-striped">
  <thead>
    <tr>
      
   <th class="header"></th>
   <th class="header">Abfahrt</th>
    <th class="header">Anknunft</th>
    <th class="header">Linie</th>
    <th class="header">Wochentag</th>
</tr>
</thead>
<tbody>
<g:each in="${transferList}" var="transferInstance">
  <tr>
    <td><g:radio name="${property}" value="${transferInstance.id}" checked="${value==transferInstance}"/></td>
    <td>${transferInstance.departure()}</td>
    <td>${transferInstance.arrival()}</td>
    <td>${fieldValue(bean: transferInstance, field: "ice")}</td>
     <td>${transferInstance.weekday}</td>
  </tr>
</g:each>
</tbody>
</table>