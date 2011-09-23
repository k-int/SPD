<hr/>
This is a report...
<hr/>

<table>
  <thead>
    <tr>
      <th></th>
      <g:each in="${header_row}" var="col">
        <th>${col}</th>
      </g:each>
    </tr>
  </thead>
  <tbody>
    <g:each in="${result_grid}" var="row">

      <g:if test="${row.type=='heading'}">
        <tr><td><b>${row.value}</b></td></tr>
      </g:if>
      <g:else>
        <tr>
          <td>${row.label}</td>
          <g:each in="${row.values}" var="value">
            <td>${value}</td>
          </g:each>
        </tr>
      </g:else>

    </g:each>
  </tbody>
</table>
