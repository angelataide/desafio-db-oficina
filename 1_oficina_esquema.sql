-- Arquivo: 1_oficina_esquema.sql
CREATE DATABASE IF NOT EXISTS oficina;
USE oficina;

-- Tabela Cliente
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    telefone CHAR(11) NOT NULL,
    email VARCHAR(255) UNIQUE,
    endereco VARCHAR(255)
);

-- Tabela Veiculo (depende de Cliente)
CREATE TABLE Veiculo (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    placa CHAR(7) NOT NULL UNIQUE,
    modelo VARCHAR(100) NOT NULL,
    marca VARCHAR(50),
    ano INT,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela Equipe
CREATE TABLE Equipe (
    idEquipe INT AUTO_INCREMENT PRIMARY KEY,
    nomeEquipe VARCHAR(100) NOT NULL -- Ex: 'Equipe A - Motor', 'Equipe B - Freios'
);

-- Tabela Mecanico (depende de Equipe)
CREATE TABLE Mecanico (
    idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    idEquipe INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    especialidade VARCHAR(100),
    FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe)
);

-- Tabela OrdemDeServico (OS)
CREATE TABLE OrdemDeServico (
    idOS INT AUTO_INCREMENT PRIMARY KEY,
    idVeiculo INT NOT NULL,
    idEquipe INT NOT NULL,
    dataEntrada DATETIME DEFAULT CURRENT_TIMESTAMP,
    dataConclusaoPrevista DATE,
    dataConclusaoReal DATE,
    statusOS ENUM('Em avaliação', 'Aguardando peças', 'Em serviço', 'Cancelado', 'Concluído') DEFAULT 'Em avaliação',
    FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo),
    FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe)
);

-- Tabela de catálogo de Serviços
CREATE TABLE Servico (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    nomeServico VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL
);

-- Tabela de catálogo de Peças
CREATE TABLE Peca (
    idPeca INT AUTO_INCREMENT PRIMARY KEY,
    nomePeca VARCHAR(255) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidadeEstoque INT DEFAULT 0
);

-- Tabela Associativa M:N (Serviços realizados na OS)
CREATE TABLE Servico_OS (
    idOS INT NOT NULL,
    idServico INT NOT NULL,
    PRIMARY KEY (idOS, idServico),
    FOREIGN KEY (idOS) REFERENCES OrdemDeServico(idOS),
    FOREIGN KEY (idServico) REFERENCES Servico(idServico)
);

-- Tabela Associativa M:N (Peças utilizadas na OS)
CREATE TABLE Peca_OS (
    idOS INT NOT NULL,
    idPeca INT NOT NULL,
    quantidadeUsada INT NOT NULL,
    PRIMARY KEY (idOS, idPeca),
    FOREIGN KEY (idOS) REFERENCES OrdemDeServico(idOS),
    FOREIGN KEY (idPeca) REFERENCES Peca(idPeca)
);
