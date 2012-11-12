module issue/attachment

entity Attachment {
	date :: DateTime
	file :: File
}

template attachmentAddition(i : Issue) {
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

template attachmentAdditionInput(i : Issue) {
	var newFile : File;
	form {
		par { 
			input(newFile) {validate(newFile != null && newFile.fileName() != "", "")}
			submitlink addAttachment(newFile, i) [class="btn"] { iPlus " Add" }
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
//		replace(attachmentList, attachmentList(i));
	}
}
