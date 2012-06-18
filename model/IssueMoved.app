module entities_generated/IssueMoved
entity IssueMoved : Event {
  target -> Issue
  actor -> User
}