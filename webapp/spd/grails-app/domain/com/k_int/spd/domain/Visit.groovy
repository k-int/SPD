package com.k_int.spd.domain

class Visit {

  def classifiers = []

  static hasMany = [classifiers:Classifier]

  static constraints = {
  }

}
