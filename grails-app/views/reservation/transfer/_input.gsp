<br/>
<br/>
<div class="row"><div class="well span6">
<table class="table table-striped table-bordered table-condensed">
  <thead>
    <tr>
      
   <th class="header"></th>
   <th class="header">Abfahrt</th>
    <th class="header">Anknunft</th>
    <th class="header">Linie</th>
</tr>
</thead>
<tbody>
<g:each in="${transferList}" var="transferInstance">
  <tr>
    <td><g:radio name="${property}" value="${transferInstance.id}" checked="${value==transferInstance}"/></td>
    <td>${transferInstance.departure()}</td>
    <td>${transferInstance.arrival()}</td>
    <td>${fieldValue(bean: transferInstance, field: "ice")}</td>
  </tr>
</g:each>
</tbody>
</table>
</div></div>