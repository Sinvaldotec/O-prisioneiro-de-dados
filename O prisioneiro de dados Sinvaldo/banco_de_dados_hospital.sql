create database if not exists Hospital;

use Hospital;

create table if not exists especialidade(
	id_especialidade int(11) auto_increment primary key,
    nome_especialidade varchar(100)
);

create table if not exists convenio(
	id_convenio int(11) auto_increment primary key,
    nome_convenio varchar(100),
    cnpj_convenio varchar(14),
    tempo_carencia varchar(100)
);

CREATE TABLE IF NOT EXISTS medico(
	id_medico int(11) auto_increment primary key,
    nome_medico varchar(125) not null,
    cpf_medico int(15) unique not null,
    crm varchar(13)unique not null,
    email_medico varchar(100),
    cargo varchar(100) NOT NULL,
    especialidade_id INT NOT NULL,
    foreign key(especialidade_id) references especialidade (id_especialidade) on delete cascade on update cascade 
);

create table if not exists paciente(
	id_paciente int(11) auto_increment primary key,
    nome_paciente varchar(125) not null,
    dt_nasc_paciente date,
    cpf_paciente int(15) unique not null,
    rg_paciente varchar(11) not null,
    email_paciente varchar(100),
    convenio_id int(11) default null,
    foreign key(convenio_id) references convenio (id_convenio) on delete cascade on update cascade 
);

create table if not exists enfermeiro(
	id_enfermeiro int(11) auto_increment primary key,
    nome_enfermeiro varchar(125) not null,
    cpf_enfermeiro int(11) unique not null,
    cre varchar(13)unique not null
);

create table if not exists consulta(
	id_consulta int(11) auto_increment primary key,
    data_consulta date not null,
    hora_consulta time not null,
    valor_consulta decimal,
    convenio_id int(11) default null,
    medico_id int(11) not null,
    paciente_id int(11) not null,
    especialidade_id int(11) not null,
    foreign key(convenio_id) references convenio (id_convenio) on delete cascade on update cascade,
    foreign key(medico_id) references medico (id_medico) on delete cascade on update cascade,
    foreign key(paciente_id) references paciente (id_paciente) on delete cascade on update cascade,
    foreign key(especialidade_id) references especialidade (id_especialidade) on delete cascade on update cascade
);

create table if not exists receita(
	id_receita int(11) auto_increment primary key,
    medicamento varchar(200),
    qtd_medicamento int(11),
    instrucao_uso text(220),
    consulta_id int(11) not null,
    foreign key(consulta_id) references consulta (id_consulta) on delete cascade on update cascade
);

create table if not exists tipo_quarto(
	id_tipo int(11) auto_increment primary key,
    valor_diario decimal(8, 2) not null,
    desc_quarto varchar(100) default null
);

create table if not exists quarto(
	id_quarto int(11) auto_increment primary key,
    numero int(11) not null,
    tipo_id int(11) not null,
    foreign key(tipo_id) references tipo_quarto (id_tipo) on delete cascade on update cascade
);

create table if not exists internacao(
	id_internacao int(11) auto_increment primary key,
    data_entrada date not null,
    data_prev_alta date not null,
    data_efet_alta date not null,
    desc_procedimentos text,
    paciente_id int(11) not null,
    medico_id int(11) not null,
    quarto_id int(11) not null, 
    foreign key(paciente_id) references paciente (id_paciente) on delete cascade on update cascade,
    foreign key(medico_id) references medico (id_medico) on delete cascade on update cascade,
    foreign key(quarto_id) references quarto (id_quarto) on delete cascade on update cascade
);

create table if not exists plantao(
	id_plantao int(11) auto_increment primary key,
    data_plantao date,
    hora_plantao time,
    internacao_id int(11) not null,
    enfermeiro_id int(11) not null,
    foreign key(internacao_id) references internacao (id_internacao) on delete cascade on update cascade,
    foreign key(enfermeiro_id) references enfermeiro (id_enfermeiro) on delete cascade on update cascade
);

create table if not exists endereco(
	id_endereco int(11) auto_increment primary key,
    logradouro varchar(100) not null,
    cep int(8)not null,
    bairro varchar(100) not null,
    cidade varchar(100)not null,
    estado varchar(100)not null,
    medico_id int(11) default null,
    paciente_id int(11) default null,
    foreign key(paciente_id) references paciente (id_paciente) on delete cascade on update cascade,
    foreign key(medico_id) references medico (id_medico) on delete cascade on update cascade
);

