// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if(System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text/plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// whether to install the java.util.logging bridge for sl4j. Disable for AppEngine!
grails.logging.jul.usebridge = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// set per-environment serverURL stem for creating absolute links
environments {
    production {
        grails.serverURL = "http://spd.k-int.com/${appName}"
    }
    development {
        grails.serverURL = "http://localhost:8080/${appName}"
    }
    test {
        grails.serverURL = "http://localhost:8080/${appName}"
    }

}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console
    // appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}

    error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
           'org.codehaus.groovy.grails.web.pages', //  GSP
           'org.codehaus.groovy.grails.web.sitemesh', //  layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping', // URL mapping
           'org.codehaus.groovy.grails.commons', // core / classloading
           'org.codehaus.groovy.grails.plugins', // plugins
           'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'

    debug  'grails.app.controller.com.k_int',
           'grails.app.service.com.k_int',
           'grails.app.domain.com.k_int'

    warn   'org.mortbay.log'
}

reportingCfg = [
  'visit': [
    baseDomainClass:'com.k_int.spd.domain.Visit',
    reportingProperty:'partySize',
    label:'Total Visitors',
    aliases:[
      [ property:'school', alias:'sch1' ]
    ],
    reportingAxis: [
      schoolRegion : [
        axisType:'simple',
        label:'Region of the visiting school',
        resultType:'scalar',  // Scalar means the SQL driving this index generates unique key values (Eg RegionId) and not range queries (Eg dates)
        domainClass:'com.k_int.spd.domain.Region',
        keyProperties:['id','regionName'],
        reportingLabel:'regionName',
        sortOrder:['regionName'],
        joinProperty:'sch1.region.id'
      ],
      museum : [
        aliases:[
          [ property:'region', alias:'rgn1' ]
        ],
        axisType:'simple',
        label:'Museum (grouped by region)',
        resultType:'scalar',  // Scalar means the SQL driving this index generates unique key values (Eg RegionId) and not range queries (Eg dates)
        domainClass:'com.k_int.spd.domain.Museum',
        // If you define more than 1 display property (name, rgn1.regionname in this case, the report can subtotal on the outer headings
        keyProperties:['id','rgn1.regionName','name'],
        reportingLabel:'name',
        sortOrder:['rgn1.regionName','name'],
        joinProperty:'museum.id'
      ],
      visitYear : [
        axisType:'projection',
        label:'Year of visit',
        resultType:'scalar',  // Scalar means the SQL driving this index generates unique key values (Eg RegionId) and not range queries (Eg dates)
        reportingDomain:'visitYear',
        reportingLabel:'visitYear',
        joinProperty:'visitYear'
      ]
    ]
  ]
]
