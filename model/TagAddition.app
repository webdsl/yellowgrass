module model/TagAddition
entity TagAddition : Event {
  tag -> Tag
  actor -> User
}