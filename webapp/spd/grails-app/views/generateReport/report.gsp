<hr/>
This is a report...
<hr/>

<table>
<thead>
</thead>
<tbody>
<g:each in="${result_grid}" var="row">
  <tr>
    <g:each in="${row}" var="value">
      <td>${value}</td>
    </g:each>
  </tr>
</g:each>
</tbody>
</table>
