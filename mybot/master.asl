	/* Initial beliefs and rules */
	//se determina cuando el bot devuelve una respuesta en forma de servicio en nombre de ,ademas del tipo de servicio para ser procesador por filter()
	
	
	service(Answer, mailing):- .substring("<mail>",Answer). 
	service(Answer, addValueOnSetFileFor) :- .substring("<addset>",Answer) & .substring("<new>",Answer).
	service(Answer, creatingFile) :- .substring("<file>",Answer).
	service(Answer, writingOn) :- .substring("<addtxt>",Answer) . 
	
	
	getValTag(Tag,String,Val) :- 
	.substring(Tag,String,Fst) &
	.length(Tag,N) &
	.delete(0,Tag,RestTag) &
	.concat("</",RestTag,EndTag) &
	.substring(EndTag,String,End) &
	.substring(String,Val,Fst+N,End).
			
				
	filter(Answer, mailing, "Ya he enviado el mensaje como me pediste."):- //true.
	getValTag("<to>",Answer,To) &
	getValTag("<subject>",Answer,Subject) &
	getValTag("<msg>",Answer,Msg) &
	gui.mailing(To,Subject,Msg).
	
		
		//recoge respuestas del tipo <addset> con <new>
		filter(Answer, addValueOnSetFileFor, Answered) :-
			getValTag("<new>", Answer, New) &
			getValTag("<setfile>", Answer, Set) &
			.concat(Set, ".txt", SetFile) &
			gui.addValueOnSetFileFor(New, SetFile, "mybot") &
			.concat("Anadido al conjunto ", Set, Answered).
		
		
		//recoge respuestas del tipo <file>
		filter(Answer, creatingFile, Answered) :-
			getValTag("<file>", Answer, File) & 
			.concat(File, ".txt", FullFile) & printf(File) &
			gui.creatingFile(FullFile) &
			.concat("Creado el archivo ", File, Answered).
		
		//recoge respuestas del tipo <addtxt>
		filter(Answer, writingOn, Answered) :-
			getValTag("<txt>", Answer, Txt) & 
			getValTag("<file>", Answer, File) &
			.concat("../", File, Path) &
			.concat(Path, ".txt", FullPath) &
			gui.writingOn(Txt, FullPath) & .concat("Anadido al archivo ", File, Answered).
			
			
			
	//filtrar las contestaciones del bot que incluyan servicios en nombre de y enviar el mensaje enmascarado al agente student mediante .send
	+answer(Answer) : service(Answer, Service) & filter(Answer, Service, MensajeEnmascarado) <- 
		.send(student, tell, answer(MensajeEnmascarado)).
		
