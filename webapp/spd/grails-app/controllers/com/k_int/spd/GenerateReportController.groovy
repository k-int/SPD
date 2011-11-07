package com.k_int.spd

import org.codehaus.groovy.grails.commons.ApplicationHolder
import grails.converters.*

class GenerateReportController {

  def index = { 
  }  

  def report = {

    // This controller currently mocks up inputs from a report generation screen which will revieve inputs on
    // the target domain class (Currently only Visits are supported) and the X and Y axis of the report. It then
    // dynamically generates the needed SQL to produce the reports
    def target_config_name='visit'
    def result = [:]
    def start_time = System.currentTimeMillis()
    result.result_grid = []

    def x_axis_name = params.x_axis_name; // 'schoolRegion'
    def y_axis_name = params.y_axis_name; // 'museum'	
    def omit_zero_sum_rows = params.omit_zero_sum_rows;
    def subtotals_top = ( ( params.subtotal_position == 'top' ) ? true : false );
    def groupby_subtotals

    if ( subtotals_top == true ) {
      result.result_grid.add(['type':'subtotal','label':"Totals"])
    }
	
    result.omitted_row_count = 0;

    // 1. Obtain reporting configuration
    def reporting_config = grailsApplication.config.reportingCfg

    // 2. Lookup target config
    def target_config = reporting_config[target_config_name]

    if ( target_config != null ) {
      // 3. Lookup x_axis config object
      def x_axis_config = target_config.reportingAxis[x_axis_name]

      // 3. Lookup y_axis config object
      def y_axis_config = target_config.reportingAxis[y_axis_name]

      log.debug("After config, x_axis_config = ${x_axis_config}, y_axis_config=${y_axis_config}")

      log.debug("Get hold of domain class identified in config : ${target_config.baseDomainClass}");
      def domain_class = grailsApplication.getArtefact("Domain",target_config.baseDomainClass);

      log.debug("Target domain class is ${domain_class}");

      log.debug("4. Determine the interval headings for the x axis");
      def x_axis_head = determineHeadings(domain_class, x_axis_config)

      log.debug("5. Determine the interval headings for the y axis");
      def y_axis_head = determineHeadings(domain_class, y_axis_config)

      if ( x_axis_head == null )
        log.error("X Axis Head failed to populate");

      if ( y_axis_config.keyProperties == null )
        log.error("Y Axis keyProperties are null");
      
      def y_axis_key_count = y_axis_config.keyProperties.size()

      // Group by subtotals are a 2d array, first index is the index of the y axis group-by field
      // second index is the x-axis values for that y-axis field
      groupby_subtotals = new long[y_axis_key_count][x_axis_head.size()]

      log.debug("Got both axis values...(x!=null: ${x_axis_head != null}, y!=null: ${y_axis_head != null}). generate report...");


      // Set up the structures we will use to do subtotals on the Y axis, as each key value changes..
      def last_row_columns = [];

      // header_row_index is used to keep track of the row which contains a header, which is used
      // if the user requested subtotals at the top of a subgroup instead of the bottom
      def header_row_index = [];

      result.header_row = []
      x_axis_head.each {
        result.header_row.add("${it[1]}")
      }

      // log.debug("x-axis: ${x_axis_head}");

      result.title = "${target_config.label} broken down by ${y_axis_config.label} (Vertical) against ${x_axis_config.label} (Horizontal)"
      result.x_axis_label = x_axis_config.label
      result.y_axis_label = y_axis_config.label

      def int total_y_values = y_axis_head.size();
      def int y_values_position = 0;

      // log.debug("${total_y_values} Values for Y axis");

      // y_axis_head is a list of the key values for every row in this report (Scalar or range).
      y_axis_head.each { y_axis_key ->
        // log.debug("Process row for key ${y_axis_key}")

        // This section deals with adding a heading row for groups of records. It detects changes in a group-by property and emits
        // a heading row ahead of any group records with spaces in the value cells.
        // We iterate through every key value for this row
        for ( int i=1; i<(y_axis_key.size()-1); i++ ) {

          // Skip the changing values in the row headings
          // If this is the first time through, initialise the last row keys list so we can do sensible comparisons.
          if ( last_row_columns.size() < i ) {
            last_row_columns.add("");
            header_row_index.add(0);
          }


          // If the value of the group-by key has changed, we need to emit totals
          if ( y_axis_key[i] != last_row_columns[i-1] ) {

            // If there are totals for the last group-by, we should emit them here!
            if ( ( last_row_columns[i-1] != null ) && ( last_row_columns[i-1].length() > 0 ) ) {
              log.debug("Adding subtotals[${i}]: ${groupby_subtotals}");
              def subtotals = []
              for ( int i2=0; i2<groupby_subtotals[i].size(); i2++) {
                subtotals.add(groupby_subtotals[i][i2]);
                groupby_subtotals[i][i2] = 0;
              }

              if ( subtotals_top == true ) {
                result.result_grid[header_row_index[i]].values = subtotals;
              }
              else {
                result.result_grid.add(['type':'subtotal','values':subtotals,'label':"Subtotal for ${last_row_columns[i-1]}"])
              }
            }

            // Emit the heading row for the next group
            result.result_grid.add(['type':'heading',
                                    'value':y_axis_key[i]])
            header_row_index[i] = result.result_grid.size()-1;

            // And update the status variable for tracking the next group
            last_row_columns[i-1]=y_axis_key[i]
          }
        }

        // Now emit the actual row values
        def row = [:]
        row.type = 'data'
        row.label = "${''.multiply(y_axis_key.size()-1)}${y_axis_key[y_axis_key.size()-1]}"
        row.key = y_axis_key[0]
        row.values = []
        row.sum = 0;

        def ctr = 0;
        x_axis_head.each { x_axis_key ->
          // This query will generate a result set containing a value for each column in the row
          def result_qry = domain_class.getClazz().createCriteria()

          def result_list = result_qry.list {
            target_config.aliases?.each { ad ->
              createAlias(ad.property,ad.alias)
            }
            and {
              // eq(y_axis_config.joinProperty,y_axis_key[0])
              buildAxisCriteria(result_qry,y_axis_config.criteria,y_axis_key[0])
              // eq(x_axis_config.joinProperty,x_axis_key[0])
              buildAxisCriteria(result_qry,x_axis_config.criteria,x_axis_key[0])
            }
            projections {
              sum(target_config.reportingProperty)
            }
          }

          // log.debug("qry: ${result_qry.getInstance().toString()}");

          def total = result_list.get(0);
          row.sum += total ?: 0;

          // Transpose the result set row to the appropriate column in the result set.
          row.values.add( total ?: 0 )

          // Add the value of this cell to the running count for each group-by expression (Eg, if we are iterating museums, increment the total for region)
          for ( int sti = 0; sti < groupby_subtotals.size(); sti++ ) {
            groupby_subtotals[sti][ctr] += total ?: 0;
          }
          ctr++;
          // log.debug(" -> Sum over y(${y_axis_key}, x(${x_axis_key}) = ${total}");
        }

        if ( ( row.sum > 0 ) || ( !omit_zero_sum_rows) )
          result.result_grid.add(row)
        else
          result.omitted_row_count++

        //if ( ( y_values_position++ % 50 ) == 0 ) {
        //  log.debug("Processed ${y_values_position} out of ${total_y_values} - ${y_axis_key}");
        //}
      }

      // At the end we need to output subtotals for the last group of records...
      // log.debug("Emit last subtotal row for ${last_row_columns}");
      for ( int i=0; i<last_row_columns.size(); i++ ) {
        if ( ( last_row_columns[i] != null ) && ( last_row_columns[i].length() > 0 ) ) {
          result.result_grid.add(['type':'subtotal','values':groupby_subtotals[i+1],'label':"Subtotal for ${last_row_columns[i]}"])
        }
      }
    }
    else {
      log.error("Unable to locate configuration with id ${target_config_name}");
    }

    // If the user wants totals at the top, fill in the grand total row
    if ( subtotals_top == true ) {
      result.result_grid[0].values = groupby_subtotals[0]
    }
    else {
      // Otherwise, add the totals to the bottom of the report
      result.result_grid.add(['type':'subtotal','values':groupby_subtotals[0],'label':"Totals"])
    }

    result.elapsed = System.currentTimeMillis() - start_time

    withFormat {
      html result
      csv { 
        response.setContentType('text/csv') 
        response.setHeader('Content-Disposition', 'attachment; filename=reportdata.csv') 
        result
      } 
    }
  }

