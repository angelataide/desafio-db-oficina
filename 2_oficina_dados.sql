-- Arquivo: 2_oficina_dados.sql
USE oficina;

-- Clientes
INSERT INTO Cliente (nome, telefone, email, endereco) VALUES
('Carlos Mendes', '11988887777', 'carlos.mendes@email.com', 'Rua das Flores, 10, São Paulo'),
('Ana Beatriz', '21977776666', 'ana.beatriz@email.com', 'Av. Copacabana, 200, Rio de Janeiro'),
('Move Rápido Logística', '4133334444', 'frota@moverapido.com', 'Rod. das Indústrias, 30, Curitiba');

-- Equipes
INSERT INTO Equipe (nomeEquipe) VALUES
('Equipe A (Motor e Transmissão)'),
('Equipe B (Freios e Suspensão)'),
('Equipe C (Elétrica e Diagnóstico)');

-- Mecânicos
INSERT INTO Mecanico (idEquipe, nome, especialidade) VALUES
(1, 'Roberto Alves', 'Motor'),
(1, 'Fernando Lima', 'Transmissão'),
(2, 'Miguel Souza', 'Freios ABS'),
(3, 'Jéssica Costa', 'Diagnóstico Eletrônico');

-- Serviços (Catálogo)
INSERT INTO Servico (nomeServico, preco) VALUES
('Troca de Óleo e Filtro', 150.00),
('Alinhamento e Balanceamento', 120.00),
('Revisão Completa do Sistema de Freios', 350.00),
('Diagnóstico de Injeção Eletrônica', 200.00);

-- Peças (Catálogo)
INSERT INTO Peca (nomePeca, preco, quantidadeEstoque) VALUES
('Filtro de Óleo', 45.00, 100),
('Pastilha de Freio (Jogo)', 180.00, 50),
('Vela de Ignição', 25.00, 200),
('Bateria 60Ah', 400.00, 30);

-- Veículos
INSERT INTO Veiculo (idCliente, placa, modelo, marca, ano) VALUES
(1, 'ABC1234', 'Civic', 'Honda', 2019),
(2, 'XYZ5678', 'Onix', 'Chevrolet', 2020),
(3, 'LOG9876', 'Fiorino', 'Fiat', 2018),
(1, 'DEF5678', 'Corolla', 'Toyota', 2021);

-- Ordens de Serviço (OS)
INSERT INTO OrdemDeServico (idVeiculo, idEquipe, dataConclusaoPrevista, statusOS) VALUES
(1, 1, '2025-11-20', 'Em serviço'), -- OS 1: Honda Civic, Equipe A
(2, 2, '2025-11-18', 'Concluído'),  -- OS 2: Onix, Equipe B
(3, 3, '2025-11-25', 'Em avaliação'), -- OS 3: Fiorino, Equipe C
(1, 2, '2025-11-25', 'Concluído');   -- OS 4: Honda Civic, Equipe B

-- Serviços na OS
INSERT INTO Servico_OS (idOS, idServico) VALUES
(1, 1), -- Troca de Óleo
(2, 3), -- Revisão de Freios
(4, 2); -- Alinhamento

-- Peças na OS
INSERT INTO Peca_OS (idOS, idPeca, quantidadeUsada) VALUES
(1, 1, 1), -- 1 Filtro de Óleo
(2, 2, 1); -- 1 Jogo de Pastilha
