<html>
<head>
	<g:if test="${params.styled=='true'}">
  	<meta name="layout" content="main"/>
  	</g:if>
  <title>${title}</title>
</head>
<body>
<g:if test="${params.styled!='true'}">
<hr/>
</g:if>
<h1>${title}</h1>
<g:if test="${params.styled!='true'}">
<hr/>
</g:if>
<table border="1" id="Grid">
  <thead>
    <tr>
      <th style="background-color:#ffffff"></th>
      <th colspan="${header_row.size()}" style="background-color:darkgray">${x_axis_label}</th>
    </tr>
    <tr>
      <th style="background-color:darkgray">${y_axis_label}</th>
      <g:each in="${header_row}" var="col">
        <th>${col}</th>
      </g:each>
    </tr>
  </thead>
  <tbody>
    <!--  <tr>
      <td rowspan="{result_grid.size()+1}">
        {y_axis_label}
      </td>
    </tr>-->

    <g:each in="${result_grid}" var="row">

      <g:if test="${row.type=='heading'}">
        <tr><td colspan="${header_row.size() + 1}"><b>${row.value}</b></td></tr>
      </g:if>
      <g:elseif test="${row.type=='subtotal'}">
        <tr>
          <td><b>${row.label}</b></td><g:each in="${row.values}" var="value"><td><b>${value}</b></td></g:each>
        </tr>
      </g:elseif>
      <g:else>
        <tr>
          <td>${row.label}</td><g:each in="${row.values}" var="value"><td>${value}</td></g:each>
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
<g:javascript>
$(function() {
    var table = $("#Grid");

    $(window).scroll(function() {
        var windowTop = $(window).scrollTop();

	//alert("window top: " + windowTop + " table.top : " + $("#Grid").offset().top);
        if (windowTop > table.offset().top) {
            $("thead", table).addClass("Fixed").css("top", windowTop);
        }
        else {
            $("thead", table).removeClass("Fixed");
        }
    });
 
});

</g:javascript>
</body>
