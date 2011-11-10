// Place your Spring DSL code here

import org.codehaus.groovy.grails.commons.ApplicationHolder 

beans = {

  solrServerBean(org.apache.solr.client.solrj.impl.CommonsHttpSolrServer,application.config.ofs.solr.url) { // "http://localhost:8080/index/aggr"
  }

}