create table if not exists telefone(
	id_telefone int(11) auto_increment primary key,
    ddd int(3) not null,
    numero int(9) not null,
    medico_id int(11) default null,
    paciente_id int(11) default null,
    foreign key(paciente_id) references paciente (id_paciente) on delete cascade on update cascade,
    foreign key(medico_id) references medico (id_medico) on delete cascade on update cascade
);

-- Inserindo dados na tabela Convenio
--
insert into convenio(id_convenio, nome_convenio, cnpj_convenio, tempo_carencia) values(1, 'Saúde Azul', '9852143614751', '30 dias');
insert into convenio(id_convenio, nome_convenio, cnpj_convenio, tempo_carencia) values(2, 'Bem estar', '47810596327845', '24 horas');
insert into convenio(id_convenio, nome_convenio, cnpj_convenio, tempo_carencia) values(3, 'Mais saúde', '36149520784195', '24 dias');
insert into convenio(id_convenio, nome_convenio, cnpj_convenio, tempo_carencia) values(4, 'Fortaleza saúde', '29814536710254', '180 dias');


-- Inserindo dados na tabela Especialidade
--
insert into especialidade(id_especialidade, nome_especialidade) values(1, 'Pediatria');
insert into especialidade(id_especialidade, nome_especialidade) values(2, 'Clínica');
insert into especialidade(id_especialidade, nome_especialidade) values(3, 'Gastroenterologia');
insert into especialidade(id_especialidade, nome_especialidade) values(4, 'Dermatologia');
insert into especialidade(id_especialidade, nome_especialidade) values(5, 'Cardiologia');
insert into especialidade(id_especialidade, nome_especialidade) values(6, 'Neurologia');
insert into especialidade(id_especialidade, nome_especialidade) values(7, 'Ortopedia');


-- Inserindo dados na tabela Tipo de quarto
--
insert into tipo_quarto(id_tipo, valor_diario, desc_quarto) values(1, '1200.00', 'Apartamento');
insert into tipo_quarto(id_tipo, valor_diario, desc_quarto) values(2, '800.00', 'Quartos duplos');
insert into tipo_quarto(id_tipo, valor_diario, desc_quarto) values(3, '600.00', 'Enfermaria');


-- Inserindo dados na tabela Medico
--
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(1, 'Fernando Almeida', 1489745634, 745862, 'almeida@gmail.com', 'Residente', 6); 
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(2, 'Guilherme Costa', '74112654', '125489', 'costa@gmail.com', 'Residente', 7);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(3, 'Marcelo Penedo Silva', '78568745', '589745', 'marenedo@gmail.com', 'Interno', 1);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(4, 'Paula Cristina', '45765816', '452181', 'cristina@gmail.com', 'Residente', 5);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(5, 'Joseph Marlunino', '56836985', '165780', 'marlunino@hotmail.com', 'Especialista', 6);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(6, 'Dalila Gomes', '36465414', '074588', 'dalila@gmail.com', 'Residente', 2);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(7, 'Diogo Carvalho Hernandes', '15647896', '814592', 'hernandes@gmail.com', 'Interno', 3);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(8, 'Carolina Nunes', '47125496', '654747', 'nunes.nunes@gmail.com', 'Especialista', 1);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(9, 'Silvio Alberto Souza', '47914978', '487127', 'alberto.souzas@gmail.com', 'Especialista', 2);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(10, 'Mariane Barbosa', '78469512', '147548', 'mbarbosa@gmail.com', 'Residente', 4);


