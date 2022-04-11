class Maq
  require 'date'

#----------------------------------------Hashtag----------------------------------------------
    def hashtagsReg(textoReg)
        hash = textoReg.scan(/\#[a-zA-Zà-úÀ-Ú0-9]*/)
        hashString = "Tags: "
        hash.each do |w|
          hashString += w.to_s + " "
        end
        return hashString
    end

#-----------------------------------------Data---------------------------------------------
    def dataReg(textoReg)
        if(!!(textoReg =~ /([0-9]{2} de [a-zA-Z]+)/i))
            regdata = textoReg.match(/([0-9]{2} de [a-zA-Z]+)/).to_s
            data_reg = dicionarioMes(regdata)
        elsif(!!(textoReg =~ /[0-9]{2} de [a-zA-Z]+ de [0-9]{4}/i))
            regdata = textoReg.match(/[0-9]{2} de [a-zA-Z]+ de [0-9]{4}/).to_s
            data_reg = dicionarioMes(regdata)
        elsif textoReg.include? "hoje"
            data_reg = Date.today().strftime("%d/%m/%Y")
        elsif textoReg.include? "depois de amanhã"
            data_reg = (Date.today() + 2).strftime("%d/%m/%Y")
        elsif textoReg.include? "amanhã"
            data_reg = (Date.today() + 1).strftime("%d/%m/%Y")
        elsif(!!(textoReg =~ /([0-9]{2}\/[0-9]{2})/i))
            regdata = textoReg.match(/([0-9]{2}\/[0-9]{2})/).to_s
            data_reg = regdata + "/#{Date.today.year}"
        else
           data_reg = textoReg.match(/([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))\/\d{4}/)
        end
        return "Data: "+data_reg.to_s 
    end

#--------------------------------------Pessoas-----------------------------------------------
    def pessoasReg(textoReg)
        
        pessoa = textoReg.match(/(?<= [cC]om\s)[a-zA-Zà-úÀ-Ú]*/)
        stringPessoas = "Pessoas: " + pessoa.to_s + " "
        pessoas = textoReg.scan(/(?<=\se\s|\,\s)[A-Z][a-zà-úÀ-Ú]+/)
        pessoas.each do |p|
          stringPessoas += p.to_s + " "
        end
        return stringPessoas
    end

#---------------------------------------Horario----------------------------------------------
    def horarioReg(textoReg)
        horaString = "Horário: "
        if(!!(textoReg =~ /([0-9]{2}:[0-9]{2})/i))
            reghora = textoReg.match(/(\d{1,2}:?\s?\d{2})/).to_s
            return horaString + reghora
        elsif(!!(textoReg =~ /[0-9]{1,2}\shora/i))
            reghora = textoReg.match(/[0-9]{1,2}\shora/).to_s
            reghora[" hora"] = ":00"
            if reghora.length < 5
                reghora = "0" + reghora
            end
            return horaString + reghora
        elsif(!!(textoReg =~ /[0-9]{2}\s[0-9]{2}/i))
            reghora = textoReg.match(/(\d{1,2}\s?\d{2})/).to_s
            reghora.gsub! ' ', ':'
            return horaString + reghora
        else
            reghora = textoReg.match(/(?<= às\s)*[0-9]{1,2}/).to_s
            reghora = reghora + ":00"
            if reghora.length < 5
                reghora = "0" + reghora
            end
            return horaString + reghora
        end
    end

#------------------------------------Definição dos meses--------------------------------------
    def dicionarioMes(string)
        strin = string.downcase
        dicionario_mes = {1=>"janeiro",2=>"fevereiro",3=>"março",4=>"abril",5=>"maio",6=>"junho",7=>"julho",8=>"agosto",9=>"setembro",10=>"outubro",11=>"novembro",12=>"dezembro"}
        dia = strin.match(/[0-9]{2}/).to_s
        mes = dicionario_mes.index(strin.match(/(?<= de\s)[a-zA-Z]+/).to_s)
        ano = strin.match(/[0-9]{4}/).to_s
        if mes != 11 || mes != 12
            mes = "0#{mes}"
        end
        if ano.empty?
            ano =  Date.today.year
        end
        data_reg = "#{dia}/#{mes}/#{ano}"
        return data_reg
    end

#-------------------------------------Função de print--------------------------------------
    def regSend(textoReg)
        puts "Resultado: "+ textoReg
        puts horarioReg(textoReg)
        puts dataReg(textoReg)
        puts pessoasReg(textoReg)
        puts hashtagsReg(textoReg)
        puts
    end
end



