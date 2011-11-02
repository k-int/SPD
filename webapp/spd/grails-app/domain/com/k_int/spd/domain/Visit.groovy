package com.k_int.spd.domain

class Visit {

  School school
  Museum museum
  Date visitDate
  long partySize = 0
  Long visitYear

  static hasMany = [postings:Classifier]

  static constraints = {
  }

}
