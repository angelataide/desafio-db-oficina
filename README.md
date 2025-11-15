Este projeto implementa o esquema de banco de dados para a gestão de uma oficina mecânica. O modelo lógico foi projetado para gerenciar o fluxo completo de serviços, desde a recepção do cliente e seu veículo até a alocação de equipes de mecânicos e o controle de peças e serviços prestados em uma Ordem de Serviço.

Lógica do Modelo
O esquema relacional é composto pelas seguintes entidades principais:

Cliente: Armazena os dados dos proprietários dos veículos.

Veiculo: Armazena os dados dos veículos. Há um relacionamento (1:N) onde 1 Cliente pode possuir N Veículos.

Equipe: Agrupa os mecânicos (ex: "Equipe de Freios", "Equipe de Motor").

Mecanico: Armazena os dados dos mecânicos e sua especialidade. Há um relacionamento (1:N) onde 1 Equipe possui N Mecanicos.

OrdemDeServico (OS): A entidade central que registra a entrada do veículo, o status, a equipe responsável e as datas.

Peca e Servico: Tabelas "catálogo" que armazenam os preços e descrições dos itens/serviços que a oficina oferece.

Peca_OS e Servico_OS: Tabelas associativas (M:N) que ligam as Ordens de Serviço às muitas peças e serviços que podem ser utilizados/executados em um único reparo.

Este modelo permite um controle detalhado de quais peças foram usadas, quais serviços foram executados e qual equipe foi responsável por cada ordem de serviço.
