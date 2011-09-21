package com.k_int.spd.domain

class Visit {

  School school
  Museum museum
  Date visitDate
  long partySize = 0
  long visitYear

  def classifiers = []

  static hasMany = [classifiers:Classifier]

  static constraints = {
    visitYear(nullable:true)
  }

}
