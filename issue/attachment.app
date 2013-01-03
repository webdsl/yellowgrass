module issue/attachment

section data model

  entity Attachment {
	  date :: DateTime
	  file :: File
  }
  
section view

  ajax template attachmentList(i : Issue) {
    if(i.attachments.length > 0) {
      pageHeader2{ "Attachments" }
      tableBordered  {
        for(a : Attachment in i.attachments order by a.date desc) {
          form { 
            row { 
              column{ iFile " " output(a.file) } 
              column{ output(a.date.format("d MMMM yyyy 'at' HH:mm")) }
              column{ submitlink deleteAttachment(a) [class="btn"] { iRemove } }
            } 
          }
        }
      }
    }
    action deleteAttachment(a : Attachment) {
      i.attachments.remove(a);
      //    replace(attachmentList, attachmentList(i));
    }
  }
  
section adding attachments 

  // template attachmentAddition(i : Issue) {
  //   //action add() { replace(attachmentAdditionBox, attachmentAdditionInput(i));  }
  //   placeholder attachmentAdditionBox {
  //     // pullRight{ 
  //     //   par{ submitlink add() [class="btn btn-mini"] { iPlus " Add Attachment" } }
  //     // }
  //   } 
  // } 
   
  template attachmentAdditionTool(i : Issue) {
    //action add() { replace(attachmentAdditionBox, attachmentAdditionInput(i));  }
    navigate attachment(i) [class="btn", title="Add Attachment", style="height:14px;padding:7px;"] { iFile  }
  }  

  template attachmentAdditionInput(i : Issue) {
    var newFile : File;
    action addAttachment(newFile : File, issue : Issue) {
      var newAttachment := Attachment {
        date := now()
        file := newFile
      };
      issue.attachments.add(newAttachment);
      return issue(i.project, i.number); 
    }
    horizontalForm {
      controlGroup("File"){
        input(newFile) { validate(newFile != null && newFile.fileName() != "", "") }
      }
      formActions{
        submit addAttachment(newFile, i) [class="btn btn-primary"] { "Add Attachment" }
      }
    }
  }
  
section add attachment page

  page attachment(i: Issue) {
    bmain(i.project){
      issueCommandsMenu(i)
      pageHeader2{"Add Attachment:" output(i.getTitle()) }
      attachmentAdditionInput(i)
    }
  }

//   template attachmentAddition(i : Issue) {
// 	  div [id="attOpener"] {
// 		  par { 
// 			  <a href="javascript:void(0)" onCLick="javascript:document.getElementById('attachmentAdditionBox').style.display='block';document.getElementById('attOpener').style.display='none'">
// 				  "Add Attachment"
// 			  </a> 
// 		  }
//  	  }
// 	  div [id="attachmentAdditionBox",style:="display:none;"] {
// 		  attachmentAdditionInput(i)
// 	  }
//   }
// 
//   template attachmentAdditionInput(i : Issue) {
// 	  var newFile : File;
// 	  form {
// 		  par { 
// 			  input(newFile) {validate(newFile != null && newFile.fileName() != "", "")}
// 			  submitlink addAttachment(newFile, i) [class="btn"] { iPlus " Add" }
// 		  }
// 	  }
// 	
// 	  action addAttachment(newFile : File, issue : Issue) {
// 		  var newAttachment := Attachment {
// 			  date := now()
// 			  file := newFile
// 		  };
// 		  issue.attachments.add(newAttachment);
// 	  }
//   }


  
