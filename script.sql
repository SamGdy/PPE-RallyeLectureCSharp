-- MySQL Script generated by MySQL Workbench
-- Wed Sep 26 16:17:53 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema rallyeLecture
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema rallyeLecture
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rallyeLecture` DEFAULT CHARACTER SET utf8 ;
USE `` ;

-- -----------------------------------------------------
-- Table `rallyeLecture`.`auteur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rallyeLecture`.`auteur` (
  `id` INT(11) NOT NULL,
  `nom` VARCHAR(60) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rallyeLecture`.`editeur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rallyeLecture`.`editeur` (
  `id` INT(11) NOT NULL,
  `nom` VARCHAR(60) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rallyeLecture`.`quizz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rallyeLecture`.`quizz` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `idFiche` INT(11) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idFiche_UNIQUE` (`idFiche` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rallyeLecture`.`livre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rallyeLecture`.`livre` (
  `id` INT(11) NOT NULL,
  `titre` VARCHAR(45) NOT NULL,
  `couverture` VARCHAR(45) NULL,
  `idAuteur` INT(11) NOT NULL,
  `idEditeur` INT(11) NOT NULL,
  `idQuizz` INT(11) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_livre_auteur_idx` (`idAuteur` ASC),
  INDEX `fk_livre_editeur1_idx` (`idEditeur` ASC),
  INDEX `fk_livre_quizz1_idx` (`idQuizz` ASC),
  UNIQUE INDEX `quizz_id_UNIQUE` (`idQuizz` ASC),
  CONSTRAINT `fk_livre_auteur`
    FOREIGN KEY (`idAuteur`)
    REFERENCES `rallyeLecture`.`auteur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_livre_editeur1`
    FOREIGN KEY (`idEditeur`)
    REFERENCES `rallyeLecture`.`editeur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_livre_quizz1`
    FOREIGN KEY (`idQuizz`)
    REFERENCES `rallyeLecture`.`quizz` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rallyeLecture`.`rallye`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rallyeLecture`.`rallye` (
  `id` INT(11) NOT NULL,
  `dateDebut` DATE NULL,
  `duree` INT NULL,
  `theme` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rallyeLecture`.`comporter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rallyeLecture`.`comporter` (
  `idLivre` INT NOT NULL,
  `idRallye` INT(11) NOT NULL,
  PRIMARY KEY (`idLivre`, `idRallye`),
  INDEX `fk_comporter_livre1_idx` (`idLivre` ASC),
  INDEX `fk_comporter_rallye1_idx` (`idRallye` ASC),
  CONSTRAINT `fk_comporter_livre1`
    FOREIGN KEY (`idLivre`)
    REFERENCES `rallyeLecture`.`livre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comporter_rallye1`
    FOREIGN KEY (`idRallye`)
    REFERENCES `rallyeLecture`.`rallye` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rallyeLecture`.`enseignant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rallyeLecture`.`enseignant` (
  `id` INT(11) NOT NULL,
  `nom` VARCHAR(45) NULL,
  `prenom` VARCHAR(45) NULL,
  `login` VARCHAR(100) NULL,
  `idAuth` INT(11) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rallyeLecture`.`question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rallyeLecture`.`question` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `question` VARCHAR(255) NOT NULL,
  `points` INT(11) NOT NULL,
  `idQuizz` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_question_quizz1_idx` (`idQuizz` ASC),
  CONSTRAINT `fk_question_quizz1`
    FOREIGN KEY (`idQuizz`)
    REFERENCES `rallyeLecture`.`quizz` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rallyeLecture`.`proposition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rallyeLecture`.`proposition` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `proposition` VARCHAR(255) NOT NULL,
  `solution` INT(11) NOT NULL DEFAULT 0,
  `idQuestion` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_proposition_question1_idx` (`idQuestion` ASC),
  CONSTRAINT `fk_proposition_question1`
    FOREIGN KEY (`idQuestion`)
    REFERENCES `rallyeLecture`.`question` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rallyeLecture`.`niveau`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rallyeLecture`.`niveau` (
  `id` INT(11) NOT NULL,
  `niveauScolaire` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rallyeLecture`.`classe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rallyeLecture`.`classe` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `anneeScolaire` VARCHAR(45) NULL,
  `idEnseignant` INT(11) NOT NULL,
  `idNiveau` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_classe_enseignant1_idx` (`idEnseignant` ASC),
  INDEX `fk_classe_niveau1_idx` (`idNiveau` ASC),
  CONSTRAINT `fk_classe_enseignant1`
    FOREIGN KEY (`idEnseignant`)
    REFERENCES `rallyeLecture`.`enseignant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_classe_niveau1`
    FOREIGN KEY (`idNiveau`)
    REFERENCES `rallyeLecture`.`niveau` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rallyeLecture`.`eleve`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rallyeLecture`.`eleve` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `prenom` VARCHAR(45) NULL,
  `login` VARCHAR(45) NULL,
  `idAuth` INT(11) NULL,
  `idClasse` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_eleve_classe1_idx` (`idClasse` ASC),
  CONSTRAINT `fk_eleve_classe1`
    FOREIGN KEY (`idClasse`)
    REFERENCES `rallyeLecture`.`classe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rallyeLecture`.`participer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rallyeLecture`.`participer` (
  `rallye_id` INT(11) NOT NULL,
  `eleve_id` INT(11) NOT NULL,
  PRIMARY KEY (`rallye_id`, `eleve_id`),
  INDEX `fk_participer_eleve1_idx` (`eleve_id` ASC),
  CONSTRAINT `fk_participer_rallye1`
    FOREIGN KEY (`rallye_id`)
    REFERENCES `rallyeLecture`.`rallye` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_participer_eleve1`
    FOREIGN KEY (`eleve_id`)
    REFERENCES `rallyeLecture`.`eleve` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rallyeLecture`.`reponse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rallyeLecture`.`reponse` (
  `idPropostion` INT(11) NOT NULL,
  `question_id` INT(11) NOT NULL,
  `participer_rallye_id` INT(11) NOT NULL,
  `participer_eleve_id` INT(11) NOT NULL,
  PRIMARY KEY (`idPropostion`, `question_id`, `participer_rallye_id`, `participer_eleve_id`),
  INDEX `fk_reponse_proposition1_idx` (`idPropostion` ASC),
  INDEX `fk_reponse_question1_idx` (`question_id` ASC),
  INDEX `fk_reponse_participer1_idx` (`participer_rallye_id` ASC, `participer_eleve_id` ASC),
  CONSTRAINT `fk_reponse_proposition1`
    FOREIGN KEY (`idPropostion`)
    REFERENCES `rallyeLecture`.`proposition` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reponse_question1`
    FOREIGN KEY (`question_id`)
    REFERENCES `rallyeLecture`.`question` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reponse_participer1`
    FOREIGN KEY (`participer_rallye_id` , `participer_eleve_id`)
    REFERENCES `rallyeLecture`.`participer` (`rallye_id` , `eleve_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
