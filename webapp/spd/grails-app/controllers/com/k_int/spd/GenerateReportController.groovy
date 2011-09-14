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

      // 4. Determine the interval headings for the x axis
      def x_axis_head = determineHeadings('base_domain_class', x_axis_config)

      // 5. Determine the interval headings for the y axis
      def y_axis_head = determineHeadings('base_domain_class', y_axis_config)

      log.debug("Get hold of domain class identified in config : ${target_config.baseDomainClass}");

      def domain_class = grailsApplication.getArtefact("Domain",target_config.baseDomainClass);

      log.debug("Query in scrollable results mode.... Y axis type is ${y_axis_config.axisType}");
      def y_axis_batch = null;

      // We support 2 axis types: Simple (Where the values driving an axis come from a simple select, and projection, where they are derived through some 
      // set operations on the source table.
      switch ( y_axis_config.axisType ) {
        case 'simple':
          log.debug("Simple axis config - Obtaining values from ${y_axis_config.domainClass}")
          def axis_source_domain_class = grailsApplication.getArtefact("Domain",y_axis_config.domainClass);
          def y_axis_query = axis_source_domain_class.getClazz().createCriteria();
          y_axis_batch = y_axis_query.scroll {
            maxResults(30);
            projections {
              property(y_axis_config.keyProperty)
            }
          }
          break;
        case 'projection':
          log.debug("Projection axis: Create criteria query, y_axis_path=${x_axis_config.entityAccessPath}, y_axis_domain=${x_axis_config.reportingDomain}");
          def y_axis_query = domain_class.getClazz().createCriteria();
          y_axis_batch = y_axis_query.scroll {
            maxResults(30);
            projections {
              "${y_axis_config.entityAccessPath}" {
                distinct("${y_axis_config.reportingDomain}")
              }
            }
          }
          break;
        default:
          log.error("Unhandled or missing config type for y axis");
          break;
      }

      // The y_axis query must yield a cursor of keys that can be used to control the per-row output of the report.
      // Depending upon the axis definition, these can be scalar or range values. Currently, only scalars are handled
      while ( y_axis_batch.next() ) {
        if ( 1==1 ) {  // If y_axis is scalar
          log.debug("Result: ${y_axis_batch.get(0)}");
        }
      }
    }
    else {
      log.error("Unable to locate configuration with id ${target_config_name}");
    }
  }

  def determineHeadings(base_domain_class, axis_config) {
    def result = []
    log.debug("determineHeadings(${base_domain_class},...)");
    
    result;
  }
}
