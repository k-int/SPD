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
        var firstx = "";
        var firsty = "";

        if ( config != null ) {
          // Iterate through the axis options adding options to the combo boxes
          for ( axis in config['visit'].reportingAxis ) {
            var axis_defn = config['visit'].reportingAxis[axis];
            var x_axis_combo = $('#x_axis_selection');
            var y_axis_combo = $('#y_axis_selection');
            if ( $.inArray('x', axis_defn.allowedAs ) != -1 ) {
              console.log("Adding "+axis+" to X options");
              x_axis_combo.append("<option value=\""+axis+"\">"+axis_defn.label+"</option>");
              if ( firstx == "" )
                firstx = axis;
            }
            if ( $.inArray('y', axis_defn.allowedAs ) != -1 ) {
              console.log("Adding "+axis+" to Y options");
              y_axis_combo.append("<option value=\""+axis+"\">"+axis_defn.label+"</option>");
              if ( firsty == "" )
                firsty = axis;
            }
          }
        }

        setHeadings('x',firstx);
        setHeadings('y',firsty);
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
        var v = control.value;
        // console.log("comboChange... "+control+" "+axis+" value="+v);
        setHeadings(axis, v);
      }
  
      function setHeadings(axis, v) {
        if ( axis == 'x' ) {
          $('#x_axis_header').html(config['visit'].reportingAxis[v].label)
          $('#xh1').html(config['visit'].reportingAxis[v].sampleHeadings[0])
          $('#xh2').html(config['visit'].reportingAxis[v].sampleHeadings[1])
          $('#xh3').html(config['visit'].reportingAxis[v].sampleHeadings[2])
          $('#xh4').html(config['visit'].reportingAxis[v].sampleHeadings[3])
        }
        else if ( axis == 'y' ) {
          $('#y_axis_header').html(config['visit'].reportingAxis[v].label)
          $('#yh1').html(config['visit'].reportingAxis[v].sampleHeadings[0])
          $('#yh2').html(config['visit'].reportingAxis[v].sampleHeadings[1])
          $('#yh3').html(config['visit'].reportingAxis[v].sampleHeadings[2])
          $('#yh4').html(config['visit'].reportingAxis[v].sampleHeadings[3])
        }
      }

    </g:javascript>
  </head>
  <body>
    <h1>Report Specification</h1>
    <p>Please note that the report will be created in a new browser window/tab and may take several minutes to render.</p>
    <br/>
    <g:form controller="generateReport" action="report" method="get" target="_new">
      <g:hiddenField name="target_config" value="visit"/>
      <ul>
        <li>
          <label for="omit_zero_sum_rows">Hide empty rows</label>
          <g:select name="omit_zero_sum_rows" from="[true,false]" class="medium"/>
        </li>
        <li>
          <label for="format">Format</label>
          <g:select name="format" from="['html','html(styled)','csv']" class="medium"/>
        </li>
        <li>
          <label for="format">Subtotal Position</label>
          <g:select name="subtotal_position" from="['top','bottom']" class="medium"/>
        </li>
      </ul>

      <table>
        <tr>
          <td colspan="7">Header</td>
        </tr>
      
        <tr>
          <td rowspan="3" colspan="3"></td>
          <td colspan="6" width="100%">X Axis Configuration<br/><select id="x_axis_selection" name="x_axis_name" onchange="comboChange(this,'x');" value=""></select></td></tr>
        </tr>
        <tr>
          <th id="x_axis_header" colspan="4"></th>
        </tr>

        <tr></td><th id="xh1">col1</th><th id="xh2">col2</th><th id="xh3">col3</th><th id="xh4">col4</th></tr>

        <tr>
          <td rowspan="4">Y Axis Configuration<br/><select id="y_axis_selection" name="y_axis_name" onchange="comboChange(this,'y');"> value=""</select></td>
          <th rowspan="4" id="y_axis_header"></th>
          <th id="yh1">row1</th>
          <td>---</td>
          <td>---</td>
          <td>---</td>
          <td>---</td>
        </tr>

        <tr><th id="yh2">row2</th><td>---</td><td>---</td><td>---</td><td>---</td></tr>
        <tr><th id="yh3">row3</th><td>---</td><td>---</td><td>---</td><td>---</td></tr>
        <tr><th id="yh4">row4</th><td>---</td><td>---</td><td>---</td><td>---</td></tr>

      </table>
      <input type="submit"/>
    </g:form>
  </body>
</html>