-- Inserindo dados na tabela Paciente
--
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(1, 'Ariane Francisca Nascimento', '1992-03-19', '74951247', '1465265-x', 'arianefn@gmail.com', null);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(2, 'Suelen Alexandra Pinheiro', '1975-06-02', '87133693', '1444870', 'alexandra@gmail.com', 4);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(3, 'Fabrizio Mattos', '2004-07-09', '19112423', '3288751', 'mattos.f@gmail.com', null);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(4, 'Flavia Pereira', '1994-10-13', '65911465', '8516495', 'flaviap@gmail.com', 1);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(5, 'Josuel Franco', '1984-05-20', '16655296', '2648797', 'jofranco@gmail.com', 3);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(6, 'Gabriela Soares', '2001-09-18', '21987436', '164987-x', 'gabis@gmail.com', 1);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(7, 'Priscilla Oliveira', '1999-05-01', '65922663', '74458615', 'prilla@gmail.com', 2);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(8, 'Reginaldo Farias', '1974-11-29', '45584723', '4563274', 'farias@gmail.com', null);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(9, 'Leonardo Mariano', '2006-11-28', '36985269', '26547891', 'le.mariano@gmail.com', null);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(10, 'Juliana Alcantara', '2001-07-08', '36123478', '12096652', 'juju.alca@gmail.com', 2);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(11, 'Victor Bueno', '2007-04-22', '03261256', '69823045', 'bueno04@gmail.com', 4);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(12, 'Amanda Silva', '197712-25', '63003289', '3261471', 'amanda@gmail.com', 1);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(13, 'Pedro Henrique', '1999-08-13', '85479473', '2436198', 'p.henriquea@gmail.com', 4);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(14, 'Michele Loreto', '1979-03-15', '25916489', '25499876', 'loreto@gmail.com', null);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(15, 'Livia Manuela lima', '2005-02-15', '56784285', '73565189', 'livia@gmail.com', 3);


