
class Note{
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;


  //CONSTRUCTORS
    //making  constructor -- 
    //[this.description] makes it optional, because the user may not want to add description
    //we do not include the id since the id is auto generated

  Note(this._title, this._date, this._priority,[this._description]);

    //make a constructor that will also accept an id
    //You need to make a new name for this constructor as it is not allowed to have same name
    //make it a named constructor
  Note.withId(this._id,this._title, this._date, this._priority,[this._description]);

  //GETTERS
  int get id=>_id;
  String get title => _title;
  String get description => _description;
  int get priority=>_priority;
  String get date => _date;

  // SETTER
  set title(String newTitle){
    if(newTitle.length<=255){
      this._title=newTitle;
    }
  }
  set description(String newDescription){
    if(newDescription.length<=255){
      this._title=newDescription;
    }
  }
  set priority(int newPriority){
    if(newPriority >=1 && newPriority <=2){
      this._priority = newPriority;
    }
  }

  set date(String newDate){
    this._date = newDate;
  }

  //Convert a Note object into a Map object
  //key as String, Value as dynamic. If you can see all key are string like 'title' while the value  are eighter integer or string
  Map<String, dynamic> toMap(){

    var map =  Map<String, dynamic>();

    if (id !=null){
      map['id'] = _id;
    }
    
    map['title']=_title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  } 

//Extract Note Object fom Map Object
  Note.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
  }

}