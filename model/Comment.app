module model/Comment
entity Comment : Event {
  author -> User
  text :: WikiText ( searchable )
//   function toJSON ( ) : JSONObject
//   {
//     var json := JSONObject() ;
//     json.put("id", id);
//     json.put("text", text.format());
//     json.put("author", author.toJSON());
//     json.put("submitted", moment.getTime() / 1000L);
//     json.put("version", version);
//     return json;
//   }
}