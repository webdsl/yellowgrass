module issue/attachment

section data model

  entity Attachment {
	  date :: DateTime
	  file :: File
  }
  
section view

  ajax template attachmentList(i : Issue) {
    if(i.attachments.length > 0) {
      tableBordered  {
        for(a : Attachment in i.attachments order by a.date desc) {
          form {row { 
            column{ output(a.file) } 
            column{ output(a.date.format("MMM d")) }
            column{ submitlink deleteAttachment(a) [class="btn"] { iRemove } }
          }}
        }
      }
      par { " " }
    }
    action deleteAttachment(a : Attachment) {
      i.attachments.remove(a);
      //    replace(attachmentList, attachmentList(i));
    }
  }
  
section adding attachments 

  template attachmentAddition(i : Issue) {
    attachmentAdditionInput(i)   
    // action add() { replace(attachmentAdditionBox, attachmentAdditionInput(i));  }
    // placeholder attachmentAdditionBox {
    //   submitlink add() [class="btn"] { iPlus " Add Attachment" }
    // }
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
    form {
      par { 
        input(newFile) { validate(newFile != null && newFile.fileName() != "", "") }
        submitlink addAttachment(newFile, i) [class="btn"] { iPlus " Add" }
      }
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


  
