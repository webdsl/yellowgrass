module issue/attachment

entity Attachment {
	date :: DateTime
	file :: File
}

define template attachmentAddition(i : Issue) {
	block [id="attOpener"] {
		par { 
			<a href="javascript:void(0)" onCLick="javascript:document.getElementById('attachmentAdditionBox').style.display='block';document.getElementById('attOpener').style.display='none'">
				"Add Attachment"
			</a> 
		}
	}
	block [id="attachmentAdditionBox",style:="display:none;"] {
		attachmentAdditionInput(i)
	}
}

define template attachmentAdditionInput(i : Issue) {
	var newFile : File;
	form {
		par { 
			input(newFile) {validate(newFile != null && newFile.fileName() != "", "")}
			action("Add", addAttachment(newFile, i)) 
		}
	}
	
	action addAttachment(newFile : File, issue : Issue) {
		var newAttachment := Attachment {
			date := now()
			file := newFile
		};
		newAttachment.save();
		issue.attachments.add(newAttachment);
	}
}

define ajax template attachmentList(i : Issue) {
	if(i.attachments.length > 0) {
		table  {
			for(a : Attachment in i.attachments order by a.date desc) {
				form {row { 
					column{ output(a.file) } 
					column{ output(a.date.format("MMM d")) }
					column{ actionLink("x", deleteAttachment(a))[ajax] } 
				}}
			}
		}
		par { " " }
	}
	action deleteAttachment(a : Attachment) {
		i.attachments.remove(a);
//		replace(attachmentList, attachmentList(i));
	}
}