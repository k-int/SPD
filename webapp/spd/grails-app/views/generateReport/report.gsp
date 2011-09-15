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
      <tr>
        <th>${row.label}</th>
        <g:each in="${row.values}" var="value">
          <td>${value}</td>
        </g:each>
      </tr>
    </g:each>
  </tbody>
</table>
