# Match

Escrever um conjunto de funções em ML que permita processar um conjunto de fragmentos e um conjunto de palavras. O objetivo do sistema é verificar quais palavras podem ser formadas a partir dos fragmentos disponíveis. Por exemplo, considere a lista de símbolos da tabela periódica de elementos químicos e a lista de palavras da língua portuguesa, neste caso seriam verificadas palavras como sarcasmo.

O sistema pode ser implementado por força bruta, entretanto, uma estrutura de dados pode tornar o sistema mais eficiente.

Avaliação

Os itens abaixo serão avaliados:

a. [1 pt] ler arquivos de entrada com as listas de fragmentos e de palavras. - **OK**

b. [1 pt] gravar arquivo de saída com palavras verificadas. - **OK**

c. [1 pt] funções que permitem ignorar acentos e outros sinais gráficos. - **OK**

d. [2 pt] função que determina se a palavra pode ser verificada. - **OK**

e. [1 pt] manter repositório privado com tarefas - **OK**

f. [1 pt] listar ao menos cinco referências consultadas - **OK**
Indicadas no código fonte em comentário (livros, vídeos, manuais, StackOverflow etc)

g. [1 pt] utilizar funções de alta ordem (filter, map, fold etc) - **OK**
Processar blocos utilizando corretamente funções de alta ordem.

h. [1 pt] utilizar tipos de dados (datatype) - **Ver notas [1]**
Criar tipos de dados para representar blocos.

i. [1 pt] comprovar otimização por uso de paralelismo. - **Ver notas [2]**
Demonstrar aceleração com testes de desempenho (tempo de processamento, uso de processador).



*1 - Não houve ocasião para a utilização de datatypes, seu eventual uso seria forçado.*

*2 - Para otimizar o algoritmo buscamos reduzir a ordem de complexidade através da utilização das estruturas Map e Set, implementadas no SML NJ como árvores rubro-negras, permitindo busca e inserção O(log n). O paralelismo não está disponível por padrão no SML NJ.*