  // Return a list containing lists of <key, column head, column head, column head>
  def determineHeadings(base_domain_class, axis_config) {
    def result = []
    log.debug("determineHeadings ${axis_config.label}...)");

    // We support 2 axis types: Simple (Where the values driving an axis come from a simple select, and projection, where they are derived through some 
    // set operations on the source table.
    switch ( axis_config.axisType ) {
      case 'simple':
        log.debug("Simple axis config - Obtaining values from ${axis_config.domainClass}")
        def axis_source_domain_class = grailsApplication.getArtefact("Domain",axis_config.domainClass);
        def y_axis_query = axis_source_domain_class.getClazz().createCriteria();
        log.debug("axis qry: ${y_axis_query.getInstance().toString()}");
        result = y_axis_query.list {
          axis_config.aliases?.each { ad ->
            createAlias(ad.property,ad.alias)
          }

          // Call the criteria builder with any specific filter criteria
          if ( axis_config.filterCriteria != null ) {
            buildAxisCriteria(y_axis_query, axis_config.filterCriteria, null)
          }

          // maxResults(10);
          projections {
            axis_config.keyProperties.each { kp ->
              property(kp)
            }
          }
          axis_config.sortOrder?.each { so ->
            order(so)
          }          
        }
        break;
      case 'projection':
        log.debug("Projection axis: Create criteria query, axis_path=${axis_config.entityAccessPath}, axis_domain=${axis_config.reportingDomain}");
        def axis_query = base_domain_class.getClazz().createCriteria();
        log.debug("axis qry: ${axis_query.getInstance().toString()}");
        result = axis_query.list {
          projections {
              if ( ( axis_config.entityAccessPath != null ) && ( axis_config.entityAccessPath.length() > 0 ) ) {
                "${axis_config.entityAccessPath}" {
                  distinct(["${axis_config.reportingDomain}","${axis_config.reportingDomain}"])
                }
              }
              else {
                distinct(["${axis_config.reportingDomain}","${axis_config.reportingDomain}"])
              }
          }
          order ("${axis_config.reportingDomain}", "asc")
        }
        break;
      default:
        log.error("Unhandled or missing config type for y axis");
        break;
    }
    log.debug("Result of determineHeadings ${base_domain_class}, ${axis_config.label} : count-${(result != null ? result.size() : 'result null')}");
    result
  }
  

  // This method takes an index configuration and builds the appropriate
  // subtree in the query builder.
  def buildAxisCriteria(builder, config, value) {
    // builder.eq(property,value)
    switch(config.type) {
      case 'join':
        builder."${config.table}" {
          buildAxisCriteria(builder, config.children, value)
        }
        break;
      case 'eq':
        builder.eq(config.col,value)
        break;
      case 'eqliteral':
        builder.eq(config.col,config.lit)
        break;
      default:
        break;
    }
  }
  
 
  def config = {
    def target_config_name='visit'
    def reporting_config = grailsApplication.config.reportingCfg
    def target_config = reporting_config[target_config_name]
    render target_config as JSON
  }

  def report2 = {
    // May try http://www.velocityreviews.com/forums/t118898-how-to-display-progress-bar-for-long-running-page-in-javascript.html for loading bar..
  }
}
