package com.k_int.spd.domain

import java.util.List;

class Museum {

  String name
  Long oldSpdId
  Region region;
  String postcode

  // For linking to other databases
  String cultureGridInternalId
  String institutionId
  
  static hasMany = [affiliates:Affiliation]

  static constraints = {
    cultureGridInternalId(nullable:true)
    institutionId(nullable:true)
    oldSpdId(nullable:true)
    region(nullable:true)
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