-- Inserindo dados na tabela Telefone
--
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(1, 11, 40028922, 1, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(2, 11, 40089655, 2, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(3, 11, 75589644, 3, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(4, 11, 41587622, 4, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(5, 11, 46685711, 5, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(6, 11, 40028922, 6, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(7, 11, 74851987, 7, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(8, 11, 58749684, 8, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(9, 11, 41879655, 9, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(10, 11, 14487522, 10, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(11, 11, 985632001, null, 1);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(12, 11, 998654789, null, 2);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(13, 11, 987569856, null, 3);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(14, 11, 987654021, null, 4);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(15, 11, 958620347, null, 5);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(16, 11, 985314758, null, 6);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(17, 11, 987654259, null, 7);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(18, 11, 974851471, null, 8);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(19, 11, 914032569, null, 9);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(20, 11, 963266587, null, 10);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(21, 11, 941178546, null, 11);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(22, 11, 985864127, null, 12);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(23, 11, 963568891, null, 13);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(24, 11, 987475812, null, 14);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(25, 11, 987745876, null, 15);


-- Inserindo dados na tabela Endereco
--
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(1, 'Rua Pedro Velasco', 05422-003, 'Morumbi', 'São Paulo', 'São Paulo', null, 1);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(2, 'R. Ana Paulina', 04362-072, 'Moema', 'São Paulo', 'São Paulo', null, 2);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(3, 'Rua Serra Negra', 08418-030, 'Butanta', 'São Paulo', 'São Paulo', null, 3);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(4, 'R. Floriano Peixoto',  3325-3181 , 'Santana', 'São Paulo', 'São Paulo', 1, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(5, 'R. Francisco de Paula', 01508-458, 'Sé', 'São Paulo', 'São Paulo', 2, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(6, 'R. Ernesto Paglia', 01455-030, 'Tatuapé', 'São Paulo', 'São Paulo', 3, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(7, 'R. Maria Cristine', 04022-005, 'Vila Mariana', 'São Paulo', 'São Paulo', 4, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(8, 'R. Oséias Silveira ', 05530-004, 'Carrão', 'São Paulo', 'São Paulo', 5, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(9, 'R. Carlos Pereira', 02547-030, 'Pinheiros', 'São Paulo', 'São Paulo', 6, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(10, 'R. Thiago Medeiros', 05687-020, 'Paraíso', 'São Paulo', 'São Paulo', 7, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(11, 'R. 12 de outubro', 05049-030, 'Lapa', 'São Paulo', 'São Paulo', null, 8);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(12, 'R. Joaquim Ribeiro', 01658-001, 'Penha', 'São Paulo', 'São Paulo', null, 9);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(13, 'Av. Paula Ferreira', 16620-040, ' Fregeusia do ó', 'São Paulo', 'São Paulo', null, 10);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(14, 'R. Borges Lagoa ', 07060-020, 'Vila Yara', 'Osasco', 'São Paulo', 8, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(15, 'R. Francisca Tavares', 02485-007, 'guarulhos', 'São Paulo', 'São Paulo', 9, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(16, 'Av. Vila Ema ', 02065-010, 'Vila Ema', 'São Paulo', 'São Paulo', 10, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(17, 'R. Manoel Azevedo', 02114-001, 'Vila Guilherme', 'São Paulo', 'São Paulo', null, 4);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(18, 'Av. Edgar facó', 03028-050, 'Vila Iorio', 'São Paulo', 'São Paulo', null, 5);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(19, 'R. Maria Antonieta', 03016-010, 'Bresser', 'São Paulo', 'São Paulo', null, 6);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(20, 'R. Dos Italianos', 0659-321, 'Bom Retiro', 'São Paulo', 'São Paulo', null, 7);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(21, 'R. Afonso Sardinha', 01254-040, 'Lapa', 'São Paulo', 'São Paulo', null, 11);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(22, 'R. Giuseppe Antônio', 02521-000, 'Perdises', 'São Paulo', 'São Paulo', null, 12);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(23, 'Av. Tiradentes ', 02563-010, 'Penha', 'São Paulo', 'São Paulo', null, 13);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(24, 'Av. Francisco  Maarazzo', 02464-600, 'Barra Funda', 'São Paulo', 'São Paulo', null, 14);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(25, 'R. Padre Ayrton', 03206-010, 'Mooca', 'São Paulo', 'São Paulo', null, 15);


-- Inserindo dados na tabela Enfermeiro
--
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(1, 'Sandro Xavier', 74851458, '415884');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(2, 'Arlindo Carvalho', 58749658, '254229');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(3, 'Diogo Silva', 78032145, '011178');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(4, 'Cinthia Andrade', 10455547, '961544');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(5, 'José Aldo', 87488612, '781569');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(6, 'Renato Sousa', 20177896, '829175');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(7, 'Carla Alencar', 12487953, '783596');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(8, 'Danilo Nascimento', 21436001, '254327');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(9, 'Walter Araujo', 74194519, '120358');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(10, 'Samanta Oliveira', 88741414, '251159');


-- Inserindo dados na tabela Consulta
--
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(1, '2015-01-11', '14:40:00', '300.00', 3, 10, 5, 4);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(2, '2016-09-29', '09:00:00', '180.00', 4, 7, 13, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(3, '2017-05-03', '13:30:00', '200.00', 1, 9, 4, 2);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(4, '2018-03-10', '09:30:00', '230.00', 1, 7, 12, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(5, '2018-05-17', '11:00:00', '200.00', 4, 4, 11, 5);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(6, '2018-09-30', '15:00:00', '250.00', 1, 9, 4, 2);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(7, '2019-01-13', '14:30:00', '200.00', null, 7, 1, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(8, '20220-02-01', '16:30:00', '200.00', null, 10, 3, 4);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(9, '2021-03-14', '08:30:00', '250.00', null, 7, 14, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(10, '2021-05-08', '17:00:00', '250.00', null, 6, 14, 2);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(11, '2022-01-16', '09:45:00', '250.00', 4, 4, 13, 5);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(12, '2022-03-07', '13:00:00', '200.00', 4, 9, 11, 2);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(13, '2022-11-12', '09:30:00', '250.00', 3, 7, 5, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(14, '2023-02-20', '08:15:00', '250.00', null, 10, 3, 4);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(15, '2031-02-20', '12:00:00', '250.00', null, 10, 3, 4);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(16, '2021-03-20', '9:15:00', '250.00', 1, 10, 2, 6);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(17, '2022-01-09', '08:00:00', '200.00', 1, 1, 6, 6);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(18, '2022-01-15', '08:45:00', '200.00', 2, 2, 7, 7);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(19, '2023-02-15', '17:00:00', '250.00', null, 8, 8, 1);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(20, '2023-11-29', '11:20:00', '200.00', null, 5, 9, 6);


-- Inserindo dados na tabela Receita
--
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(2, 'Ziagen, Reopro', '2', 'Tomar um comprimido de Ziagen uma vez ao dia. Tomar um comprimido de Reopro uma vez ao dia', 1);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(11, 'Omeprazol e Caverdilol', '2', 'Tomar 2 vez ao dia de manhã, uso continuo. Tomar 1 comprimido a cada 12horas.', 2);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(1, 'Calquence ', '1', 'Tomar um comprimido a cada 6 horas. Não tomar mais de 4 comprimidos no dia', 3);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(3, ' Scetral, Diamox', '2', 'Tomar 1 comprimido de Scetral uma vez ao dia de manhã, durante 4 semanas. Tomar um comprimido de Diamox a cada 6 horas. Não tomar mais de 4 comprimidos no dia', 4);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(4, 'Humira, Soriatane,  Xarope melagrião', '3', 'Tomar um comprimido de Humira a cada 6 horas. Não tomar mais de 4 comprimidos no dia, Tomar 1 comprimido de Soriatane a cada 4 horas. Tomar o xarope se houver tosse', 5);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(5, 'Hepsera, Differin', '2', 'Tomar 2 comprimidos de Hepsera de 10mg + 10 mg por dia. Tomar o Differin uma vez ao dia', 6);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(6, 'Campath e Fosamax', '2', 'Tomar 1 vez ao dia de manhã, durante 4 semanas. Tomar 1 comprimido de Campath a cada 4 horas.', 7);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(7, 'Nesina, Tekturna', '2', 'Tomar um comprimido de Nesina uma vez ao dia. Tomar um comprimido de Tekturna uma vez ao dia', 8);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(8, 'Xanax, Axrt', '2', 'Tomar 1 comprimido de Xanax uma vez ao dia de manhã, durante 4 semanas. Tomar um comprimido de Axrt a cada 6 horas. Não tomar mais de 4 comprimidos no dia', 9);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(9, 'Ethyol, Norvasc', '2', 'Tomar um comprimido de Ethyol a cada 6 horas. Não tomar mais de 4 comprimidos no dia, Tomar 1 comprimido de Norvasc a cada 4 horas. Tomar o xarope se houver tosse', 10);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(10, 'Unasyn, Arimidex', '2', 'Tomar 2 comprimidos de Unasyn de 20 mg + 20 mg por dia. Tomar o Arimidex uma vez ao dia', 11);


-- Inserindo dados na tabela Quarto
--
insert into quarto(id_quarto, numero, tipo_id) values(1, 02, 1);
insert into quarto(id_quarto, numero, tipo_id) values(2, 03, 2);
insert into quarto(id_quarto, numero, tipo_id) values(3, 04, 3);
insert into quarto(id_quarto, numero, tipo_id) values(4, 05, 3);
insert into quarto(id_quarto, numero, tipo_id) values(5, 10, 1);


-- Inserindo dados na tabela Internacao
--
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (1, '2014-01-01', '2014-01-21', '2014-01-23', 'TRATAMENTO DE EDEMA PULONAR', 8, 5, 2);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (2, '2015-03-11', '2015-03-27', '2015-04-07', 'TRATAMENTO DE HEPATITE C', 1, 10, 5);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (3, '2016-08-18', '2016-05-15', '2015-08-26', 'TRATAMENTO DE PNEUMONIA', 8, 5, 2);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (4, '2017-04-02', '2017-07-10', '2017-07-15', 'TRATAMENTO DE INFECÇÂO PELO NOVO CORONAVÍRUS - COVID 19', 15, 3, 1);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (5, '2018-01-12', '2018-01-12', '2018-01-12', 'REALIZAÇÃO ELETROCARDIOGRAMA', 1, 6, 3);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (6, '2019-02-22', '2019-02-27', '2019-02-25', 'TRASPLAMENTE DE CORAÇÃO', 7, 9, 4);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (7, '2020-03-14', '2020-03-20', '2020-03-28', 'TRATAMENTO DE ANEMIA', 13, 8,5);


-- Inserindo dados na tabela Plantão
--
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (1, '2015-01-01', '07:00:00', 1, 2);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (2, '2015-01-01', '19:00:00', 1, 7);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (3, '2016-05-21', '8:00:00', 2, 8);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (4, '2016-08-18', '22:00:00', 3, 5);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (5, '2016-08-19', '07:00:00', 3, 1);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (6, '2018-07-02', '07:00:00', 4, 9);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (7, '2018-07-02', '22:00:00', 4, 7);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (8, '2020-01-01', '14:00:00', 5, 6);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (9, '2021-01-02', '00:00:00', 5, 3);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (10, '2021-05-21', '10:00:00', 2, 3);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (11, '2022-02-22', '22:00:00', 6, 4);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (12, '2022-02-23', '17:00:00', 6, 8);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (13, '2023-02-22', '13:00:00', 7, 3);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (14, '2023-02-22', '15:00:00', 7, 1);





