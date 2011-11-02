import com.k_int.sim.*;
import grails.plugins.nimble.InstanceGenerator
import grails.plugins.nimble.core.LevelPermission
import grails.plugins.nimble.core.Role
import grails.plugins.nimble.core.Group
import grails.plugins.nimble.core.AdminsService
import grails.plugins.nimble.core.UserService
import com.k_int.spd.domain.*

class BootStrap {

  def grailsApplication
  def nimbleService
  def userService
  def adminsService

  def init = { servletContext ->

    // The following must be executed before any other nimble code
    nimbleService.init()

    println "Verifying admin account"
    def userLookup = User.findByUsername('admin')
    if ( userLookup == null ) {
      println "Create admin account..."
      def admins = Role.findByName(AdminsService.ADMIN_ROLE)
      def admin = InstanceGenerator.user()
      admin.username = "admin"
      admin.pass = "admiN123!"
      admin.passConfirm = "admiN123!"
      admin.enabled = true

      def adminProfile = InstanceGenerator.profile()
      adminProfile.fullName = "Administrator"
      adminProfile.owner = admin
      admin.profile = adminProfile

      // userLookup = grails.plugins.nimble.core.UserBase.findByUsername(admin.username)
      def savedAdmin = userService.createUser(admin)

      if (savedAdmin.hasErrors()) {
        savedAdmin.errors.each {
          log.error(it)
        }
        throw new RuntimeException("Error creating administrator")
      }

      adminsService.add(admin)
    }

    // Reference Data
    def keystage_classifier = Classifier.findByClassnIdentifier('keystage') ?: new Classifier(classnIdentifier:'keystage',classificationLevel:0).save();
    def kse = Classifier.findByParentAndClassnIdentifier(keystage_classifier, 'EarlyYears') ?: new Classifier(parent:keystage_classifier,classnIdentifier:'EarlyYears',classificationLevel:1).save();
    def ks1 = Classifier.findByParentAndClassnIdentifier(keystage_classifier, 'KS1') ?: new Classifier(parent:keystage_classifier,classnIdentifier:'KS1',classificationLevel:1).save();
    def ks2 = Classifier.findByParentAndClassnIdentifier(keystage_classifier, 'KS2') ?: new Classifier(parent:keystage_classifier,classnIdentifier:'KS2',classificationLevel:1).save();
    def ks3 = Classifier.findByParentAndClassnIdentifier(keystage_classifier, 'KS3') ?: new Classifier(parent:keystage_classifier,classnIdentifier:'KS3',classificationLevel:1).save();
    def ks4 = Classifier.findByParentAndClassnIdentifier(keystage_classifier, 'KS4') ?: new Classifier(parent:keystage_classifier,classnIdentifier:'KS4',classificationLevel:1).save();
    def ksp = Classifier.findByParentAndClassnIdentifier(keystage_classifier, 'Post16') ?: new Classifier(parent:keystage_classifier,classnIdentifier:'Post16',classificationLevel:1).save();
  
  println "Region Count : " + Region.count()
  
  if(!Region.count())
  {
    println "Region Count null so creating a region"
    
    def temp_region = new Region(regionName:"North West")
    temp_region.save();
  }
  }

  def destroy = {
  }
}
