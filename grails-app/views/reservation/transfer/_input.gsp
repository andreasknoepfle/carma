<br/>
<br/>
<div class="row"><div class="span5 offset1">

    <div class="accordion" id="transfers">
      <g:set var="counter" value="${0}" />
      <g:each in="${transferList}" var="transferListPart">
        <div class="accordion-group">
          <a class="accordion-toggle" data-toggle="collapse" data-parent="#transfers" href="#collapse${counter}">
            <div class="accordion-heading">
              <g:if test="${counter==0}">
                0:00 - 9:59
              </g:if>
              <g:elseif test="${counter==1}">
                10:00 - 13:59
              </g:elseif>
              <g:elseif test="${counter==2}">
                14:00 - 17:59
              </g:elseif>
              <g:else>
                18:00 - 23:59
              </g:else>
            </div>
          </a>
          <div id="collapse${counter}" class="accordion-body collapse" style="height: 0px; ">
            <div class="accordion-inner">
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
                <g:each in="${transferListPart}" var="transferInstance">
                  <tr>
                    <td><g:radio name="${property}" value="${transferInstance.id}" checked="${value==transferInstance}"/></td>
                  <td>${transferInstance.departure()}</td>
                  <td>${transferInstance.arrival()}</td>
                  <td>${fieldValue(bean: transferInstance, field: "ice")}</td>
                  </tr>
                </g:each>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <g:set var="counter" value="${counter + 1}" /><br/>
      </g:each>
    </div>





  </div></div>