import 'dart:async';

main(){
  print('Main program: Starts');
  printFileContent();
  print ('Main program: Ends');
}

//All functions declared below runs on Main UI Thread
//you can only use await if your function has async
printFileContent()   {
  //the line below tells that it only prints  once the downloadfile is ready and it will wait until it is     loaded which is in the case of it after 6 seconds
  
  Future<String>  fileContent =  downLoadAFile();
  fileContent.then((resultString){
    print('The content of the file is --> $resultString');
  }); 
  
}

//To download a file [Dummy Long running operation]
Future<String> downLoadAFile(){
  //future value of string that will take 6 seconds to return and convert it to a string, basically it is a promise token
  Future<String> result=Future.delayed(Duration(seconds: 6), (){
    return 'My secret file content';
  });

  return result;
}