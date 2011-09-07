package com.k_int.spd.domain

class Visit {

  classifiers = []

  static hasMany = [classifiers:Classifier]

  static constraints = {
  }

}
