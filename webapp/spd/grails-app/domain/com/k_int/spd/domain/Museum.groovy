package com.k_int.spd.domain

class Museum {

  String name
  Long oldSpdId
  Region region;

  static constraints = {
    oldSpdId(nullable:true)
    region(nullable:true)
  }


}
