#Desenvolvimento Delphi

Projeto Manipulação de strings.

Implementada função que substitua todas as ocorrências de uma substring por outra passada como parâmetro; 
Criada uma classe TSubstitui que implemente a interface ISubstitui.

ISubstitui = interface function Substituir(aStr, aVelho, aNovo: String): String; end;

Ao chamar o método Substituir, deverá ser retornada a string passada como parâmetro com todas as ocorrências da string velha substituídas pela string nova. Ex.: string “O rato roeu a roupa do rei de roma” velha: “ro” nova: “teste” retorno: “O rato testeeu a testeupa do rei de testema”

Obs.: A pesquisa e montagem da nova string é feita manualmente sem o uso de qualquer função de Strings do Delphi (como Pos(), Copy(), Delete(), Insert(), etc.).
