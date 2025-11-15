-- Arquivo: 3_oficina_consultas.sql
USE oficina;

-- 1. Pergunta: Qual o custo total (Peças + Serviços) de cada Ordem de Serviço concluída?
-- Conceitos: Múltiplos JOINs, GROUP BY, ORDER BY, Atributo Derivado (CustoTotal), Filtro (WHERE)

SELECT
    os.idOS,
    c.nome AS Cliente,
    v.placa,
    -- Atributo Derivado (Soma dos Serviços)
    COALESCE(SUM(s.preco), 0) AS TotalServicos,
    -- Atributo Derivado (Soma das Peças * Quantidade)
    COALESCE(SUM(p.preco * pos.quantidadeUsada), 0) AS TotalPecas,
    -- Atributo Derivado (Total Geral)
    (COALESCE(SUM(s.preco), 0) + COALESCE(SUM(p.preco * pos.quantidadeUsada), 0)) AS CustoTotal
FROM OrdemDeServico os
JOIN Veiculo v ON os.idVeiculo = v.idVeiculo
JOIN Cliente c ON v.idCliente = c.idCliente
-- Usamos LEFT JOIN para garantir que OS sem peças ou sem serviços ainda apareçam
LEFT JOIN Servico_OS sos ON os.idOS = sos.idOS
LEFT JOIN Servico s ON sos.idServico = s.idServico
LEFT JOIN Peca_OS pos ON os.idOS = pos.idOS
LEFT JOIN Peca p ON pos.idPeca = p.idPeca
WHERE
    os.statusOS = 'Concluído'
GROUP BY
    os.idOS, c.nome, v.placa
ORDER BY
    CustoTotal DESC;


-- 2. Pergunta: Quais equipes (e seus mecânicos) geraram mais de R$ 400,00 em serviços?
-- Conceitos: JOIN, GROUP BY, HAVING (Condição de filtro em grupo)

SELECT
    e.nomeEquipe,
    m.nome AS Mecanico,
    SUM(s.preco) AS FaturamentoServicos
FROM Equipe e
JOIN Mecanico m ON e.idEquipe = m.idEquipe
JOIN OrdemDeServico os ON e.idEquipe = os.idEquipe
JOIN Servico_OS sos ON os.idOS = sos.idOS
JOIN Servico s ON sos.idServico = s.idServico
WHERE
    os.statusOS = 'Concluído'
GROUP BY
    e.nomeEquipe, m.nome
HAVING -- Filtro aplicado APÓS o agrupamento
    FaturamentoServicos > 100; -- Ajustado para > 100 para DML de exemplo
    

-- 3. Pergunta: Quais peças estão com estoque baixo (<= 30 unidades)?
-- Conceitos: Recuperação Simples (SELECT), Filtro (WHERE), Atributo Derivado (CASE)

SELECT
    nomePeca,
    quantidadeEstoque,
    -- Atributo Derivado para classificar o status
    CASE
        WHEN quantidadeEstoque = 0 THEN 'SEM ESTOQUE'
        WHEN quantidadeEstoque <= 30 THEN 'ESTOQUE BAIXO'
        ELSE 'ESTOQUE NORMAL'
    END AS StatusEstoque
FROM Peca
WHERE
    quantidadeEstoque <= 30
ORDER BY
    quantidadeEstoque ASC;


-- 4. Pergunta: Qual cliente possui mais de um veículo cadastrado?
-- Conceitos: JOIN, GROUP BY, HAVING

SELECT
    c.nome,
    COUNT(v.idVeiculo) AS QuantidadeVeiculos
FROM Cliente c
JOIN Veiculo v ON c.idCliente = v.idCliente
GROUP BY
    c.idCliente
HAVING
    QuantidadeVeiculos > 1;
