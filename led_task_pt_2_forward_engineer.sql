-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`vacina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vacina` (
  `cod` SMALLINT(4) NOT NULL,
  `nome` VARCHAR(45) NULL,
  `fabricante_referencia` VARCHAR(45) NULL,
  `fabricante_nome` VARCHAR(45) NULL,
  PRIMARY KEY (`cod`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`raca_cor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`raca_cor` (
  `cod` SMALLINT(4) NOT NULL,
  `valor` VARCHAR(45) NULL,
  PRIMARY KEY (`cod`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`municipio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`municipio` (
  `cod_ibge` SMALLINT(4) NOT NULL,
  `nome` VARCHAR(45) NULL,
  `cod_pais` SMALLINT(4) NULL,
  `nome_pais` VARCHAR(45) NULL,
  `uf` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_ibge`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`paciente` (
  `id` VARCHAR(45) NOT NULL,
  `idade` SMALLINT(4) NULL,
  `data_nascimento` DATE NULL,
  `sexo_biologico` CHAR(1) NULL,
  `racacor_cod` SMALLINT(4) NULL,
  `endereco_codibge` SMALLINT(4) NULL,
  `nacionalidade` CHAR(1) NULL,
  `cep` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_paciente_raca_cor1_idx` (`racacor_cod` ASC) VISIBLE,
  INDEX `fk_paciente_municipio1_idx` (`endereco_codibge` ASC) VISIBLE,
  CONSTRAINT `fk_paciente_raca_cor1`
    FOREIGN KEY (`racacor_cod`)
    REFERENCES `mydb`.`raca_cor` (`cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_municipio1`
    FOREIGN KEY (`endereco_codibge`)
    REFERENCES `mydb`.`municipio` (`cod_ibge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`estabelecimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`estabelecimento` (
  `estabelecimento_valor` INT NOT NULL,
  `razao_social` VARCHAR(45) NULL,
  `nome_fantasia` VARCHAR(45) NULL,
  `municipio_codibge` SMALLINT(4) NULL,
  PRIMARY KEY (`estabelecimento_valor`),
  INDEX `fk_estabelecimento_municipio1_idx` (`municipio_codibge` ASC) VISIBLE,
  CONSTRAINT `fk_estabelecimento_municipio1`
    FOREIGN KEY (`municipio_codibge`)
    REFERENCES `mydb`.`municipio` (`cod_ibge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`categoria_grupo_de_vacinacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categoria_grupo_de_vacinacao` (
  `cod` SMALLINT(4) NOT NULL,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`cod`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`grupo_atendimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`grupo_atendimento` (
  `id` SMALLINT(4) NOT NULL,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vacinacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vacinacao` (
  `document_id` INT NOT NULL,
  `paciente_id` VARCHAR(45) NULL,
  `data_aplicacao` DATE NULL,
  `estabelecimento_valor` INT NULL,
  `vacina_categoria_cod` SMALLINT(4) NULL,
  `grupo_atendimento_cod` SMALLINT(4) NULL,
  `vacina_lote` INT NULL,
  `vacina_descr_dose` VARCHAR(45) NULL,
  `vacina_cod` SMALLINT(4) NULL,
  `sistema_origem` VARCHAR(45) NULL,
  `data_importacao_rnds` DATE NULL,
  PRIMARY KEY (`document_id`),
  INDEX `fk_vacinacao_vacina_idx` (`vacina_cod` ASC) VISIBLE,
  INDEX `fk_vacinacao_paciente1_idx` (`paciente_id` ASC) VISIBLE,
  INDEX `fk_vacinacao_estabelecimento1_idx` (`estabelecimento_valor` ASC) VISIBLE,
  INDEX `fk_vacinacao_categoria_grupo_de_vacinacao1_idx` (`vacina_categoria_cod` ASC) VISIBLE,
  INDEX `fk_vacinacao_grupo_atendimento1_idx` (`grupo_atendimento_cod` ASC) VISIBLE,
  CONSTRAINT `fk_vacinacao_vacina`
    FOREIGN KEY (`vacina_cod`)
    REFERENCES `mydb`.`vacina` (`cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vacinacao_paciente1`
    FOREIGN KEY (`paciente_id`)
    REFERENCES `mydb`.`paciente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vacinacao_estabelecimento1`
    FOREIGN KEY (`estabelecimento_valor`)
    REFERENCES `mydb`.`estabelecimento` (`estabelecimento_valor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vacinacao_categoria_grupo_de_vacinacao1`
    FOREIGN KEY (`vacina_categoria_cod`)
    REFERENCES `mydb`.`categoria_grupo_de_vacinacao` (`cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vacinacao_grupo_atendimento1`
    FOREIGN KEY (`grupo_atendimento_cod`)
    REFERENCES `mydb`.`grupo_atendimento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
