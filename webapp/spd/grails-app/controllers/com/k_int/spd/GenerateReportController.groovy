package com.k_int.spd

import org.codehaus.groovy.grails.commons.ApplicationHolder

class GenerateReportController {

  def index = { 
  }

  def report = {

    // This controller currently mocks up inputs from a report generation screen which will revieve inputs on
    // the target domain class (Currently only Visits are supported) and the X and Y axis of the report. It then
    // dynamically generates the needed SQL to produce the reports
    def target_config_name='visit'
    def result = [:]
    result.result_grid = []

    def x_axis_name = 'schoolRegion'
    def y_axis_name = 'museum'

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

      // 4. Determine the interval headings for the x axis
      def x_axis_head = determineHeadings(domain_class, x_axis_config)

      // 5. Determine the interval headings for the y axis
      def y_axis_head = determineHeadings(domain_class, y_axis_config)

      result.header_row = []
      x_axis_head.each {
        result.header_row.add("${it}")
      }

      def int total_y_values = y_axis_head.size();
      def int y_values_position = 0;

      y_axis_head.each { y_axis_key ->
        // log.debug("Process row for key ${y_axis_key}")

        def row = [:]
        row.label = "key:${y_axis_key}"
        row.key = y_axis_key
        row.values = []

        row.values.add(y_axis_key)

        x_axis_head.each { x_axis_key ->
          // log.debug(" -> Sum over y(${y_axis_config.joinProperty})=${y_axis_key}, x(${x_axis_config.joinProperty})=${x_axis_key}");
          def result_qry = domain_class.getClazz().createCriteria()
          def result_list = result_qry.list {
            target_config.aliases.each { ad ->
              createAlias(ad.property,ad.alias)
            }
            and {
              eq(y_axis_config.joinProperty,y_axis_key)
              eq(x_axis_config.joinProperty,x_axis_key)
            }
            projections {
              sum(target_config.reportingProperty)
            }
          }
          def total = result_list.get(0);
          row.values.add( total ?: 0 )
        }

        result.result_grid.add(row)
        log.debug("Processed ${y_values_position++} out of ${total_y_values}");
      }
    }
    else {
      log.error("Unable to locate configuration with id ${target_config_name}");
    }

    result
  }

  def determineHeadings(base_domain_class, axis_config) {
    def result = []
    log.debug("determineHeadings(${base_domain_class},...)");

    // We support 2 axis types: Simple (Where the values driving an axis come from a simple select, and projection, where they are derived through some 
    // set operations on the source table.
    switch ( axis_config.axisType ) {
      case 'simple':
        log.debug("Simple axis config - Obtaining values from ${axis_config.domainClass}")
        def axis_source_domain_class = grailsApplication.getArtefact("Domain",axis_config.domainClass);
        def y_axis_query = axis_source_domain_class.getClazz().createCriteria();
        result = y_axis_query.list {
          // maxResults(10);
          projections {
            property(axis_config.keyProperty)
          }
        }
        break;
      case 'projection':
        log.debug("Projection axis: Create criteria query, y_axis_path=${x_axis_config.entityAccessPath}, y_axis_domain=${x_axis_config.reportingDomain}");
        def axis_query = base_domain_class.getClazz().createCriteria();
        result = axis_query.list {
          projections {
            "${axis_config.entityAccessPath}" {
              distinct("${axis_config.reportingDomain}")
            }
          }
        }
        break;
      default:
        log.error("Unhandled or missing config type for y axis");
        break;
    }
    
    withFormat {
      html result
      csv { 
        response.setContentType('text/csv') 
        response.setHeader('Content-Disposition', 'attachment; filename=reportdata.csv') 
        result
      } 
    }
  }
}
