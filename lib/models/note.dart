
class Note{
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  Note(this._title, this._date, this._priority, [this._description]);

  //Constructor with named parameter that accepts id
  Note.withId(this._id, this._title, this._date, this._priority, [this._description]);

  //geters
  int get id =>_id;
  String get title => _title;
  String get description => _description;
  String get date =>_date;
  int get priority =>_priority;

  //setter, note that we don't need setter for id since it generates automatically
  set title(String newTitle){
    if(newTitle.length <=255){
      this._title = newTitle;
    }
  }

  set description(String newDescription){
    if(newDescription.length <=255){
      this._title = newTitle;
    }
  }

}