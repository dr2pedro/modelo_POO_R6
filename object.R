if(!require(R6)) {
        install.packages("R6")
        require(R6)
      }



# o nome antes do assiginment é a tipagem do objeto, como em qualquer outra coisa no R é por ela que
# chamamos o objeto

object <- R6Class(
  # o primeiro slot 
  "Coisa",
  
  
  # aqui definimos a heraça desse objeto, convocando a tipagem acima, pai, desse objeto.
  inherit = coisa_pai,
  
  ### Tudo dentro dos objetos são definidos em listas. Existem dois tipos de 
  ### escopos: o público e o privado. O que originalmente não deve ser acessado pelos
  ### usuários finais deve ficar no escopo privado.
  private = list(

    ### por convenção os métodos privados são identificados com os dois pontos na frente
    ### uma vez que é possível existir um igual no escopo público com o mesmo nome.
    ..dataset = as.matrix(c(2,2,2,2),ncol=2)

  ),

  active = list(
    ### O escopo ativo é o responsável pelos getters e pelos setters. Nele seremos capazes 
    ### de acessar dados no escopo privado (getter) e até alterar o dado no escopo 
    ### privado (setter). Por convenção eles devem sempre ser definidos como 
    ### funções (semelhante a sintaxe do JavaScript).

    dataset = function() {
      ###  é uma função que retorna o objeto do privado. Antes é possível fazer qualquer lógica de 
      ###  programação. Esse é um exemplo de getter. Repara que ele até vai retornar um objeto tipado
      ###  mas na realidade ele é uma função.
      private$..dataset
    },

      ### Esse é um exemplo de setter. Por convenção ela deve possuir um único 
      ### argumento chamado value.
    extend_dataset = function(value) {
      
      ### o assert só aceita substituição por outras matrizes. 
      assert_is_a_matrix(value)

      ### ele altera, mas não está retornando nada. Depois de um método setter, 
      ### deve-se chamar o getter para se certificar da alteração.
      private$..dataset = value

      ### o escopo active pode por meio de funções definir variáveis acessíveis para o escopo
      ### public por meio de getters. 
    }),
  public = list(
      ### métodos/funções de trabalho para acesso público. 

      initialize  = function (...){
        ## método que faz pré-load do método $new comum em R6 object
      }

      finalize = function(...){
        ## método que faz os procedimentos de off-load do $new. 
      })
    )
  )
)