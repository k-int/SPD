package com.k_int.spd.domain

class School {

  String name
  Long oldSpdId

  static constraints = {
    oldSpdId(nullable:true)
  }
}
