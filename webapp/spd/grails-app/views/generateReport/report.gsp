<html>
<head>
  <title>${title}</title>
</head>
<body>
<hr/>
<h1>${title}</h1>
<hr/>

<table border="1">
  <thead>
    <tr>
      <th></th>
      <th></th>
      <th colspan="${header_row.size()}">${x_axis_label}</th>
    </tr>
    <tr>
      <th></th>
      <th></th>
      <g:each in="${header_row}" var="col">
        <th>${col}</th>
      </g:each>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td rowspan="${result_grid.size()+1}">
        ${y_axis_label}
      </td>
    </tr>

    <g:each in="${result_grid}" var="row">

      <g:if test="${row.type=='heading'}">
        <tr><td><b>${row.value}</b></td></tr>
      </g:if>
      <g:elseif test="${row.type=='subtotal'}">
        <tr><td><b>${row.label}</b></td></tr>
      </g:elseif>
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
    <li>${omitted_row_count} rows were omitted from this report because they had no data, and the report omit_zero_sum_rows parameter is set to ${params.omit_zero_sum_rows}</li>
  </g:if>
</ul>

</body>
