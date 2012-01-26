package com.k_int.spd.domain

class School {

  String name
  Long oldSpdId
  Region region;
  String edubaseUrn

  static constraints = {
    oldSpdId(nullable:true)
    region(nullable:true)
    edubaseUrn(nullable:true)
  }
}
