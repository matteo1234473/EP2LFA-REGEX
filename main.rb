load 'Regex.rb' 
reggx = Maq.new
    
#exemplo = "Agendar com José e Maria reunião às 10 dia 28/09/2022 #trabalho #faculdade"
#reggx.regSend(exemplo)

#Agendar com José, Maria reunião 10:32, amanhã #trabalho #feliz #fazendo #faculdade #quero #trancar"

#Agendar com José, Maria reunião 10 32, depois de amanhã #trabalho #faculdade"
#Agendar com José, Maria reunião 10 horas, 13 de agosto de 2021 #trabalho #feliz #fazendo #faculdade #quero #trancar"
#Agendar com José, Maria reunião 1 hora, 20/04 #trabalho #feliz #fazendo #faculdade #quero #trancar"
puts("Digite uma frase compativel:\n\n")
exemplo9 = gets
reggx.regSend(exemplo9)
