<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'museum.label', default: 'Museum')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
    <g:javascript>
      var config

      $(document).ready(function() {	
        $('.nav-report').addClass('active');

        config = loadConfig();

        if ( config != null ) {
          // Iterate through the axis options adding options to the combo boxes
          for ( axis in config['visit'].reportingAxis ) {
            var axis_defn = config['visit'].reportingAxis[axis];
            var x_axis_combo = $('#x_axis_selection');
            var y_axis_combo = $('#y_axis_selection');
            if ( $.inArray('x', axis_defn.allowedAs ) != -1 ) {
              console.log("Adding "+axis+" to X options");
              x_axis_combo.append("<option value=\""+axis+"\">"+axis_defn.label+"</option>");
            }
            if ( $.inArray('y', axis_defn.allowedAs ) != -1 ) {
              console.log("Adding "+axis+" to Y options");
              y_axis_combo.append("<option value=\""+axis+"\">"+axis_defn.label+"</option>");
            }
          }
        }

      });

      function loadConfig() {
        console.log("Loading configuration from ${createLink(controller:'generateReport',action:'config')}");
        var conf
        $.ajax({
          async:false,
          url: "${createLink(controller:'generateReport',action:'config')}",
          success: function(data){
            conf=data;
          }
        });
        console.log("Result: %o", conf);
        return conf;
      }

      function comboChange(control, axis) {
        console.log("comboChange... "+axis);
      }

    </g:javascript>
  </head>
  <body>
    <h1>Report Specification</h1>
    <p>Please note that the report will be created in a new browser window/tab and may take several minutes to render.</p>
    <br/>
    <form target="_new" method="get" >
      <g:hiddenField name="target_config" value="visit"/>
      <table>
        <tr>
          <td colspan="5">Header</td>
        </tr>
      
        <tr>
          <td></td><td colspan="5">X Axis Configuration<br/><select id="x_axis_selection" name="x_axis_name" onchange="comboChange(this,'x');"></select></td></tr>
        </tr>

        <tr><td></td><td></td><th>col1</th><th>col2</th><th>col3</th><th>col4</th></tr>

        <tr>
          <td rowspan="4">Y Axis Configuration<br/><select id="y_axis_selection" name="y_axis_name" onchange="comboChange(this,'y');"></select></td>
          <th>row1</th>
          <td>---</td>
          <td>---</td>
          <td>---</td>
          <td>---</td>
        </tr>

        <tr><th>row2</th><td>---</td><td>---</td><td>---</td><td>---</td></tr>
        <tr><th>row3</th><td>---</td><td>---</td><td>---</td><td>---</td></tr>
        <tr><th>row4</th><td>---</td><td>---</td><td>---</td><td>---</td></tr>

      </table>
    </form>
  </body>
</html>
