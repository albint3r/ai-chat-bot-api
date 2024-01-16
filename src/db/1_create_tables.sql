CREATE DATABASE IF NOT EXISTS chat;
USE chat;

ALTER USER 'root'@'%' IDENTIFIED WITH 'mysql_native_password' BY 'root';

CREATE TABLE users (
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id VARCHAR(36) DEFAULT (UUID()) PRIMARY KEY UNIQUE,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(60) NOT NULL,
    name VARCHAR(50) NOT NULL DEFAULT "",
    last_name VARCHAR(50) NOT NULL DEFAULT "",
    is_verify BOOLEAN DEFAULT FALSE
);

CREATE TABLE companies (
    company_id VARCHAR(36) DEFAULT (UUID()) PRIMARY KEY UNIQUE,
    company_name VARCHAR(50) NOT NULL
);

CREATE TABLE data_vectors (
    data_vector_id VARCHAR(36) DEFAULT (UUID()) PRIMARY KEY UNIQUE,
    user_id CHAR(36),
    company_id VARCHAR(50) NOT NULL,
    api_key VARCHAR(100) NOT NULL,
    environment VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (company_id) REFERENCES companies(company_id) ON DELETE CASCADE
);







