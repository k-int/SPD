package com.k_int.spd

import com.k_int.spd.domain.*

import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.CommonsHttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.params.ModifiableSolrParams;
import org.apache.solr.common.*;
import grails.converters.*
import groovy.text.Template
import groovy.text.SimpleTemplateEngine
import groovy.xml.MarkupBuilder
import org.codehaus.groovy.grails.commons.ApplicationHolder

class LDResolutionController {

  def solrServerBean

  def index = { 
    log.debug("index");
  }

  def resolveMuseums = {
    log.debug("resolveMuseums");
    solrQry();
  }


  def resolveSchools = {
    log.debug("resolveSchools");
  }

  def solrQry() {
    ModifiableSolrParams solr_params = new ModifiableSolrParams();
    def unique_matched = 0;
    def matched_zero_by_postcode_alone = 0;
    def matched_multiple_by_postcode = 0;

    solr_params.set("q", "record_type:institution AND institution_sector:Museums")
    solr_params.set("start", 0);
    solr_params.set("rows", "50");

    println "solr params : ${solr_params}"
    QueryResponse response = solrServerBean.query(solr_params);
    SolrDocumentList sdl = response.getResults();
    int record_count = sdl.getNumFound();
    int start = 0;
    int records_remaining = record_count;
    int batch_size = response.getResults().size()

    log.debug("Located ${record_count} records batch size = ${batch_size}");

    while ( response.getResults().size() > 0 ) { 
      response.getResults().each{ rec ->
        log.debug("Record ${start} (unique:${unique_matched}/zero:${matched_zero_by_postcode_alone}/many:${matched_multiple_by_postcode})");

        // See if we can locate a record for the museum with postcode and name...
        log.debug("rec ${rec['dc.title']} ${rec['aggregator.internal.id']} ${rec['dc.identifier']} ${rec['unparsed.postcode']}");

        def postcode = rec['unparsed.postcode']
        if ( ( postcode != null ) && ( postcode.length() > 0 ) ) {
          def located_museums = Museum.findAllByPostcode(postcode);
          switch ( located_museums.size() ) {
            case 0:
              matched_zero_by_postcode_alone++;
              log.debug("Create new museum for ${rec['dc.title']} Region = ${rec['oai_is.mlaRegion']}");
              def new_museum = new Museum(name:rec['dc.title'],
                                          postcode:rec['unparsed.postcode'],
                                          CultureGridInternalId:rec['aggregator.internal.id'], 
                                          InstitutionId:rec['dc.identifier'], 
                                          region:null).save()
              break;
            case 1:
              log.debug("Located museum by unique postcode match ${located_museums[0].name} ${located_museums[0].id} ");
              located_museums[0].CultureGridInternalId = rec['aggregator.internal.id']
              located_museums[0].InstitutionId = rec['dc.identifier']
              located_museums[0].save()
              unique_matched++
              break;
            default:
              log.debug("Postcode matching found ${located_museums.size()} records");
              matched_multiple_by_postcode++
              def name_from_cg = cleanString(rec['dc.title'])

              located_museums.each { lm ->
                def name_from_db = cleanString(lm.name)

                if ( name_from_cg == name_from_db ) {
                  log.debug("${name_from_db} == ${name_from_cg}");

                  lm.CultureGridInternalId = rec['aggregator.internal.id']
                  lm.InstitutionId = rec['dc.identifier']
                  lm.save()
                }
                else {
                  // Create an alert - The user will need to manually assign the appropriate reference
                  log.debug("${name_from_db} != ${name_from_cg}");
                  def a = new Alert(code:'CoRefFailure',message:'Failed to coreference museum',alert:"${rec['aggregator.internal.id']},${rec['dc.identifier']}").save()
                }
              }
              break;
          }
        }
        start++;
        records_remaining--;
      }
      // Load next batch
      solr_params.set("start", start);
      response = solrServerBean.query(solr_params);
      sdl = response.getResults();
    }

    // solr_params.set("start",params.offset);
    // solr_params.set("rows",params.max);
    // solr_params.set("sort",params.sort)
    // solr_params.set("sort","modified desc")
    // solr_params.set("facet","true")
    // solr_params.set("facet.field","extra_index_words_s","flags","authority")
    // solr_params.set("facet.field","restp", "dc.subject.orig_s","flags","authority_shortcode" )
    // solr_params.set("facet.limit",30)
    // solr_params.set("facet.mincount",1)


    // println("solr response = " + response);

    // if ( record_count > 0 ) {
    //  SolrDocument doc = sdl.get(0);
    //}
    //sdl
  }

  def cleanString(str) {
    def result = str.toLowerCase();
    result = result.replaceAll("\\(the\\)","");
    result = result.replaceAll("'","");
    result = result.replaceAll("\"","");
    result = result.replaceAll("  "," ");
    result = result.replaceAll("  "," ");
    result = result.replaceAll("  "," ");
    result.trim();
  }
}
