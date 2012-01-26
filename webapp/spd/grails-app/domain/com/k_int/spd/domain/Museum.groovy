package com.k_int.spd.domain

import java.util.List;

class Museum {

  String name
  Long oldSpdId
  Region region;
  String postcode

  // For linking to other databases
  String CultureGridInternalId
  String InstitutionId
  
  static hasMany = [affiliates:Affiliation]

  static constraints = {
    oldSpdId(nullable:true)
    region(nullable:true)
    CultureGridInternalId(nullable:true)
    InstitutionId(nullable:true)
  }

  List allAffiliates()
  {
	  return affiliates.collect{it.user}
  }
  
  List addToAffiliates(User user)
  {
	  Affiliation.link(user, this)
	  return allAffiliates()
  }
  
  List removeFromAffiliates(User user)
  {
	  Affiliation.unlink(user, this)
	  return allAffiliates()
  }
}
