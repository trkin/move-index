# Move Index

This project aims to make it easier for people search for an event which they
can join for any king of sport or recreational activity. It is an index of all
activities like hiking, running, kayaking, and can perform filtering to specific
discipline requirements like split boarding.

# Model

User starts by defining what basic activity it wants (like kayaking or
swimming). Multi-activity (triathlon) is activity that BELONGS_TO multiple basic
activities in activity_associations table.
Discipline (K2 number_of_crew=2) belongs to activity and has it's specific
discipline_requirements (K2 boat) but also discipline_happening conditions (age
interval, distance, max time).
Properties which are not required (like fresh water, terain road, cros_country)
or hard to measure (like walking speed)
are defined in discipline_happening_tags.
* skyrunning vertical 1KM TERAIN=cross_country
* stairs run TERAIN=stairs
* cross duathlon 2-6y is modeled with AGE_MIN, AGE_MAX, LENGTH(total 2km),
  EQUIPMENT=any_bicycle, DOCUMENTS=medical_report, TERRAIN=cross_country
* K4-500m Senior AGE_MIN=16, LENGTH=500m, EQUIPMENT=sprint_kayak,
  DOCUMENTS=club_registration_or_medical_report, multi person is defined with
  NUMBER_OF_CREW=4
* Ibar downriver LENGTH=50km, EQUIPMENT=any_boat_without_motor,
  TERRAIN=slow_water
* sprint kayak marathon EQUIPMENT=sprint_kayak
* recreational kayak marathon EQUIPMENT=any_kayak
* sprint triatlon TERAIN=river_road_road
* sprint triatlon TERAIN=swimming_pool_road_road
* quadrathlon_swimming_kayak_bicycle_running EQUIPMENT=kayak_bicycle
* relay_running (2x12km) is modeled with number of crew (it is one person at one
  time) and association.

Some happenings are repeating (every day, week, month, year).
Non olimpic disciplines like dog walking, waste removal(street cleaning),
pokemon hunting, yoga, lunch hiking, kayaking with a dog.

TODO, each happening have a club which can be personal (personal gathering)... it is easier than to
check if club exists in a lot of places.
Similar
https://www.britishcanoeing.org.uk/competition/whatson/eventcalendars
http://canoeracing.org.uk/marathon/index.php/category/international-racing/intl_masters/
https://gopaddlingweek.info/go-paddling-week-event-finder/
https://gopaddling.info/category/explore/

# What is your move index ?

# Installation

This project uses:

* Ruby on Rails
* Postresql

# Tests

Run tests with `rake`

# Slides

Navigate to `/slides`
