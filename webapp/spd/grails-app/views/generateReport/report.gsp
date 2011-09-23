<hr/>
<h1>${title}</h1>
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

<h2>Notes</h2>

<ul>
  <g:if test="${(omitted_row_count != null) && (omitted_row_count > 0)}">
    <li>${omitted_row_count} rows were omitted from this report because they had no data, and the report omit_zero_sum_rows parameter is set to true</li>
  </g:if>
</ul>

