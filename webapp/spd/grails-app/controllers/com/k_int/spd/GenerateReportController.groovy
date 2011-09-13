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
      def x_axis_config = target_config[x_axis_name]

      // 3. Lookup y_axis config object
      def y_axis_config = target_config[y_axis_name]

      // log.debug("After config, x_axis_config = ${x_axis_config}, y_axis_config=${y_axis_config}")

      // 4. Determine the interval headings for the x axis
      def x_axis_head = determineHeadings('base_domain_class', x_axis_config)

      // 5. Determine the interval headings for the y axis
      def y_axis_head = determineHeadings('base_domain_class', y_axis_config)

      log.debug("Get hold of domain class identified in config : ${target_config.baseDomainClass}");
      def domain_class = grailsApplication.getArtefact("Domain",target_config.baseDomainClass);

      log.debug("Create criteria query");
      def y_axis_query = domain_class.getClazz().createCriteria();

      log.debug("Query in scrollable results mode...");
      def y_axis_batch = y_axis_query.scroll {
        maxResults(30);
        projections {
          museum {
            distinct('id')
          }
        }
      }

      while ( y_axis_batch.next() ) {
        y_axis_batch.each() {
          log.debug("Result: ${y_axis_batch.getLong(0)}");
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
